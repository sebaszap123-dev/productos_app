import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsServices>(context);
    if (productService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(title: Text('Productos')),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: productService.products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ProductCard(
              product: productService.products[index],
            ),
            onTap: () {
              // se asigna el copy al selectedProduct para romper la referencia
              productService.selectedProduct =
                  productService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
