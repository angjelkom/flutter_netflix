import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../bloc/netflix_bloc.dart';
import '../model/movie.dart';
import '../model/tmdb_image.dart';
import '../repository/repository.dart';
import 'poster_image.dart';

class NewAndHotTile extends StatelessWidget {
  const NewAndHotTile({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    var date = movie.releaseDate ?? DateTime.now();
    return InkWell(
      onTap: () {
        context.go('${GoRouter.of(context).location}/details', extra: movie);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('MMM').format(date).toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.grey),
              ),
              Text(
                DateFormat('dd').format(date),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 32.0),
              )
            ],
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PosterImage(movie: movie, backdrop: true),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder(
                        future: context
                            .watch<TMDBRepository>()
                            .getImages(movie.id, movie.type),
                        builder: (context, AsyncSnapshot<TMDBImages> snapshot) {
                          if (snapshot.hasError ||
                              !snapshot.hasData ||
                              snapshot.data!.logos.isEmpty) {
                            return Container();
                          }
                          final configuration =
                              context.watch<ConfigurationBloc>().state;
                          final url =
                              '${configuration.data?.images.baseUrl}/${configuration.data?.images.logoSizes[2]}${snapshot.data?.logos[0].filePath}';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: CachedNetworkImage(imageUrl: url),
                          );
                        }),
                    const Spacer(),
                    IconButton(
                      padding: const EdgeInsets.all(24),
                      icon: const Icon(LucideIcons.bell),
                      onPressed: () {},
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(24),
                      icon: const Icon(LucideIcons.info),
                      onPressed: () {},
                    )
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coming ${DateFormat('EEEE').format(date)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      movie.overview,
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      'Pshychological • Dark • Drama • Keeping Secrets • Movie',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
