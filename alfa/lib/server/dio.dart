// import 'dart:ffi';

import 'dart:convert';

import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:alfa/view/widgets/home/login/Form_login.dart';
import '../provider/shared.dart';
import 'package:http/http.dart' as http;

const url = "http://172.30.1.29:8889";
const flaskUrl = "http://localhost:5000/result";

class Server {
  Future login(String user_id, String user_pw) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post("$url/user/login",
        data: {"user_id": "$user_id", "user_pw": "$user_pw"});
    // print(response.data['data'][0]);
    if (response.data['result'] == "success") {
      print('successRes : ' + response.data['data'][0]['user_id']);
      String user_name = response.data['data'][0]['user_name'];
      String user_email = response.data['data'][0]['user_id'];
      String user_num = response.data['data'][0]['user_num'];
      String user_type = response.data['data'][0]['user_type'];
      // print('res : ' + response.data[0]['user_pw']);
      // print('res : ' + response.data[0].toString());
      await DataManager.saveData('name', user_name);
      await DataManager.saveData('id', user_email);
      await DataManager.saveData('num', user_num);
      await DataManager.saveData('type', user_type);
    } else if (response.data['result'] == "pw err") {
      await DataManager.saveData('id', 'null');
      print('failedRes : 비밀번호를 잘못 입력함');
    } else if (response.data['result'] == 'empty id') {
      print('failedRes : 아이디가 없음');
    }
  }

  Future join(String user_id, String user_pw, String user_name,
      String? user_num) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post("$url/user/create", data: {
      "user_id": "$user_id",
      "user_pw": "$user_pw",
      "user_name": "$user_name",
      "user_num": "$user_num"
    });
    String result = response.data['result'];
    await DataManager.saveData('joinResult', result);
    if (result == "success") {
      print('successRes : $result');

      // } else if (response.data['result'] == "pw err") {
      //   print('failedRes : 비밀번호를 잘못 입력함');
    } else if (result == "failed") {
      print('successRes : $result');
    }

    // User user = Provider.of<User>(context, listen: false);
  }

  Future modify(String user_id, String user_num, String user_pw) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post("$url/user/modify", data: {
      "user_id": "$user_id",
      "user_pw": "$user_pw",
      "user_num": "$user_num"
    });

    String result = response.data['modifyRes'];

    if (result == "success") {
      print('modifyRes : $result');
      String user_name = response.data['data'][0]['user_name'];
      String user_email = response.data['data'][0]['user_id'];
      String user_num = response.data['data'][0]['user_num'];
      // print('res : ' + response.data[0]['user_pw']);
      // print('res : ' + response.data[0].toString());
      await DataManager.saveData('name', user_name);
      await DataManager.saveData('id', user_email);
      await DataManager.saveData('num', user_num);
      // } else if (response.data['result'] == "pw err") {
      //   print('failedRes : 비밀번호를 잘못 입력함');
    } else if (result == "failed") {
      print('modifyRes : $result');
    }

    // User user = Provider.of<User>(context, listen: false);
  }

  Future insertAl(var tens, var yiel, var hard, var elongation) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post("$url/main/stepOne", data: {
      "tens": "$tens",
      "yield": "$yiel",
      "hard": "$hard",
      "elongation": "$elongation"
    });
    String result = response.data['stepOne'];
    await DataManager.saveData('stepOne', result);
    if (result == "success") {
      print('stepOne : $result');

      void sendDataToPython() async {
        var uri = Uri.http('localhost:5000', '/result');
        final response = await http.post(uri,
            headers: {
              "Access-Control-Allow-Origin":
                  "*", // Required for CORS support to work
              // "Access-Control-Allow-Credentials":
              //     true, // Required for cookies, authorization headers with HTTPS
              // "Access-Control-Allow-Headers":
              //     "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
              // "Access-Control-Allow-Methods": "POST",
              "content-type": "application/json"
            },
            body: jsonEncode({
              "tens": "$tens",
              "yield": "$yiel",
              "hard": "$hard",
              "elongation": "$elongation"
            }));
        if (response.statusCode == 200) {
          // 성공적으로 서버에서 응답을 받았을 때 실행할 코드
          print('서버 응답: ${response.body}');
        } else {
          // 요청이 실패했을 때 실행할 코드
          print('서버 요청 실패: ${response.statusCode}');
        }
      }

      sendDataToPython();
      // } else if (response.data['result'] == "pw err") {
      //   print('failedRes : 비밀번호를 잘못 입력함');
    } else if (result == "failed") {
      print('stepOne : $result');
    }

    // User user = Provider.of<User>(context, listen: false);
  }
}

Server server = Server();
