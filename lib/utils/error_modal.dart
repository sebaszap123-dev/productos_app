import 'package:flutter/material.dart';
import 'package:productos_app/dialog/animated_dialog.dart';
import 'package:productos_app/dialog/error_dialog_content.dart';

const defaultErrorMessage = 'A ocurrido un error';

void showErrorModal(BuildContext context,
    [String message = defaultErrorMessage]) {
  showDialog(
    context: context,
    builder: (_) => AnimatedDialog(
      child: ErrorDialogContent(message: message),
    ),
  );
}
