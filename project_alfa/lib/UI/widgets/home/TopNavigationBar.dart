import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 100.0,
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
                onPressed: () {},
                child: Text("GET STARTED"),
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    backgroundColor: const Color.fromRGBO(182, 24, 24, 100),
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                width: 50,
              )
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
