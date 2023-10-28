import 'package:flutter/material.dart';

class Home_fourth extends StatefulWidget {
  final double position;
  const Home_fourth({required this.position});

  @override
  State<Home_fourth> createState() => _Home_fourthState();
}

class _Home_fourthState extends State<Home_fourth> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      width: double.infinity,
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 1400,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: widget.position >= 1800 ? 1 : 0.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Team',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "Metamong",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(62, 68, 102, 1)),
                    ),
                  ])),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 600,
                        height: 400,
                        child: Image.asset(
                          'assets/image/AdobeStock_618436697.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      SizedBox(
                        width: 600,
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello! We are Team "Metamong." Our team consists of five dedicated individuals:\nKim TaeKyeong, Jo SeoHyeon, Park HeeJu, Park JiWon, and Lee SuHo.\nWe have spent six months honing our skills at the Smart Talent Development Institute.',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "We have dedicated 1800 hours to learning and growing at the Smart Talent Development Institute,\nand now we are preparing for real-world projects.\nWe are enhancing our development skills and problem-solving abilities,\nstriving to complete exciting projects.\nStay tuned for our journey of growth together!",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ]),
    );
  }
}
