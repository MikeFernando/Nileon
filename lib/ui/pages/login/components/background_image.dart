import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/ui/assets/star.png',
      fit: BoxFit.cover,
    );
  }
}
