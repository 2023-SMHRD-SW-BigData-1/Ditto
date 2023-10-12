import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 63.0,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: const Color.fromRGBO(179, 179, 179, 80)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 20.0,
            width: 150.0,
            child: Image.asset('assets/image/Logo.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem('Log in'),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/main');
                },
                child: Text(
                  "GET STARTED",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color.fromRGBO(182, 24, 24, 1),
                    padding: EdgeInsets.fromLTRB(35, 14, 35, 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;
  const NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }
}
