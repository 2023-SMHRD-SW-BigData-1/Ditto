import 'package:flutter/material.dart';

class contentHome extends StatefulWidget {
  const contentHome({super.key});

  @override
  State<contentHome> createState() => _contentHomeState();
}

class _contentHomeState extends State<contentHome>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 20),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            child: Container(
              width: 300,
              height: 300,
              child: Image.asset(
                'assets/image/Logo_icon.png',
                fit: BoxFit.cover,
              ),
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * 3.1415926535897932,
                child: child,
              );
            },
          ),
        ]);
  }
}
