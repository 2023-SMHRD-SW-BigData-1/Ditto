import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromRGBO(62, 68, 102, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              width: 1400,
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      minText('© 2023 Metamong. All rights reserved.'),
                      minText('Address: Gwangju, South Korea'),
                      minText('Email: tngh5352@gmail.com'),
                      minText('Tell: 123-1234-1234'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1.5,
                        width: 500,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      minText('AL.F.A©Metamong')
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

Widget minText(String st) {
  return Text(
    st,
    style: TextStyle(color: Colors.white),
  );
}
