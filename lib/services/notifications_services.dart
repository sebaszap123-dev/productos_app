import 'package:flutter/material.dart';
import 'package:productos_app/ui/parse_error_message.dart';

class NotificationsServices {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(ErrorMessage.parseMessage(message),
          style: TextStyle(color: Colors.white, fontSize: 20)),
      backgroundColor: Colors.indigoAccent,
      elevation: 0,
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
