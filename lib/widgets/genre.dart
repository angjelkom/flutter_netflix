import 'package:flutter/material.dart';

class Genre extends StatelessWidget {
  const Genre({super.key, this.color, required this.genres});

  final Color? color;
  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style, children: _buildSpan()),
    );
  }

  List<TextSpan> _buildSpan() {
    final dots = TextSpan(text: ' • ', style: TextStyle(color: color));

    List<TextSpan> span = [];

    for (String genre in genres) {
      span.add(TextSpan(text: genre));
      span.add(dots);
    }
    span.removeLast();
    return span;
  }
}
