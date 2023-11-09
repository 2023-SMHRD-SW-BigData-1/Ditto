import 'package:alfa/Controller/reslutTrigger.dart';
import 'package:alfa/Model/Input_data.dart';
import 'package:alfa/provider/shared.dart';
import 'package:alfa/view/widgets/main/Payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:alfa/server/dio.dart';

Widget Main_input() {
  return Builder(builder: (context) {
    var pay_date = '';
    String user_id = '';
    int pay_price = 0;
    final _formkey = GlobalKey<FormState>();
    final _Input_data = Provider.of<Input_data>(context);
    final resTrigger = Provider.of<resultTrigger>(context);
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
                    Input_item('Tensile', tensileController),
                    Input_item('Yield', yieldController),
                    Input_item('Elongation', elongationController),
                    Input_item('Hardness', hardnessController),
                  ],
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        _Input_data.tensile =
                            double.parse(tensileController.text);
                        _Input_data.yiel = double.parse(yieldController.text);
                        _Input_data.elongation =
                            double.parse(elongationController.text);
                        _Input_data.hardness =
                            double.parse(hardnessController.text);

                        DataManager.loadData('type').then((value) async {
                          var type = value;

                          if (type == '0') {
                            Future<void> payment() async {
                              await showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Payment(),
                                    );
                                  });

                              await DataManager.loadData('id').then((value) {
                                user_id = value;
                                print('type(0).user_id : $user_id');
                              });
                              await DataManager.loadData('payDate')
                                  .then((value) {
                                pay_date = value;
                                print('type(0).payDate : $pay_date');
                              });
                              await DataManager.loadData2('payPrice')
                                  .then((value) {
                                pay_price = value;
                                print('type(0).payPrice : $pay_price');
                              });
                              await server.payDate(
                                  user_id, pay_date, pay_price);
                              await DataManager.loadData('payment')
                                  .then((value) async {
                                print('type(0).insertAl 전 payment : $value');
                                if (value == 'success') {
                                  server.insertAl(
                                      _Input_data.tensile,
                                      _Input_data.yiel,
                                      _Input_data.elongation,
                                      _Input_data.hardness,
                                      user_id,
                                      pay_date);
                                }
                                await Future.delayed(Duration(seconds: 2));
                                await server.report(user_id);
                                await DataManager.loadData('stepOne')
                                    .then((value) async {
                                  var result = value;
                                  if (result == null) {
                                    resTrigger.Trigger = false;
                                  } else if (result == "success") {
                                    resTrigger.Trigger = true;
                                  }
                                });
                              });
                            }

                            payment();
                          } else if (type == '2') {
                            DataManager.loadData('id').then((value) async {
                              user_id = value;
                              print('type(2).user_id : $user_id');
                              await server.loadPayDate(user_id);

                              await DataManager.loadData('loadPayDate')
                                  .then((value) async {
                                pay_date = value;
                                print('type(2).pay_date : $pay_date');
                                server.insertAl(
                                    _Input_data.tensile,
                                    _Input_data.yiel,
                                    _Input_data.elongation,
                                    _Input_data.hardness,
                                    user_id,
                                    pay_date);
                              });
                              await Future.delayed(Duration(seconds: 2));
                              await server.report(user_id);
                              await DataManager.loadData('stepOne')
                                  .then((value) async {
                                var result = value;
                                if (result == null) {
                                  resTrigger.Trigger = false;
                                } else if (result == "success") {
                                  resTrigger.Trigger = true;
                                }
                              });
                            });
                          }
                        });
                      }
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
            verticalOffset: -55,
            message:
                "Al 합금 열처리에 대한 표준 데이터를 기반으로 값을 입력해 주세요.\n단, 조건을 만족하지 않을 경우 적절하지 않은 결과가 나올 수 있습니다.",
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
      return Text_item('Hv');
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
