import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:parkovka/AppRoutes.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class EnterView extends StatefulWidget {
  @override
  _EnterViewState createState() => _EnterViewState();
}

class _EnterViewState extends State<EnterView> {
  late int selectedPage;
  late final PageController _pageController;
  final pageCount = 5;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        selectedPage = page;
                      });
                    },
                    children: List.generate(pageCount, (index) {
                      return Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 100,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      child: Text('Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello',  textAlign: TextAlign.center,),
                                    ),
                                  ),
                                  Positioned(
                                    top: 400,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      child: Text('Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello',  textAlign: TextAlign.center,),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.decelerate, );
                      selectedPage++;
                      if(selectedPage > pageCount - 1){
                        Get.toNamed(AppRoutes.home);
                      }
                    },
                  ),
                )
              ],
            ),
            Positioned(
              top: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PageViewDotIndicator(
                  currentItem: selectedPage,
                  count: pageCount,
                  unselectedColor: Colors.black26,
                  selectedColor: Colors.blue,
                  duration: Duration(milliseconds: 200),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
