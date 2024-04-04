import 'package:flutter/material.dart';

class ReceptCard extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  ReceptCard({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(Icons.arrow_forward), // Menambahkan ikon pada leading
          title: Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
