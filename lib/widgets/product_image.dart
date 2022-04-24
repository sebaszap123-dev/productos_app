import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        decoration: _boxDecoProductImage(),
        width: double.infinity,
        height: 400,
        child: ClipRRect(
          borderRadius: _borderRadiusImage(),
          child: FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage('https://via.placeholder.com/400x300/green'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoProductImage() => BoxDecoration(
          color: Colors.indigo,
          borderRadius: _borderRadiusImage(),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);

  BorderRadius _borderRadiusImage() {
    return BorderRadius.only(
      topLeft: Radius.circular(45),
      topRight: Radius.circular(45),
    );
  }
}
