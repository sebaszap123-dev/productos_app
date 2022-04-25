import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsServices>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    if (productService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Productos'),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logOut();
              Navigator.of(context).pushReplacementNamed('login');
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
      ),
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
        onPressed: () {
          productService.selectedProduct =
              Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
