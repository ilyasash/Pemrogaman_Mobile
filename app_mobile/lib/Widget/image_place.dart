import 'package:flutter/material.dart';

class imageplaceView extends StatelessWidget {
  final String imageUrl;
  final double size;
  final void Function() onPressed;

  const imageplaceView({
    required this.imageUrl,
    this.size = 200,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0), // Sesuaikan dengan keinginan Anda
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imageUrl),
          ),
        ),
      ),
    );
  }
}
