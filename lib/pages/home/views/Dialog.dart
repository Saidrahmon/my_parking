import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkovka/widgets/ButtonWidget.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'KeyValueWidget.dart';



  void showAsBottomSheet(String namePark, double cost, String numberAuto) async {
    final result =
    await showSlidingBottomSheet(Get.context!, builder: (context) {
      return SlidingSheetDialog(
        backdropColor: Colors.transparent,
        cornerRadius: 8,
        duration: Duration(milliseconds: 500),
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.5],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return Container(
            height: 300,
            child: Center(
              child: Material(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      KeyValueWidget(label: 'Avtomobil', value: numberAuto),
                      KeyValueWidget(label: 'Parkovka', value: namePark),
                      KeyValueWidget(label: 'Narxi', value: '${cost} so\'m'),
                      ButtonWidget(
                        label: 'Band qilish',
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
    print(result); // This is the result.
  }
