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
    Dio dio = new Dio();
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
    String user_name,
    String user_pw,
  ) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.post("$url/join/:$user_name",
        data: {"user_id": "$user_pw", "user_pw": "$user_pw"});
    // print(response.data['data'][0]);
    if (response.data['result'] == "success") {
      print('successRes : ' + response.data['data'][0].toString());
      // print('res : ' + response.data[0]['user_pw']);
      // print('res : ' + response.data[0].toString());
    } else if (response.data['result'] == "pw err") {
      print('failedRes : 비밀번호를 잘못 입력함');
    }
    await DataManager.saveData('id', response.data[0]['user_id']);
  }
}

Server server = Server();
