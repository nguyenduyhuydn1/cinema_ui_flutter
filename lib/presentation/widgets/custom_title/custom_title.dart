import 'package:flutter/material.dart';

import 'package:cinema_ui_flutter/presentation/screens/screens.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final VoidCallback? loadNextPage;

  const CustomTitle({
    super.key,
    required this.text,
    this.loadNextPage,
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return TrendingScreen(
                text: text,
                loadNextPage: loadNextPage,
              );
            },
          ));
        },
        child: const Text(
          "See all",
          style: TextStyle(color: Colors.grey),
        ),
      )
    ]);
  }
}
