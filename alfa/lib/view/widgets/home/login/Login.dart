import 'package:alfa/Controller/trigger.dart';
import 'package:alfa/get_pages.dart';
import 'package:alfa/view/widgets/home/login/Form_login.dart';
import 'package:alfa/view/widgets/home/login/Google_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _triger = Provider.of<trigger>(context);
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
                  Form_login(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('No account?'),
                        TextButton(
                            onPressed: () =>
                                Get.rootDelegate.toNamed(Routes.JOIN),
                            child: Text('Create one'))
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
