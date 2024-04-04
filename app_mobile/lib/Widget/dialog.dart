import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomDialog({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
Widget build(BuildContext context) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: <Widget>[
      InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 33, 144, 255),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}
}