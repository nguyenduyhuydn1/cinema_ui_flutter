import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String text;

  const CustomTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
      TextButton(
        onPressed: () {},
        child: const Text(
          "See all",
          style: TextStyle(color: Colors.grey),
        ),
      )
    ]);
  }
}
