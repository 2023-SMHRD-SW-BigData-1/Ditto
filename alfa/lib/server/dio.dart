import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:alfa/view/widgets/home/login/Form_login.dart';
// import 'package:provider/provider.dart';

import '../provider/shared.dart';

const url = "http://172.30.1.29:8889";

// String user_id = User.getText();

class Server {
  Future login(String user_id, String user_pw) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post("$url/login",
        data: {"user_id": "$user_id", "user_pw": "$user_pw"});
    // print(response.data['data'][0]);
    if (response.data['result'] == "success") {
      print('successRes : ' + response.data['data'][0]['user_id']);
      // print('res : ' + response.data[0]['user_pw']);
      // print('res : ' + response.data[0].toString());
    } else if (response.data['result'] == "pw err") {
      print('failedRes : 비밀번호를 잘못 입력함');
    }
    await DataManager.saveData('id', response.data['data'][0]['user_id']);
  }

  Future join(
      String user_id, String user_pw, String user_name, String user_num) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post("$url/join/create", data: {
      "user_id": "$user_id",
      "user_pw": "$user_pw",
      "user_name": "$user_name",
      "user_num": "$user_num"
    });
    String result = response.data['result'];
    if (result == "success") {
      print('successRes : ' + response.data['result']);

      // } else if (response.data['result'] == "pw err") {
      //   print('failedRes : 비밀번호를 잘못 입력함');
    } else if (result == "failed") {
      print('successRes : ' + response.data['result']);
    }
    await DataManager.saveData('joinResult', result);
  }
}

Server server = Server();
