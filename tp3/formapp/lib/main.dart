import 'package:flutter/material.dart';
import 'package:formapp/screen2.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter',
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool value1 = false;
  bool value2 = false;

  TextEditingController textFieldController = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();

  int val = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First screen')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your first name',
                  labelText: 'First Name',
                ),
                controller: textFieldController,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your last name',
                  labelText: 'Last Name',
                ),
                controller: textFieldController2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Female"),
                    leading: Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value as int;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                  ListTile(
                    title: Text("Male"),
                    leading: Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value as int;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Java',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Checkbox(
                    value: value1,
                    onChanged: (bool? value) {
                      setState(() {
                        value1 = value as bool;
                      });
                    },
                  ),
                  Text(
                    'C++',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Checkbox(
                    value: value2,
                    onChanged: (bool? value) {
                      setState(() {
                        value2 = value as bool;
                      });
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text(
                'Go to second screen',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                _sendDataToSecondScreen(context);
              },
            )
          ],
        ),
      ),
    );
  }

  // get the text in the TextField and start the Second Screen
  void _sendDataToSecondScreen(BuildContext context) {
    String textToSend = textFieldController.text;
    String textToSend2 = textFieldController2.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
              text1: textToSend, text2: textToSend, val1: val, val2: value1),
        ));
  }
}
