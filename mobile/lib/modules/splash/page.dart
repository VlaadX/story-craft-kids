import 'package:flutter/material.dart';
import 'package:story_craft_kids/modules/splash/controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SplashController();
    controller.delay(context);
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      child: Center(
          child: Container(
            height: 350,
            width: 350,
            child: Image.asset("assets/images/splash.png"),
          )),
    );
  }
}