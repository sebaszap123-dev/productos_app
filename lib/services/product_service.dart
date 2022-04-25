import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier {
  final String _baseUrl = "flutter-productos-7a389-default-rtdb.firebaseio.com";
  final List<Product> products = [];
  late Product selectedProduct;
  final storage = FlutterSecureStorage();
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;
  ProductsServices() {
    this.loadProducts();
  }
  // <List<Products>>
  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    final token = await storage.read(key: 'token');
    final url = Uri.https(_baseUrl, 'products.json', {'auth': token});
    final response = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(response.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });
    this.isLoading = false;
    notifyListeners();
    return this.products;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      // Es necesario crear
      await createProduct(product);
    } else {
      // Actualizar
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final token = await storage.read(key: 'token');
    final url =
        Uri.https(_baseUrl, 'products/${product.id}.json', {'auth': token});
    final response = await http.put(url, body: product.toJson());
    final decodeData = response.body;
    print(decodeData);
    final index = products.indexWhere((elements) => elements.id == product.id);
    products[index] = product;
    // TODO: Actualizar el listado de productos
    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final response = await http.post(url, body: product.toJson());
    final decodeData = json.decode(response.body);
    print(decodeData);
    product.id = decodeData['name'];
    print(product);
    products.add(product);
    // products.add(product);
    // TODO: Actualizar el listado de productos
    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    isSaving = true;
    notifyListeners();
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dq7vbgnwj/image/upload?upload_preset=rdmxfwt0');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal, ${resp.body}');
      return null;
    }
    final responseData = json.decode(resp.body);
    return responseData['secure_url'];
  }
}
