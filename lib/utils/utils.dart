import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(String text) {
  Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.black54, textColor: Colors.white, fontSize: 16.0);
}

void showSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
}

bool isEmailValid(String emailAddress) {
  String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  return RegExp(pattern).hasMatch(emailAddress);
}

bool isPasswordValid(String password) {
  String pattern = "(?=.{5,})";
  return RegExp(pattern).hasMatch(pattern);
}
