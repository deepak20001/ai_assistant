import 'package:ai_assistant/utils/common_colors.dart';
import 'package:ai_assistant/utils/common_const.dart';
import 'package:ai_assistant/utils/common_path.dart';
import 'package:ai_assistant/utils/common_routes.dart';
import 'package:ai_assistant/utils/common_widgets.dart/common_loader.dart';
import 'package:ai_assistant/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) =>
          Routes.pushReplacement(widget: const HomeScreen(), context: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * numD065),
              child: Image.asset(
                '${CommonPath.imagePath}app_logo.png',
                width: size.width * numD55,
              ),
            ),
            SizedBox(height: size.width * numD1),
            CommonLoader(size: size),
          ],
        ),
      ),
    );
  }
}
