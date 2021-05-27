import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkovka/AppPages.dart';
import 'package:parkovka/AppRoutes.dart';
import 'package:parkovka/pages/enter/enterView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: EnterView(),
      getPages: AppPages.pages,
    );
  }






}
