import 'package:flutter/material.dart';

class ButtomRequestItem extends StatelessWidget {
  const ButtomRequestItem({
    super.key,
    required this.title,
    required this.color,
    required this.onPressed,
  });
  final String title;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(60, 33),
        backgroundColor: Colors.white,
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color, width: 1.0),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: color,
        ),
      ),
    );
  }
}
