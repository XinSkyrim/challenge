import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_challenge/pages/Main/index.dart';
import 'package:flutter_challenge/stores/UserController.dart';

Widget getRootWidget() {
  Get.put(UserController());
  return MaterialApp(initialRoute: '/', routes: getRootroutes());
}

Map<String, WidgetBuilder> getRootroutes() {
  return {'/': (context) => MainPage()};
}
