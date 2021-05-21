import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkovka/config/Config.dart';
import 'package:parkovka/AppRoutes.dart';

class ButtonWidget extends StatelessWidget {

  String label;

  ButtonWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: MaterialButton(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: Config.defaultTextSize,
                  color: Colors.white),
            ),
          ],
        ),
        onPressed: () {
          Get.toNamed(AppRoutes.payment);
        },
      ),
    );
  }
}
