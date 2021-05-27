import 'package:flutter/material.dart';

class CustomMarkerWidget extends StatelessWidget {

  String costLabel;

  CustomMarkerWidget({required this.costLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.red,
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        '$costLabel uzs',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
