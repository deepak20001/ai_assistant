import 'package:ai_assistant/main.dart';
import 'package:flutter/material.dart';

///  :::::::::: Routes Class :::::::::
class Routes {

  static Future<dynamic> push(
      {required Widget widget, required BuildContext context}) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => widget));
  }

  static Future<dynamic> pushReplacement(
      {required Widget widget, required BuildContext context}) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => widget));
  }

  static Future<dynamic> pushAndRemoveUntil(
      {required Widget widget, required BuildContext context}) {
    return Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => widget), (route) => false);
  }
}
