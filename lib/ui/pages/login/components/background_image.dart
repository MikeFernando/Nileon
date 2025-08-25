import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('lib/ui/assets/star.png'),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

Widget backgroundImage() => const BackgroundImage();
