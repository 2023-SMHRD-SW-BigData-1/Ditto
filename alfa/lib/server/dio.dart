import 'package:alfa/Model/User.dart';
import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:alfa/view/widgets/home/login/Form_login.dart';
import 'package:provider/provider.dart';
import '../Model/User.dart';
import '../provider/shared.dart';

const url = "http://172.30.1.29:8889";

class Server {
  Future login(String user_id, String user_pw) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post("$url/login",
        data: {"user_id": "$user_id", "user_pw": "$user_pw"});
    // print(response.data['data'][0]);
    if (response.data['result'] == "success") {
      print('successRes : ' + response.data['data'][0]['user_id']);
      String user_name = response.data['data'][0]['user_name'];
      String user_email = response.data['data'][0]['user_id'];
      String user_num = response.data['data'][0]['user_num'];
      // print('res : ' + response.data[0]['user_pw']);
      // print('res : ' + response.data[0].toString());
      await DataManager.saveData('name', user_name);
      await DataManager.saveData('id', user_email);
      await DataManager.saveData('num', user_num);
    } else if (response.data['result'] == "pw err") {
      await DataManager.saveData('id', 'null');
      print('failedRes : 비밀번호를 잘못 입력함');
    } else if (response.data['result'] == 'empty id') {
      print('failedRes : 아이디가 없음');
    }
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
}

Server server = Server();
