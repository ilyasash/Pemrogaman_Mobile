import 'package:flutter/material.dart';

class ImagePlaceView extends StatelessWidget {
  final String imageUrl;
  final double size;
  final void Function() onPressed;

  const ImagePlaceView({
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
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imageUrl),
          ),
        ),
      ),
    );
  }
}
