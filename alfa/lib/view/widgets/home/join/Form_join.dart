import 'package:alfa/view/widgets/home/join/TextFromFieldComponent.dart';
import 'package:alfa/view/widgets/home/join/consent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../server/dio.dart';
import 'package:get/get.dart';
import 'package:alfa/get_Pages.dart';
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';

class Form_join extends StatefulWidget {
  const Form_join({super.key});

  @override
  State<Form_join> createState() => _Form_updateState();
}

class _Form_updateState extends State<Form_join> {
  String joinRes = '';

  @override
  void initState() {
    super.initState();
    // loadJoinResult(); // 앱이 시작할 때 세션 데이터를 불러옵니다.
  }

  Future<void> loadJoinResult() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      joinRes = prefs.getString('joinResult') ?? 'null';
    });
  }

  Future<void> removeRes(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

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
              TitleText('계정 이메일'),
              TextFromFieldComponent(3, false, '계정 이메일을 입력해주세요.', 30,
                  '잘못된 이메일 형식입니다.', false, _email, false),
              SizedBox(
                height: 10,
              ),
              TitleText('비밀번호'),
              minText('영문,숫자,특수문자를 1개 이상 조합하여 8자 이상 15자 이내로 입력하세요.'),
              TextFromFieldComponent(4, true, '비밀번호를 입력해주세요.', 20,
                  '비밀번호를 확인해주세요.', false, _pw, false),
              SizedBox(
                height: 10,
              ),
              TitleText('비밀번호 확인'),
              TextFromFieldComponent(5, true, '비밀번호를 다시 한번 입력해주세요', 20,
                  '비밀번호가 일치하지 않습니다.', false, _pwt, false),
              SizedBox(height: 20),
              TitleText('이름'),
              TextFromFieldComponent(
                  1, false, '이름을 입력해주세요.', 10, '다시입력해주세요', true, _name, false),
              SizedBox(
                height: 10,
              ),
              TitleText('휴대폰 번호'),
              TextFromFieldComponent(2, false, '(Ex)01012341234', 11,
                  '잘못된 전화번호 형식입니다.', false, _tel, false),
              SizedBox(
                height: 10,
              ),
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: consent(),
                              );
                            });
                      },
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
                  width: double.infinity,
                  child:
                      // joinBtn(_formkey, checked, _name.text, _pw.text,
                      //     _email.text, _tel.text, joinRes)
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(62, 68, 102, 1)),
                          onPressed: () {
                            // if (!checked) {}
                            // if (_formkey.currentState!.validate()) {
                            String user_id = _email.text;
                            String user_pw = _pw.text;
                            String user_name = _name.text;
                            String user_num = _tel.text;
                            // Get.rootDelegate.toNamed(Routes.JOINDB);

                            Future<void> data() async {
                              await server.join(
                                  user_id, user_pw, user_name, user_num);
                              await loadJoinResult();
                              print('joinRes: $joinRes');

                              // html.window.location.reload();
                              // DataManager.removeData('flutter.joinResult');
                              if (joinRes == 'failed') {
                                print('joinRestest: $joinRes');
                                removeRes('joinResult');

                                // Get.rootDelegate.toNamed(Routes.JOIN);
                                Future.delayed(Duration(milliseconds: 100), () {
                                  html.window.location.reload();
                                  // _formkey.currentState!.save();
                                });
                              } else if (joinRes == 'success') {
                                Get.rootDelegate.toNamed(Routes.HOME);
                                removeRes('joinResult');
                                Future.delayed(Duration(milliseconds: 100), () {
                                  html.window.location.reload();
                                  // _formkey.currentState!.save();
                                });
                              }
                            }

                            data();
                          },
                          // },
                          child: Text('회원가입'))),
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

// Widget joinBtn(_formkey, checked, String _name, String _pw, String _email,
//     String _tel, String joinRes) {
//   void removeRes() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('joinResult');
//   }

//   // return Builder(builder: (context) {
//   //   final _User = Provider.of<User>(context);
//   //   _User.result = joinRes;
//     return ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             backgroundColor: Color.fromRGBO(62, 68, 102, 1)),
//         onPressed: () {
//           if (!checked) {}
//           if (_formkey.currentState!.validate()) {
//             String user_id = _email;
//             String user_pw = _pw;
//             String user_name = _name;
//             String user_num = _tel;
//             // Get.rootDelegate.toNamed(Routes.JOINDB);
//             Future<void> data() async {
//               await server.join(user_id, user_pw, user_name, user_num);
//               print('joinRes : ' + _User.result);
//             }

//             data();

//             if (_User.result != '') {
//               // Get.rootDelegate.toNamed(Routes.JOIN);
//               // html.window.location.reload();
//               removeRes();
//             } else if (_User.result == 'success') {
//               Get.rootDelegate.toNamed(Routes.HOME);
//               Future.delayed(Duration(milliseconds: 300), () {
//                 html.window.location.reload();
//                 // _formkey.currentState!.save();
//                 removeRes();
//               });
//             }
//           }
//         },
//         child: Text('회원가입'));
//   });
// }
