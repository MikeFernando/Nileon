import 'package:flutter/material.dart';
import '../../../components/or_divider.dart';

Column orDivider() {
  return const Column(
    children: [
      SizedBox(height: 16),
      OrDivider(),
      SizedBox(height: 16),
    ],
  );
}
