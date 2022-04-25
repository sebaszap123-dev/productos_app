import 'package:flutter/material.dart';

class ButtonByFernando extends StatelessWidget {
  const ButtonByFernando({
    Key? key,
    required this.route,
    required this.text,
  }) : super(key: key);

  final String route;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.8)),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
      onPressed: () => Navigator.pushReplacementNamed(context, route),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.8)),
      ),
    );
  }
}
