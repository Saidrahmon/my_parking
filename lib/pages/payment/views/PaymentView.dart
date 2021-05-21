import 'package:flutter/material.dart';
import 'package:parkovka/config/Config.dart';
import 'package:parkovka/pages/home/views/KeyValueWidget.dart';
import 'package:parkovka/pages/payment/views/IconAndTitleWidgetr.dart';
import 'package:parkovka/widgets/ButtonWidget.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Column(
                      children: [
                        KeyValueWidget(
                            label: 'Yengil avtomobil', value: '10 B 266 PA'),
                        SizedBox(
                          height: 8,
                        ),
                        KeyValueWidget(label: 'Parkovka', value: 'Navoiy ko\'cha'),
                        SizedBox(
                          height: 8,
                        ),
                        KeyValueWidget(label: 'Vaqt', value: '1 soat')
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        KeyValueWidget(label: 'Narxi', value: '4000 so\'m'),
                        SizedBox(
                          height: 8,
                        ),
                        KeyValueWidget(label: 'Balans', value: '4000000 so\'m'),
                        SizedBox(
                          height: 8,
                        ),
                        KeyValueWidget(label: 'Vaqt', value: '1 soat')
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IconAndTitleWidget(
                          icon: Icons.credit_card,
                          title: 'Credit card',
                        ),
                      ),
                      Expanded(
                        child: IconAndTitleWidget(
                          icon: Icons.phone_android,
                          title: 'Mobil telefon',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ButtonWidget(label: 'Pul o\'tkazish')
          ],
        ),
      ),
    );
  }
}
