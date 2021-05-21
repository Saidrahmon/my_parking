import 'package:flutter/material.dart';
import 'package:parkovka/config/Config.dart';

class IconAndTitleWidget extends StatelessWidget {

  IconData icon;
  String title;

  IconAndTitleWidget({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Icon(icon),
          SizedBox(height: 8,),
          Text(
            title,
            style: TextStyle(fontSize: Config.defaultTextSize, color: Colors.black),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.all(16),
    );
  }
}
