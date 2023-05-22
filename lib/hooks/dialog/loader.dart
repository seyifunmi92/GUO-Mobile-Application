import 'dart:math';

import 'package:flutter/material.dart';

class Loaderx extends StatefulWidget {
  String image;
  Loaderx(this.image);

  @override
  State<Loaderx> createState() => _LoaderxState();
}

class _LoaderxState extends State<Loaderx> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  loadAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadAnimation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
        width: 40,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: animationController.value * 2 * pi,
              child: child,
            );
          },
          child: Image.asset(
            widget.image,
            fit: BoxFit.contain,
          ),
        ),
      )),
    );
  }
}
