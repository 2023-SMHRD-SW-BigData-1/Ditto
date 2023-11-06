import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:alfa/server/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../../../get_pages.dart';
import 'package:alfa/provider/shared.dart';

class Form_login extends StatefulWidget {
  const Form_login({super.key});

  @override
  State<Form_login> createState() => _Form_bulidState();
}

class _Form_bulidState extends State<Form_login> {
  var isEnabled = false;
  // String prefId = '';

  // Future<void> loadUserId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     prefId = prefs.getString('name') ?? 'null';
  //   });
  // }

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

                    void login() async {
                      await server.login(user_id, user_pw);

                      if (DataManager.loadData('name') != 'null') {
                        Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 300), () {
                          html.window.location.reload();
                        });
                      } else {}
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
