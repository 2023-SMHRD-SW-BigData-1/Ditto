import 'package:alfa/get_pages.dart';
import 'package:alfa/view/widgets/home/login/Login.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_first extends StatefulWidget {
  final Size screenSize;
  const Home_first({Key? key, required this.screenSize}) : super(key: key);
  @override
  State<Home_first> createState() => _Home_firstState();
}

int _current = 0;
final CarouselController _controller = CarouselController();
List imageList = ["assets/image/image9.png", "assets/image/first_img.jpg"];

class _Home_firstState extends State<Home_first> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.screenSize.width < 900 ? 750 : 1000.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: 1400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "AL.F.A",
                    style: TextStyle(
                        fontSize: widget.screenSize.width < 900 ? 40 : 70,
                        color: Color.fromRGBO(182, 24, 24, 1),
                        fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        "\t\t: Heat Treatment Alloy\nthe key to innovation,\nStart AI technology now",
                    style: TextStyle(
                        fontSize: widget.screenSize.width < 900 ? 18 : 30.0,
                        fontWeight: FontWeight.w700),
                  )
                ])),
                Column(
                  children: [
                    SizedBox(
                      height: 140.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final userId = prefs.getString('name') ?? '';
                        if (userId == '') {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Login(),
                                );
                              });
                        } else {
                          Get.rootDelegate.toNamed(Routes.MAIN);
                        }
                      },
                      // ignore: sort_child_properties_last
                      child: Text(
                        "GET STARTED",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.black,
                          padding: widget.screenSize.width < 900
                              ? EdgeInsets.fromLTRB(20, 10, 20, 10)
                              : EdgeInsets.fromLTRB(40, 25, 40, 25),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: widget.screenSize.width < 900 ? 300 : 500,
            child: ImageSlider(screenSize: widget.screenSize),
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            "Alone in the night  On a dark hill With pines around me  Spicy and still,",
            style: TextStyle(fontSize: widget.screenSize.width < 900 ? 8 : 14),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "And a heaven full of stars Over my head, White and topaz And misty red Myriads with beating Hearts of fire That aeons",
            style: TextStyle(fontSize: widget.screenSize.width < 900 ? 8 : 14),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            height: 1.5,
            width: double.infinity,
            color: const Color.fromRGBO(217, 217, 217, 100),
          ),
        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final Size screenSize;
  const ImageSlider({Key? key, required this.screenSize}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
          carouselController: _controller,
          items: imageList.map((imgLink) {
            return Builder(builder: (context) {
              return SizedBox(
                width: 1400.0,
                child: Image(fit: BoxFit.cover, image: AssetImage(imgLink)),
              );
            });
          }).toList(),
          options: CarouselOptions(
            height: widget.screenSize.width < 900 ? 300 : 500,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 7),
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          )),
      Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((e) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(e.key),
              child: Container(
                width: 12,
                height: 12,
                margin:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(_current == e.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      )
    ]);
  }
}
