import 'package:flutter/material.dart';
import 'package:project_alfa/view/widgets/home/login/Google_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      height: 500.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
                iconSize: 18,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 320.0,
            child: Column(
              children: <Widget>[
                Google_login(),
                SizedBox(
                  height: 20,
                ),
                Text('or'),
                SizedBox(
                  height: 20,
                ),
                Form_build(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Form_build extends StatefulWidget {
  const Form_build({super.key});

  @override
  State<Form_build> createState() => _Form_bulidState();
}

class _Form_bulidState extends State<Form_build> {
  final _formkey = GlobalKey<FormState>();
  var isEnabled = false;
  @override
  Widget build(BuildContext context) {
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
              onSaved: (value) {
                print('$value');
              },
              validator: (value) {
                bool emailValid =
                    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(value!.toString());
                if (value!.isEmpty) {
                  return 'Please provide your email.';
                }
                if (!emailValid) {
                  return "'$value' \t Invalid email format";
                }
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
              onSaved: (value) {
                print('$value');
              },
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
                    _formkey.currentState!.save();
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Text(
                  'Log in',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, elevation: 0),
              ),
            )
          ],
        ));
    ;
  }
}
