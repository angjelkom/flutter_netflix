import 'package:flutter/material.dart';

class NetflixTab extends StatelessWidget {
  const NetflixTab({super.key, required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Row(
      children: [
        Image.asset(
          'assets/$icon',
          width: 20.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ));
  }
}
