import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:alfa/server/dio.dart';
import 'package:alfa/provider/shared.dart';
import 'package:crypto/crypto.dart';

class Form_login extends StatefulWidget {
  const Form_login({super.key});

  @override
  State<Form_login> createState() => _Form_bulidState();
}

class _Form_bulidState extends State<Form_login> {
  var isEnabled = false;

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  labelText: 'Email'),
              controller: _emailController,
              validator: (value) {
                bool emailValid =
                    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(value!.toString());
                if (value!.isEmpty) {
                  return 'Please provide your email.';
                }
                // if (!emailValid) {
                //   return "'$value' \t Invalid email format";
                // }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  labelText: 'Password'),
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide your password.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    String user_id = _emailController.text;
                    String user_pw = _passwordController.text;
                    var bytes = utf8.encode(user_pw);
                    var pwHash = sha256.convert(bytes).toString();

                    void login() async {
                      await server.login(user_id, pwHash);
                      var loginId = await DataManager.loadData('id');
                      if (loginId != 'pw err' && loginId != 'empty id') {
                        Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 300), () {
                          html.window.location.reload();
                        });
                      } else if (loginId == 'pw err') {
                        Future.delayed(Duration(milliseconds: 100), () {
                          html.window.alert('비밀 번호가 일치하지 않습니다.');
                        });
                      } else if (loginId == 'empty id') {
                        Future.delayed(Duration(milliseconds: 100), () {
                          html.window.alert('아이디가 존재하지 않습니다.');
                        });
                      }
                    }

                    login();
                  }
                },
                child: Text(
                  'Log in',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, elevation: 0),
              ),
            ),
          ],
        ));
    ;
  }
}
