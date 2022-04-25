import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
        body: FutureBuilder(
      future: authService.isAuth(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.data == '') {
          Future.microtask(() {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => LoginScreen(),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          });
        } else {
          Future.microtask(() {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => HomeScreen(),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          });
        }

        return Container(child: Text(''));
        // return Container(
        //   child: Text('Espere...'),
        // );
      },
    ));
  }
}
