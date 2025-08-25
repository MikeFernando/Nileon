import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  const Spacing({
    super.key,
    this.height = 8.0,
    this.width = 0.0,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

class SpacingH extends StatelessWidget {
  const SpacingH({super.key, this.height = 8.0});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class SpacingW extends StatelessWidget {
  const SpacingW({super.key, this.width = 8.0});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
