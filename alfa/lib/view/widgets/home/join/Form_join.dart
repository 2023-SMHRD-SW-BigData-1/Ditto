import 'package:alfa/view/widgets/home/join/TextFromFieldComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../Server/dio.dart';

class Form_join extends StatefulWidget {
  const Form_join({super.key});

  @override
  State<Form_join> createState() => _Form_updateState();
}

class _Form_updateState extends State<Form_join> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pw = TextEditingController();
  TextEditingController _pwt = TextEditingController();
  bool? checked = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        padding: EdgeInsets.fromLTRB(100, 0, 100, 100),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText('이름'),
              TextFromFieldComponent(
                  1, false, '이름을 입력해주세요.', 10, '다시입력해주세요', true, _name),
              SizedBox(
                height: 10,
              ),
              TitleText('휴대폰 번호'),
              TextFromFieldComponent(2, false, '(Ex)01012341234', 11,
                  '잘못된 전화번호 형식입니다.', false, _tel),
              SizedBox(
                height: 10,
              ),
              TitleText('계정 이메일'),
              TextFromFieldComponent(3, false, '계정 이메일을 입력해주세요.', 30,
                  '잘못된 이메일 형식입니다.', false, _email),
              SizedBox(
                height: 10,
              ),
              TitleText('비밀번호'),
              minText('영문,숫자,특수문자를 1개 이상 조합하여 8자 이상 15자 이내로 입력하세요.'),
              TextFromFieldComponent(
                  4, true, '비밀번호를 입력해주세요.', 20, '비밀번호를 확인해주세요.', false, _pw),
              SizedBox(
                height: 10,
              ),
              TitleText('비밀번호 확인'),
              TextFromFieldComponent(5, true, '비밀번호를 다시 한번 입력해주세요', 20,
                  '비밀번호가 일치하지 않습니다.', false, _pwt),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: checked,
                    onChanged: (value) {
                      setState(() {
                        checked = value;
                      });
                    },
                  ),
                  minText('개인정보 수집 및 이용 동의(필수)'),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        '보기',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: SizedBox()),
              Container(
                  width: double.infinity, child: joinBtn(_formkey, checked))
            ],
          ),
        ),
      ),
    );
  }
}

Widget TitleText(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
  );
}

Widget minText(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w300),
  );
}

Widget joinBtn(_formkey, checked) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(62, 68, 102, 1)),
      onPressed: () {
        if (!checked) {}
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
        }
      },
      child: Text('회원가입'));
}
