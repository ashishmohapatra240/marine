import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminCheck extends StatefulWidget {
  @override
  _AdminCheckState createState() => _AdminCheckState();
}

class _AdminCheckState extends State<AdminCheck> {
  final pHController = TextEditingController();
  final hardnessController = TextEditingController();
  final tdsController = TextEditingController();
  final chloraminesController = TextEditingController();
  final sulfateController = TextEditingController();
  final conductivityController = TextEditingController();
  final organicCarbonController = TextEditingController();
  final trihalomethanesController = TextEditingController();
  final turbidityController = TextEditingController();

  Future<String> _sendDataAndGetResult() async {
    final data = jsonEncode({
      'data': [
        double.parse(pHController.text),
        double.parse(hardnessController.text),
        double.parse(tdsController.text),
        double.parse(chloraminesController.text),
        double.parse(sulfateController.text),
        double.parse(conductivityController.text),
        double.parse(organicCarbonController.text),
        double.parse(trihalomethanesController.text),
        double.parse(turbidityController.text),
      ]
    });

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/acidify'),
      headers: {'Content-Type': 'application/json'},
      body: data,
    );

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Potability Checker'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // pH value input
              TextField(
                controller: pHController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'pH value',
                ),
              ),

              TextField(
                controller: hardnessController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Hardness',
                ),
              ),

              TextField(
                controller: tdsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Total dissolved solids (TDS)',
                ),
              ),

              TextField(
                controller: chloraminesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Chloramines',
                ),
              ),

              TextField(
                controller: sulfateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Sulfate',
                ),
              ),

              TextField(
                controller: conductivityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Conductivity',
                ),
              ),

              TextField(
                controller: organicCarbonController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Organic Carbon',
                ),
              ),

              TextField(
                controller: trihalomethanesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Trihalomethanes',
                ),
              ), // Turbidity input
              TextField(
                controller: turbidityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Turbidity',
                ),
              ),

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () async {
                  final result = await _sendDataAndGetResult();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Result'),
                      content: Text(result),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Check Potability'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
