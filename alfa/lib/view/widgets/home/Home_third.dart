import 'package:flutter/material.dart';

class Home_third extends StatefulWidget {
  final double position;
  const Home_third({required this.position});

  @override
  State<Home_third> createState() => _Home_thirddState();
}

class _Home_thirddState extends State<Home_third> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 1400,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: widget.position >= 1100 ? 1 : 0.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ' Heat Treatment',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Elevate Quality and Efficiency.",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w700),
                      ),
                    ])),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
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
                    )
                  ]),
            ),
          ),
        ),
        SizedBox(
          height: 100,
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
