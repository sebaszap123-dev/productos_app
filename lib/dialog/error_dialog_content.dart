import 'package:flutter/material.dart';

class ErrorDialogContent extends StatelessWidget {
  const ErrorDialogContent({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _DialogTitle(),
          const _DialogIcon(),
          _DialogText(message: message),
          const _DialogAction()
        ],
      ),
    );
  }
}

class _DialogAction extends StatelessWidget {
  const _DialogAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Aceptar',
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class _DialogText extends StatelessWidget {
  const _DialogText({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        message,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class _DialogIcon extends StatelessWidget {
  const _DialogIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Icon(Icons.error_outline_outlined),
      ),
    );
  }
}

class _DialogTitle extends StatelessWidget {
  const _DialogTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'Error',
        style: Theme.of(context)
            .textTheme
            .headline1
            ?.copyWith(color: Colors.black),
      ),
    );
  }
}
