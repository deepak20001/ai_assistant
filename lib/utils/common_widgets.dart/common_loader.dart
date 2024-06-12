import 'package:ai_assistant/utils/common_const.dart';
import 'package:ai_assistant/utils/common_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('${CommonPath.animationPath}loader.json',
        width: size.width * numD35);
  }
}
