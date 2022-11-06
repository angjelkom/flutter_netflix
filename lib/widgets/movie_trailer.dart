import 'package:flutter/material.dart';
import 'package:flutter_netflix/model/movie.dart';
import 'package:flutter_netflix/widgets/poster_image.dart';

class MovieTrailer extends StatelessWidget {
  const MovieTrailer(
      {super.key, required this.movie, this.fill = false, this.padding});

  final Movie movie;
  final bool fill;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PosterImage(movie: movie, original: true),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          movie.name,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 32.0,
        )
      ],
    );
  }
}
