import 'package:flutter/material.dart';

class Home_fourth extends StatefulWidget {
  final double position;
  final Size screenSize;
  const Home_fourth({required this.position, required this.screenSize});

  @override
  State<Home_fourth> createState() => _Home_fourthState();
}

class _Home_fourthState extends State<Home_fourth> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenSize.width < 900 ? 480 : 650,
      width: double.infinity,
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: 1400,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: widget.screenSize.width < 900
                ? widget.position >= 900
                    ? 1
                    : 0.0
                : widget.position >= 1800
                    ? 1
                    : 0.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Team',
                    style: TextStyle(
                        fontSize: widget.screenSize.width < 900 ? 14 : 18),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "Metamong",
                      style: TextStyle(
                          fontSize: widget.screenSize.width < 900 ? 30 : 50,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(62, 68, 102, 1)),
                    ),
                  ])),
                  SizedBox(
                    height: 20,
                  ),
                  widget.screenSize.width < 900
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 600,
                              height: 220,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello! We are Team "Metamong." Our team consists of five dedicated individuals:\nKim TaeKyeong, Cho Seoyeon, Park HeeJoo, Park JiWon, and Lee SuHo.\nWe have spent six months honing our skills at the Smart Talent Development Institute.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "We have dedicated 1800 hours to learning and growing at the Smart Talent Development Institute,\nand now we are preparing for real-world projects.\nWe are enhancing our development skills and problem-solving abilities,\nstriving to complete exciting projects.\nStay tuned for our journey of growth together!",
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1000,
                              height: 100,
                              child: Image.asset(
                                'assets/image/AdobeStock_618436697.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
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
                                      'Hello! We are Team "Metamong." Our team consists of five dedicated individuals:\nKim TaeKyeong, Cho Seoyeon, Park HeeJoo, Park JiWon, and Lee SuHo.\nWe have spent six months honing our skills at the Smart Talent Development Institute.',
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
                          ),
                        )
                ]),
          ),
        ),
        SizedBox(
          height: widget.screenSize.width < 900 ? 0 : 100,
        ),
      ]),
    );
  }
}
