import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_alfa/provider/bar.dart';
import 'package:project_alfa/view/widgets/main/Main_sidebar.dart';
import 'package:provider/provider.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({
    super.key,
  });

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    final _bar = Provider.of<bar>(context);
    return SafeArea(
        child: Container(
      child: Row(
        children: <Widget>[
          Main_sidebar(),
          Expanded(
              child: Container(
            color: Color.fromARGB(82, 158, 158, 158).withOpacity(0.15),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        // ignore: sort_child_properties_last
                        child: Tooltip(
                          message: 'Open',
                          waitDuration: Duration(milliseconds: 300),
                          child: IconButton(
                              onPressed: () {
                                _bar.bar_open();
                              },
                              icon: Icon(
                                Icons.menu,
                              )),
                        ),
                        visible: _bar.triger,
                      ),
                      Container(
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: Text('REF')),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text('PDF')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    ));
    ;
  }
}
