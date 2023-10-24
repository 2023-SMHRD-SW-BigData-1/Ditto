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
    if (response.data[0] != null) {
      print('res : ' + response.data[0]['user_pw']);
      print('res : ' + response.data[0].toString());
    } else {
      print('res : ' + response.data['result']);
    }
    await DataManager.saveData('id', response.data[0]['user_id']);
  }
}

Server server = Server();
