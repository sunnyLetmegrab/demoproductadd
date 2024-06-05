import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ParallexPageView extends StatefulWidget {
  const ParallexPageView({super.key});

  @override
  State<ParallexPageView> createState() => _ParallexPageViewState();
}

class _ParallexPageViewState extends State<ParallexPageView> {
  var pagectrl = PageController(viewportFraction: .5);
  var offset = 0.0;

  @override
  void initState() {
    pagectrl = PageController(viewportFraction: .5);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pagectrl.addListener(() {
        setState(() {
          offset = pagectrl.page!;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 170,
        child: PageView.builder(
          controller: pagectrl,
          itemCount: 10,
          itemBuilder: (context, index) {
            return SlidingCard(
              index: index%10,
              color: index % 2 == 0 ? Colors.red : Colors.black,
              offset: offset,
            );
          },
        ),
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final Color color;
  final double offset;
  final int index;
  const SlidingCard(
      {super.key,
      required this.color,
      required this.offset,
      required this.index});

  @override
  Widget build(BuildContext context) {
    var scale = max(.5, 1 - (offset - index).abs() + .5);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          transform: GradientRotation(-offset.abs() * (pi / 4)),
          colors: color == Colors.red
              ? [
                  Colors.red,
                  Colors.blue,
                ]
              : [Colors.yellow, Colors.purple],
        ),
      ),
      child: Center(
        child: Container(
          // padding: EdgeInsets.only(top:60- (scale / 1.6 )*55),
          child: Text("title ${color.value}"),
        ),
      ),
    );
  }
}
