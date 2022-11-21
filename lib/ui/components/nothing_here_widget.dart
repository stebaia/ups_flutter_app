import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class NothingHereWidget extends StatelessWidget {
  const NothingHereWidget(
      {super.key, required this.height, required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          width: width,
          height: height,
          'assets/nothing.json',
          fit: BoxFit.contain,
        ),
        Text('Non c\'è nessun controller qui..')
      ],
    );
  }
}