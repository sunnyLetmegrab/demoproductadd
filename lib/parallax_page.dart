import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ParallaxPage extends StatefulWidget {
  const ParallaxPage({super.key});

  @override
  State<ParallaxPage> createState() => _ParallaxPageState();
}

class _ParallaxPageState extends State<ParallaxPage> {
  var scrollController = ScrollController();

  double offset = 0.0;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      offset = scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green.shade300, Colors.lightGreen.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/mountains-layer-4.svg',
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/mountains-layer-2.svg',
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/trees-layer-2.svg',
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/layer-1.svg',
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
