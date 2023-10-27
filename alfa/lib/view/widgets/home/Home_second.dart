import 'package:flutter/material.dart';

class Home_second extends StatefulWidget {
  final double position;
  const Home_second({required this.position});

  @override
  State<Home_second> createState() => _Home_secondState();
}

class _Home_secondState extends State<Home_second> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: double.infinity,
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 1400,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: widget.position >= 400 ? 1 : 0.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Technology',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "Overcome the limitations of technology",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
                    ),
                  ])),
                ]),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 500,
          child: Image.asset(
            'assets/image/AdobeStock_579036350.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 1400,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: widget.position >= 700 ? 1 : 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Find",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color.fromRGBO(62, 68, 102, 1),
                        fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: "\ta more accurate result",
                    style: TextStyle(fontSize: 40.0),
                  )
                ])),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50,
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
