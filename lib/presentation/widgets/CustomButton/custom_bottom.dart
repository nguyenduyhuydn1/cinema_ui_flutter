import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onpressed,
    required this.icon,
  });

  final IconData icon;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onpressed,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            icon,
            color: Colors.white60,
            size: 30,
          ),
        ),
      ),
    );
  }
}
