import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String prediction = '';

  Future<void> fetchPrediction(String inputData) async {
    final response = await http.post(
      Uri.parse('http://localhost:3307/api/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'data': inputData}), // 사용자 데이터 전송
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        prediction = result['prediction'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Web ML Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                fetchPrediction("user_input_data"); // 사용자 입력 데이터 전달
              },
              child: Text('Get Prediction'),
            ),
            Text('Prediction: $prediction'),
          ],
        ),
      ),
    );
  }
}
