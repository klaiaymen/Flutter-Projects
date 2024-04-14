import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String text1;
  final String text2;
  final int val1;
  final bool val2;
  // receive data from the FirstScreen as a parameter
  SecondScreen({required this.text1,required this.text2, required this.val1, required this.val2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second screen')),
      body: Column(children: [
        Text(
          text1,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          text2,
          style: TextStyle(fontSize: 16),
        ),
        Text(val1 == 1 ? 'Homme' : 'Femme'),
        Text(val2 ? 'Java' : 'C++', style: TextStyle(fontSize: 16))
      ]),
    );
  }
}
