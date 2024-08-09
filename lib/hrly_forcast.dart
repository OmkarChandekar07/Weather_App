import 'package:flutter/material.dart';

class cards extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;

   cards({required this.time ,required this.icon ,required this.temp});
   
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(time,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Icon(icon,
                size: 30,
              ),
              Text(temp),
            ],
          ),
          height: 105,
          width: 90,
          decoration: BoxDecoration(
            color: Color.fromARGB(247, 34, 32, 39),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
