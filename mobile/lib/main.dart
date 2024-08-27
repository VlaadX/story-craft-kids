import 'package:flutter/material.dart';
import 'package:story_craft_kids/modules/history_view/page.dart';
import 'package:story_craft_kids/modules/home/page.dart';
import 'package:story_craft_kids/modules/splash/page.dart';
import 'package:story_craft_kids/modules/list/page.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/list": (context) => List(),
        "/home": (context) => Home(),
        "/history": (context) => HistoryView(historyId: -1)
      },
    );
  }
}