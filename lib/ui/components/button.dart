import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.label,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? Theme.of(context).colorScheme.primary : Colors.grey,
          foregroundColor: enabled ? Colors.black : Colors.white,
        ),
        child: Text(label),
      ),
    );
  }
}
