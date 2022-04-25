import 'package:flutter/material.dart';
class MyButtonRL extends StatelessWidget {
  const MyButtonRL({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.indigo.withOpacity(0.8)),
      child: TextButton(
        onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
        child: Text(
          '¿Ya tienes una cuenta? Ingresar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
