import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/box_shadow.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productService = Provider.of<ProductsServices>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductsScreenBody(
        productService: productService,
        size: size,
      ),
    );
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    Key? key,
    required this.productService,
    required this.size,
  }) : super(key: key);

  final ProductsServices productService;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // cerrar el teclado al movers el scroll
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(
                    url: productService.selectedProduct.picture,
                  ),
                  _ArrowBack(),
                  _Camera(),
                ],
              ),
              _ProductForm(),
              SizedBox(height: size.height * 0.2),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!formProvider.isValidForm()) return;
          await productService.saveOrCreateProduct(formProvider.product);
        },
        child: Icon(Icons.save_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);
    final product = formProvider.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        // height: 200, // buscar determinar
        decoration: _buildBoxDecoration(),
        child: Form(
            key: formProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                    return null;
                  },
                  autocorrect: true,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del producto', labelText: 'Nombre:'),
                ),
                SizedBox(height: 30),
                TextFormField(
                  initialValue: '\$${product.price}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$150', labelText: 'Precio:'),
                ),
                SizedBox(height: 15),
                // TODO: pendeinte switch
                SwitchListTile.adaptive(
                  value: product.available,
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: formProvider.updateAvailability,
                ),
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        boxShadow: BoxShadowApp.boxShadowProduct,
      );
}

class _Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      right: 20,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.camera_alt_outlined,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ArrowBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 20,
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
