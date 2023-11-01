import 'package:flutter/material.dart';

class Home_third extends StatefulWidget {
  final double position;
  final Size screenSize;
  const Home_third({required this.position, required this.screenSize});

  @override
  State<Home_third> createState() => _Home_thirddState();
}

class _Home_thirddState extends State<Home_third> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenSize.width < 900 ? 480 : 700,
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
                ? widget.position >= 350
                    ? 1
                    : 0.0
                : widget.position >= 1100
                    ? 1
                    : 0.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' Heat Treatment',
                    style: TextStyle(
                        fontSize: widget.screenSize.width < 900 ? 14 : 18),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "Elevate Quality and Efficiency.",
                      style: TextStyle(
                          fontSize: widget.screenSize.width < 900 ? 30 : 50,
                          fontWeight: FontWeight.w700),
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
                              width: 800,
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Journey into the Fascinating World of Heat Treatment:\nUnveiling the Future of Precision and Quality.\nJoin us in Exploring the Art and Science of Heat Treatment Processes,\nWhere Innovation and Tradition Converge to Shape Tomorrow's Excellence.",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "At the Forefront of Heat Treatment Excellence,\nWe Strive to Enhance Your Products Beyond Expectations.\nDiscover the Power of Advanced Technologies,\nand Join Us in Shaping the Future of Industrial Heat Processing.",
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1000,
                              height: 100,
                              child: Image.asset(
                                'assets/image/AdobeStock_540804731.jpeg',
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 800,
                                height: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Journey into the Fascinating World of Heat Treatment:\nUnveiling the Future of Precision and Quality.\nJoin us in Exploring the Art and Science of Heat Treatment Processes,\nWhere Innovation and Tradition Converge to Shape Tomorrow's Excellence.",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "At the Forefront of Heat Treatment Excellence,\nWe Strive to Enhance Your Products Beyond Expectations.\nDiscover the Power of Advanced Technologies,\nand Join Us in Shaping the Future of Industrial Heat Processing.",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 600,
                                height: 400,
                                child: Image.asset(
                                  'assets/image/AdobeStock_540804731.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        )
                ]),
          ),
        ),
        SizedBox(
          height: widget.screenSize.width < 900 ? 50 : 100,
        ),
        Container(
          height: 1.5,
          width: double.infinity,
          color: const Color.fromRGBO(217, 217, 217, 100),
        ),
      ]),
    );
  }
}
