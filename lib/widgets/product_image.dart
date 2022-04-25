import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/ui/box_shadow.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Container(
        decoration: _boxDecoProductImage(),
        width: double.infinity,
        height: 400,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
              borderRadius: _borderRadiusImage(), child: getImage(url)),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoProductImage() => BoxDecoration(
        color: Colors.black,
        borderRadius: _borderRadiusImage(),
        boxShadow: BoxShadowApp.boxShadowProduct,
      );

  BorderRadius _borderRadiusImage() {
    return BorderRadius.only(
      topLeft: Radius.circular(45),
      topRight: Radius.circular(45),
    );
  }

  Widget getImage(String? picture) {
    if (picture == null) {
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
    }
    if (picture.startsWith('http')) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(url!),
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(picture),
      fit: BoxFit.cover,
      
    );
  }
}
