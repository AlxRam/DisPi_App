import 'package:flutter/material.dart';

class Wip extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF590E11),
      body: Padding(
        padding: EdgeInsets.only(top:250),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  width: 150,
                  height: 150,
                  child: FittedBox(child: Icon(Icons.directions_walk_outlined,color: Color(0xFFD9CEA1)))),
              Text('Trabajo en proceso',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD9CEA1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
