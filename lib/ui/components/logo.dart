import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.width = 21.0,
    this.height = 21.0,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/ui/assets/logo.png',
      width: width,
      height: height,
    );
  }
}
