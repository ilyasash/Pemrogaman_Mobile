import 'package:flutter/material.dart';

class ReceptCard extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final void Function() onEdit;
  final void Function() onDelete;

  ReceptCard({
    required this.text,
    required this.onPressed,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(Icons.arrow_forward),
          title: Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 20.0,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
