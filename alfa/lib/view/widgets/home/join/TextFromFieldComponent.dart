import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget TextFromFieldComponent(
    int trigger,
    bool obscureText,
    String hintText,
    int maxSize,
    String errorMassage,
    bool autofocus,
    TextEditingController controller,
    bool read) {
  List<TextInputFormatter> inputFormatters = [];
  if (trigger == 2) {
    inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')));
  }
  return Container(
    child: TextFormField(
      readOnly: read,
      controller: controller,
      autofocus: true,
      obscureText: obscureText,
      maxLength: maxSize,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
      ),
      validator: (value) {
        bool emailValid =
            RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                .hasMatch(value!.toString());
        bool pwValid = RegExp(
                r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$')
            .hasMatch(value!.toString());
        bool telValid =
            RegExp(r'(\d{3})(\d{3,4})(\d{4})').hasMatch(value!.toString());
        if (value!.isEmpty) {
          return '다시입력해주세요.';
        }
        switch (trigger) {
          case 2:
            if (!telValid) {
              return errorMassage;
            }
            break;
          case 3:
            if (!emailValid) {
              return errorMassage;
            }
            break;
          case 4:
            if (!pwValid) {
              return errorMassage;
            }
            break;
          default:
        }
        return null;
      },
    ),
  );
}
