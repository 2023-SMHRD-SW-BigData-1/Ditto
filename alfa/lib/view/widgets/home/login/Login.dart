import 'package:alfa/Controller/triger.dart';
import 'package:alfa/view/widgets/home/login/Form_join.dart';
import 'package:alfa/view/widgets/home/login/Form_login.dart';
import 'package:alfa/view/widgets/home/login/Google_login.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _triger = Provider.of<triger>(context);
    return Container(
      width: 350.0,
      height: 500.0,
      child: SingleChildScrollView(
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
                  _triger.triger_on ? Form_login() : Form_join(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _triger.triger_on
                            ? Text('No account?')
                            : Text('Already have an account?'),
                        TextButton(
                            onPressed: () {
                              _triger.triger_on_off();
                            },
                            child: _triger.triger_on
                                ? Text('Create one')
                                : Text('Log in'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
