// import 'dart:ffi';

import 'dart:convert';

import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:alfa/view/widgets/home/login/Form_login.dart';
import '../provider/shared.dart';
import 'package:http/http.dart' as http;

// const url = "http://172.30.1.29:8889";
const url = "http://172.30.1.53:8889"; //희주~

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

      await DataManager.saveData('name', user_name);
      await DataManager.saveData('id', user_email);
      await DataManager.saveData('num', user_num);
    } else if (result == "failed") {
      print('modifyRes : $result');
    }

    // User user = Provider.of<User>(context, listen: false);
  }

// Main_input.dart에서 4개 값 입력 후 Research 버튼 클릭 시 실행
  Future insertAl(double tens, double yiel, double elongation, double hard,
      String user_id, var pay_date) async {
    // -----------------------
    Response response;
    Dio dio = Dio();
    // -----------------------
    // post 방식, index.js에서 같은 주소 찾아서 순서 비교하기
    // 1. url/main/stepOne 주소로 data에 값 담아서 전송 >> index.js로
    response = await dio.post("$url/main/stepOne", data: {
      "tens": "$tens",
      "yield": "$yiel",
      "elongation": "$elongation",
      "hard": "$hard",
      "user_id": "$user_id",
      "pay_date": "$pay_date"
    });
    // 5. index.js에서 response를 받고 result라는 변수에 stepOne 키값에 들어있는 값 넣어주기
    String result = response.data['stepOne'];
    // 5-1. 로컬 저장소에 stepOne이라는 이름으로 저장하기
    await DataManager.saveData('stepOne', result);
    String num = response.data['num'][0]['num'];
    await DataManager.saveData('num', num);
    // 6. 5번에서 저장한 result 값이 success 라면 (index.js에서 작성한 쿼리문의 입력이 성공했다면)
    if (result == "success") {
      // 6-1. 테스트용 문구 확인
      print('stepOne : $result');

      // 7. DB에 1번에서 보낸 값이 제대로 들어갔기 때문에 똑같은 값을 모델링 하기 위해 flask 서버로 전송하기
      void sendDataToPython() async {
        // 7-1. flask 서버로 post 방식으로 전송, body 에 똑같이 값을 담고 json 형태로 보내줌 //
        var uri = Uri.http('localhost:5000', '/result');
        final response = await http.post(uri,
            headers: {
              "Access-Control-Allow-Origin":
                  "*", // Required for CORS support to work
              "accept": "application/json",
              "content-type": "application/json"
            },
            body: jsonEncode({
              "tens": "$tens",
              "yield": "$yiel",
              "elongation": "$elongation",
              "hard": "$hard",
              "user_id": "$user_id",
              "pay_date": "$pay_date",
              "num": "$num"
            }));
        // 7-1. 끝. >> app.py로 이동
        //
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

  Future payDate(String user_id, String pay_date, int pay_price) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post("$url/main/payment", data: {
      "user_id": "$user_id",
      "pay_date": "$pay_date",
      "pay_price": "$pay_price",
      // "user_name": "$user_name",
      // "user_num": "$user_num"
    });
    String result = response.data['payment'];
    await DataManager.saveData('payment', result);
    if (result == "success") {
      print('payment : $result');

      // } else if (response.data['result'] == "pw err") {
      //   print('failedRes : 비밀번호를 잘못 입력함');
    } else if (result == "failed") {
      print('payment : $result');
    }

    // User user = Provider.of<User>(context, listen: false);
  }
}

Server server = Server();
