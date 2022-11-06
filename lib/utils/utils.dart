import 'package:flutter/material.dart';

const backgroundColor = Color(0xff010101);
const bottomNavigationBarColor = Color(0xff121212);
const bottomSheetColor = Color(0xff2b2b2b);
const bottomSheetIconColor = Color(0xff3d3d3d);
const redColor = Color(0xffe50914);
final shimmerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Colors.grey[900]!,
      Colors.grey[900]!,
      Colors.grey[800]!,
      Colors.grey[900]!,
      Colors.grey[900]!
    ],
    stops: const <double>[
      0.0,
      0.35,
      0.5,
      0.65,
      1.0
    ]);
const profileColors = [
  Colors.amber,
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.purple
];
