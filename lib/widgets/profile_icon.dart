import 'package:flutter/material.dart';

import '../screens/profile_selection.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key, this.iconSize, required this.color});

  final double? iconSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(iconSize == null ? 6 : 4)),
        ),
        iconSize != null
            ? CustomPaint(
                painter: Smile(),
                size: Size(iconSize!, iconSize!),
              )
            : CustomPaint(
                painter: Smile(),
                child: Container(),
              )
      ],
    );
  }
}
