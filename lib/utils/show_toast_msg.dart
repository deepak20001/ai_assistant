import 'package:ai_assistant/main.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

/// Show Toast Message
Flushbar showToastMsg({
  required String message,
  required Color color,
}) {
  return Flushbar(
    message: message,
    backgroundColor: color,
    duration: const Duration(seconds: 3),
  )..show(navigatorKey.currentContext!);
}
