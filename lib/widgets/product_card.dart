import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        // color: Colors.blue,
        decoration: _decoBorderCard(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(
              url: product.picture,
            ),
            _ProductDeatils(
              product: product,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(
                price: product.price,
              ),
            ),
            if (!product.available)
              Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable(),
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoBorderCard() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 7))
        ]);
  }
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('No disponible',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
        width: 100,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ));
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '\$$price',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        width: 100,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ));
  }
}

class _ProductDeatils extends StatelessWidget {
  final Product product;

  const _ProductDeatils({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        // color: Colors.indigo,
        decoration: _decoProductDet(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5),
            Text(
              product.id ?? 'error',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoProductDet() => BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage({this.url});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
            ? Image(fit: BoxFit.cover, image: AssetImage('assets/no-image.png'))
            : _ShowImage(url: url!),
      ),
    );
  }
}

class _ShowImage extends StatelessWidget {
  const _ShowImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.contain,
      placeholder: AssetImage('assets/jar-loading.gif'),
      image: NetworkImage(
        url,
      ),
    );
  }
}
