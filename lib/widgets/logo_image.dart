import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/model/movie.dart';

import '../bloc/netflix_bloc.dart';
import '../model/tmdb_image.dart';
import '../repository/repository.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key, required this.movie, this.size = 1});

  final Movie movie;
  final int size;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<TMDBRepository>().getImages(movie.id, movie.type),
        builder: (context, AsyncSnapshot<TMDBImages> snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.logos.isEmpty) {
            return Container();
          }

          final configuration = context.watch<ConfigurationBloc>().state;
          final url =
              '${configuration.data?.images.baseUrl}${configuration.data?.images.logoSizes[size]}${snapshot.data?.logos[0].filePath}';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CachedNetworkImage(imageUrl: url),
          );
        });
  }
}
