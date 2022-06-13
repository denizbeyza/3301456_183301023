import 'package:flutter/material.dart';

class InfoMessageWidget extends StatelessWidget {
  const InfoMessageWidget({Key? key,required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        const Icon(
          Icons.info,
          color: Colors.blue,
          size: 100,
        ),
        Text(message)
      ],
    );
  }
}