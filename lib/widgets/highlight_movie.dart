import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/widgets/poster_image.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/netflix_bloc.dart';
import '../utils/utils.dart';
import 'genre.dart';
import 'logo_image.dart';
import 'new_and_hot_tile_action.dart';

class HighlightMovie extends StatelessWidget {
  const HighlightMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final movies = context.watch<DiscoverMoviesBloc>().state;
      final width = MediaQuery.of(context).size.width;
      if (movies is DiscoverMovies) {
        return Stack(
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: const Alignment(0.0, 0.2),
                      colors: [
                    Colors.black,
                    Colors.black.withOpacity(.92),
                    Colors.black.withOpacity(.8),
                    Colors.transparent
                  ])),
              child: PosterImage(
                original: true,
                borderRadius: BorderRadius.zero,
                movie: movies.list.first,
                width: width,
                height: width + (width * .6),
              ),
            ),
            Positioned(
              bottom: 0.0,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 38.0, vertical: 16.0),
                child: Column(
                  children: [
                    LogoImage(
                      movie: movies.list.first,
                      size: 3,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Genre(
                      genres: ['Pshychological', 'Dark', 'Drama', 'Movie'],
                      color: redColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const NewAndHotTileAction(
                          icon: LucideIcons.plus,
                          label: 'My List',
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 4.0),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black),
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Play')),
                        const NewAndHotTileAction(
                          icon: LucideIcons.info,
                          label: 'Info',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }
      return Shimmer(
        gradient: LinearGradient(
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
            ]),
        child: SizedBox(
          width: width,
          height: width + (width * .6),
        ),
      );
    });
  }
}
