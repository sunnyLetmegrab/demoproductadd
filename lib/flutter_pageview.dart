import 'dart:math';

import 'package:flutter/material.dart';

class FlutterPageView extends StatefulWidget {
  const FlutterPageView({super.key});

  @override
  State<FlutterPageView> createState() => _FlutterPageViewState();
}

class _FlutterPageViewState extends State<FlutterPageView> {
  PageController pageController = PageController(
    viewportFraction: .5,
    initialPage: 1,
  );
  var currentPage = ValueNotifier(0);
  var colors = [
    Colors.red,
    Colors.black,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      pageController.addListener(() {
        currentPage.value = pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.bottomCenter,
        child: PageView(
          controller: pageController,
          children: colors.indexed
              .map(
                (e) => ValueListenableBuilder(
                  valueListenable: currentPage,
                  builder: (context, value, child) => Transform.rotate(
                    angle:  0*pi,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: e.$2,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
