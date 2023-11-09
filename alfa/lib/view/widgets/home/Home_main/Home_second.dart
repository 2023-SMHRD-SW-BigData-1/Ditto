import 'dart:async';

import 'package:flutter/material.dart';

class Home_second extends StatefulWidget {
  final Size screenSize;
  final double position;
  const Home_second({required this.position, required this.screenSize});

  @override
  State<Home_second> createState() => _Home_secondState();
}

class _Home_secondState extends State<Home_second> {
  late ScrollController _scrollController;
  late Timer _timer;

  final List<Widget> items = [
    Image.asset(
      'assets/image/logo/flutter.png',
      fit: BoxFit.cover,
    ),
    SizedBox(
      width: 100,
    ),
    Image.asset(
      'assets/image/logo/dart.png',
      fit: BoxFit.cover,
    ),
    SizedBox(
      width: 100,
    ),
    Image.asset(
      'assets/image/logo/node.png',
      fit: BoxFit.cover,
    ),
    SizedBox(
      width: 100,
    ),
    Image.asset(
      'assets/image/logo/python.png',
      fit: BoxFit.cover,
    ),
    SizedBox(
      width: 100,
    ),
    Image.asset(
      'assets/image/logo/flask.png',
      fit: BoxFit.cover,
    ),
    SizedBox(
      width: 100,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _startAutoScrolling();
  }

  _startAutoScrolling() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _scrollController.jumpTo(_scrollController.position.pixels + 2.0);
    });
  }

  _onScroll() {
    if (_scrollController.position.extentAfter < 100.0) {
      _scrollController.jumpTo(
          _scrollController.position.pixels - (items.length / 2) * 140.0);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenSize.width < 900 ? 400 : 800,
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
                ? 1
                : widget.position >= 400
                    ? 1
                    : 0.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Technology',
                    style: TextStyle(
                        fontSize: widget.screenSize.width < 900 ? 14 : 18),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "Overcome the limitations of technology",
                      style: TextStyle(
                          fontSize: widget.screenSize.width < 900 ? 30 : 50,
                          fontWeight: FontWeight.w700),
                    ),
                  ])),
                ]),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: widget.screenSize.width < 900 ? 200 : 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: widget.screenSize.width < 900 ? 150 : 300,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return items[index % items.length];
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: 1400,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: widget.screenSize.width < 900
                ? widget.position >= 50
                    ? 1
                    : 0.0
                : widget.position >= 700
                    ? 1
                    : 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Find",
                    style: TextStyle(
                        fontSize: widget.screenSize.width < 900 ? 25 : 40,
                        color: Color.fromRGBO(62, 68, 102, 1),
                        fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: "\ta more accurate result",
                    style: TextStyle(
                        fontSize: widget.screenSize.width < 900 ? 25 : 40.0),
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
