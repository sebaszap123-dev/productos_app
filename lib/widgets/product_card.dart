import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

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
            _BackgroundImage(),
            _ProductDeatils(),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(),
            ),
            // TODO: Mostrar de manera condicional
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
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('\$103333.99',
                style: TextStyle(color: Colors.white, fontSize: 20)),
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
              'Unidad de estado solido',
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
              'ID del producto',
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
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(
            'https://via.placeholder.com/400x300/f6f6f6',
          ),
        ),
      ),
    );
  }
}
