// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import runApp;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final TextEditingController inputController = TextEditingController();
//   String result = '';

//   void sendRequestToPythonServer() async {
//     final input = inputController.text;
//     final url = Uri.parse(
//         'http://your-python-server-url/endpoint'); // Python 서버의 엔드포인트 URL

//     final response = await http.post(
//       url,
//       body: json.encode({'input_data': input}),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         result = data['result'];
//       });
//     } else {
//       setState(() {
//         result = 'Error: ${response.reasonPhrase}';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Web ML Integration'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextField(
//                 controller: inputController,
//                 decoration: InputDecoration(labelText: 'Input Data'),
//               ),
//               ElevatedButton(
//                 onPressed: sendRequestToPythonServer,
//                 child: Text('Get Result'),
//               ),
//               Text('Result: $result'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
