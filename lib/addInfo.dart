import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Addinfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

   Addinfo({ required this.icon , required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(label),
          Text(
           value,
            style: TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

