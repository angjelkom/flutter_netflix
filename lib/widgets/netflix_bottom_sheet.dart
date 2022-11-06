import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/repository/repository.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../model/movie.dart';
import '../utils/utils.dart';
import 'bottom_sheet_button.dart';

class NetflixBottomSheet extends StatelessWidget {
  NetflixBottomSheet({super.key, required this.thumbnail, required this.movie});

  final ImageProvider thumbnail;
  final Movie movie;

  final _shimmer = Shimmer(
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
    child: Row(
      children: const [
        Text(
          '2022',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          '18+',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          '10 Episodes',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            context.watch<TMDBRepository>().getDetails(movie.id, movie.type),
        builder: (context, AsyncSnapshot<Movie> snapshoot) {
          final movieDetails = snapshoot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image(
                            image: thumbnail,
                            fit: BoxFit.contain,
                            width: 88.0,
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Image.asset(
                              'assets/netflix_symbol.png',
                              width: 24.0,
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  textDirection: TextDirection.ltr,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      movie.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    snapshoot.hasError || !snapshoot.hasData
                                        ? _shimmer
                                        : Row(
                                            children: [
                                              Text(
                                                '${movieDetails?.releaseDate?.year ?? '2022'}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                              ),
                                              const SizedBox(
                                                width: 8.0,
                                              ),
                                              const Text(
                                                '18+',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                              ),
                                              const SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                movieDetails?.getRuntime() ??
                                                    '10 Episodes',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(100.0),
                                radius: 32.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: bottomSheetIconColor,
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  child: const Icon(
                                    LucideIcons.x,
                                    size: 28.0,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            movie.overview,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    BottomSheetButton(
                      icon: Icons.play_arrow,
                      label: 'Play',
                      size: 32.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                      light: true,
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.download,
                      label: 'Download',
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.plus,
                      label: 'My List',
                    ),
                    BottomSheetButton(
                      icon: LucideIcons.share2,
                      label: 'Share',
                    )
                  ],
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    context.go('${GoRouter.of(context).location}/details',
                        extra: movieDetails);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(LucideIcons.info),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(movie.type == 'tv'
                              ? 'Episodes & Info'
                              : 'Details & More'),
                        ],
                      ),
                      const Icon(LucideIcons.chevronRight)
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
