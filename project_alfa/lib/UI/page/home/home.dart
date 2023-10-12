import 'package:flutter/material.dart';
import 'package:project_alfa/UI/widgets/home/TopNavigationBar.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
    );
  }
}

HomeBody() => SafeArea(
        child: Column(
      children: <Widget>[
        TopNavigationBar(),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              First(),
            ],
          ),
        ))
      ],
    ));

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 900,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          SizedBox(
            width: 1148,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "ALLOY",
                    style: TextStyle(
                      fontSize: 80,
                      color: Color.fromRGBO(182, 24, 24, 1),
                    ),
                  ),
                  TextSpan(
                    text:
                        "\t\talloyalloyalloyalloyalloy\nalloyalloyalloyalloyalloy\nalloyalloyalloyalloyalloyalloyalloy",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                ])),
                Column(
                  children: [
                    SizedBox(
                      height: 140,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/main');
                      },
                      child: Text(
                        "GET STARTED",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset('assets/image/image9.png'),
          SizedBox(
            height: 70,
          ),
          Text(
              "Alone in the night  On a dark hill With pines around me  Spicy and still,"),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1.0,
            width: 1148.0,
            color: const Color.fromRGBO(217, 217, 217, 100),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              "And a heaven full of stars Over my head, White and topaz And misty red Myriads with beating Hearts of fire That aeons")
        ],
      ),
    );
  }
}
