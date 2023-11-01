import 'package:alfa/Model/Input_data.dart';
import 'package:alfa/provider/shared.dart';
import 'package:alfa/view/widgets/main/Payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:alfa/server/dio.dart';

Widget Main_input() {
  return Builder(builder: (context) {
    var payDate = '';
    String user_id = '';
    final _formkey = GlobalKey<FormState>();
    final _Input_data = Provider.of<Input_data>(context);
    TextEditingController yieldController = TextEditingController();
    TextEditingController tensileController = TextEditingController();
    TextEditingController hardnessController = TextEditingController();
    TextEditingController elongationController = TextEditingController();
    return Stack(children: <Widget>[
      Container(
        height: 120.0,
        width: 700.0,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: OverflowBox(
          minHeight: 50,
          minWidth: 400,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Input_item('Yield', yieldController),
                    Input_item('Tensile', tensileController),
                    Input_item('Hardness', hardnessController),
                    Input_item('Elongation', elongationController),
                  ],
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        _Input_data.yield = double.parse(yieldController.text);
                        _Input_data.tensile =
                            double.parse(tensileController.text);
                        _Input_data.hardness =
                            double.parse(hardnessController.text);
                        _Input_data.elongation =
                            double.parse(elongationController.text);

                        // if (type == '0') {
                        // 0인 사람은 1인 경우 결과 출력 후에 다시 0으로, 2인 경우 유지
                        // } else if (type == 1) {
                        //  type 1 은 1회성 결제자, 결과 출력 후 type을 다시 0으로 수정하기

                        DataManager.loadData('type').then((value) {
                          var type = value;

                          if (type == '0') {
                            void payment() async {
                              await showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Payment(),
                                    );
                                  });
                              // Navigator.of(context).pop();

                              await DataManager.loadData('payDate')
                                  .then((value) {
                                payDate = value;
                              });
                              await DataManager.loadData('id').then((value) {
                                user_id = value;
                              });

                              await DataManager.loadData('payment')
                                  .then((value) {
                                var payRes = value;
                                if (payRes == 'success') {
                                  server.insertAl(
                                      _Input_data.yield,
                                      _Input_data.tensile,
                                      _Input_data.hardness,
                                      _Input_data.elongation,
                                      user_id,
                                      payDate);
                                }
                                // else {
                                //   showDialog(
                                //       context: context,
                                //       barrierDismissible: true,
                                //       builder: (BuildContext context) {
                                //         return Text('다시 시도해주세요');
                                //       });
                                // }
                              });
                            }

                            payment();
                          } else if (type == '2') {
                            DataManager.loadData('id').then((value) async {
                              user_id = value;
                              print(user_id);
                              await server.loadPayDate(user_id);

                              DataManager.loadData('loadPayDate').then((value) {
                                payDate = value;
                                print(payDate);
                                server.insertAl(
                                    _Input_data.yield,
                                    _Input_data.tensile,
                                    _Input_data.hardness,
                                    _Input_data.elongation,
                                    user_id,
                                    payDate);
                              });
                            });
                          } else if (type == '9') {
                            server.insertAl(
                                _Input_data.yield,
                                _Input_data.tensile,
                                _Input_data.hardness,
                                _Input_data.elongation,
                                user_id,
                                payDate);
                          }
                        });
                      }
                      // print(_Input_data.yield);
                      // print(_Input_data.tensile);
                      // print(_Input_data.hardness);
                      // print(_Input_data.elongation);
                      // }
                    },
                    child: Text(
                      'Research',
                    ),
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        elevation: 0,
                        backgroundColor: Color.fromRGBO(182, 24, 24, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
          right: 0,
          child: Tooltip(
            verticalOffset: -90,
            message:
                "Input the desired mechanical properties\nhere to explore the optimal heat treatment processes.\nFill in the appropriate values for each category and click\n'Research' to view the results.",
            child: Icon(Icons.help_outline_outlined),
          ))
    ]);
  });
}

Widget Input_item(title, controller) {
  return Container(
    width: 150,
    height: 40,
    child: TextFormField(
      maxLength: 10,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
          counterText: '',
          border: OutlineInputBorder(borderSide: BorderSide()),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.eject,
                size: 18,
                color: Colors.black,
              ),
              textfun(title),
            ],
          )),
    ),
  );
}

Widget textfun(title) {
  switch (title) {
    case 'Yield':
    case 'Tensile':
      return Text_item('Mpa');
    case 'Hardness':
      return Text_item('HB');
    case 'Elongation':
      return Text_item('%');
    default:
      return const Text('error');
  }
}

Widget Text_item(String _text) {
  return Text(
    _text,
    style: TextStyle(fontSize: 14, color: Colors.black),
    textAlign: TextAlign.center,
  );
}
