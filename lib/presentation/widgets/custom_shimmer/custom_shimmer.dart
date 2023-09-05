import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double width;
  final double height;

  const CustomShimmer({
    super.key,
    this.width = double.infinity,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.white.withOpacity(0.6),
      period: const Duration(seconds: 1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.withOpacity(0.9),
        ),
      ),
    );
  }
}
