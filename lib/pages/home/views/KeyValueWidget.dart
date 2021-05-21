import 'package:flutter/material.dart';
import 'package:parkovka/config/Config.dart';

class KeyValueWidget extends StatelessWidget {
  String label;
  String value;

  KeyValueWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: Config.defaultTextSize, color: Colors.black),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          value,
          style: TextStyle(fontSize: Config.defaultTextSize, color: Colors.blue),
        ),
      ],
    );
  }
}
