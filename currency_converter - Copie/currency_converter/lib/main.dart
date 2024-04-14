import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(CurrencyConverterApp());

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primaryColor:
            Colors.blue, // Changez la couleur principale selon vos préférences
        colorScheme: ThemeData.light().colorScheme.copyWith(
              secondary: Colors
                  .green, // Changez la couleur d'accentuation selon vos préférences
            ),
        fontFamily: 'Roboto', // Changez la police selon vos préférences
      ),
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String selectedCurrency = 'USD';
  double amountToConvert = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amountToConvert = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCurrency = newValue!;
                });
              },
              items: ['USD', 'EUR', 'GBP', 'JPY', 'TND'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                convertCurrency();
              },
              child: Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> convertCurrency() async {
    final apiKey = 'bc43fda0e152d7aedba45b3b'; // Remplacez par votre clé API
    final apiUrl = 'https://api.exchangerate-api.com/v4/latest/USD';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('rates')) {
        final rates = Map<String, dynamic>.from(data['rates']);
        final double exchangeRate = rates[selectedCurrency];
        final double convertedAmount = amountToConvert * exchangeRate;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Conversion Result'),
              content: Text(
                  '$amountToConvert USD = $convertedAmount $selectedCurrency'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Gérer l'absence du tableau 'rates' dans la réponse
      }
    } else {
      // Gérer les erreurs de requête HTTP
    }
  }
}
