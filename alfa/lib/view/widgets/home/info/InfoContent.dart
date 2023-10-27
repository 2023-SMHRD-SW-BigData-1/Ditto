import 'package:alfa/view/widgets/home/join/TextFromFieldComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alfa/server/dio.dart';
import 'dart:html' as html;
import 'package:alfa/Provider/shared.dart';

class InfoContent extends StatefulWidget {
  const InfoContent({super.key});

  @override
  State<InfoContent> createState() => _InfoContentState();
}

class _InfoContentState extends State<InfoContent> {
  @override
  void initState() {
    super.initState();
    loadEmail(); // 앱이 시작할 때 세션 데이터를 불러옵니다.
    loadName();
    loadNum();
  }

  String email = '';
  String name = '';
  String num = '';
  String pw = '';

  Future<void> loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('id') ?? "null";
    });
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "null";
    });
  }

  Future<void> loadNum() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      num = prefs.getString('num') ?? "null";
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final TextEditingController _name = TextEditingController(text: name);
    final TextEditingController _tel = TextEditingController(text: num);
    final TextEditingController _email = TextEditingController(text: email);
    final TextEditingController _pw = TextEditingController();
    final TextEditingController _pwt = TextEditingController();
    bool? checked = false;
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText('계정 이메일'),
          TextFromFieldComponent(3, false, '계정 이메일을 입력해주세요.', 30,
              '잘못된 이메일 형식입니다.', false, _email, true),
          SizedBox(
            height: 10,
          ),
          TitleText('비밀번호'),
          minText('영문,숫자,특수문자를 1개 이상 조합하여 8자 이상 15자 이내로 입력하세요.'),
          TextFromFieldComponent(
              4, true, '비밀번호를 입력해주세요.', 20, '비밀번호를 확인해주세요.', false, _pw, false),
          SizedBox(
            height: 10,
          ),
          TitleText('비밀번호 확인'),
          TextFromFieldComponent(5, true, '비밀번호를 다시 한번 입력해주세요', 20,
              '비밀번호가 일치하지 않습니다.', false, _pwt, false),
          SizedBox(height: 20),
          TitleText('이름'),
          TextFromFieldComponent(
              1, false, '이름을 입력해주세요.', 10, '다시입력해주세요', true, _name, true),
          SizedBox(
            height: 10,
          ),
          TitleText('휴대폰 번호'),
          TextFromFieldComponent(2, false, '휴대폰 번호를 입력해주세요', 11,
              '잘못된 전화번호 형식입니다.', false, _tel, false),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
          ),
          TextButton(
            onPressed: () {
              num = _tel.text;
              pw = _pw.text;
              void modify() async {
                await server.modify(email, num, pw);

                html.window.location.reload();
              }

              modify();
            },
            child: TitleText('수정'),
          )
        ],
      ),
    );
  }
}

Widget TitleText(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  );
}

Widget minText(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w300),
  );
}
