import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({Key? key,required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        const Icon(
          Icons.warning,
          color: Colors.red,
          size: 100,
        ),
        Text(message)
      ],
    );
  }
}