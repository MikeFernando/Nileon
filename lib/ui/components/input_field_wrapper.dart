import 'package:flutter/material.dart';

class InputFieldWrapper extends StatelessWidget {
  const InputFieldWrapper({
    super.key,
    required this.child,
    this.topPadding = 8.0,
    this.bottomPadding = 16.0,
  });

  final Widget child;
  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: child,
    );
  }
}
