import 'package:carrot_flutter/src/screen/auth/intro.dart';
import 'package:carrot_flutter/src/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp(this.isLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: isLogin ? const Home() : const Intro(),
    );
  }
}
