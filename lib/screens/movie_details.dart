import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/cubit/movie_details_tab_cubit.dart';
import 'package:flutter_netflix/widgets/episode_box.dart';
import 'package:flutter_netflix/widgets/netflix_dropdown.dart';
import 'package:flutter_netflix/widgets/poster_image.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../bloc/netflix_bloc.dart';
import '../model/movie.dart';
import '../repository/repository.dart';
import '../utils/utils.dart';
import '../widgets/movie_box.dart';
import '../widgets/movie_trailer.dart';
import '../widgets/new_and_hot_tile_action.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: widget.movie.type == 'tv' ? 3 : 2, vsync: this)
        ..addListener(() {
          context.read<MovieDetailsTabCubit>().setTab(_tabController.index);
        });

  @override
  void initState() {
    if (widget.movie.type == 'tv') {
      context
          .read<TvShowSeasonSelectorBloc>()
          .add(SelectTvShowSeason(widget.movie.id, 1));
    }
    context.read<MovieDetailsTabCubit>().setTab(_tabController.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final configuration = context.watch<ConfigurationBloc>().state;

    if (widget.movie.details) {
      return _buildDetails(widget.movie, configuration);
    }
    return FutureBuilder(
        future: context
            .watch<TMDBRepository>()
            .getDetails(widget.movie.id, widget.movie.type),
        builder: (context, AsyncSnapshot<Movie> snapshoot) {
          if (snapshoot.hasError || !snapshoot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return _buildDetails(snapshoot.data!, configuration);
        });
  }

  Widget _buildDetails(Movie movie, ConfigurationState configuration) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.cast),
              onPressed: () {},
            ),
          ],
          pinned: true,
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          Stack(
            children: [
              PosterImage(
                movie: movie,
                backdrop: true,
                borderRadius: BorderRadius.zero,
              ),
              Positioned(
                  bottom: 12.0,
                  left: 6.0,
                  child: SizedBox(
                    height: 32.0,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black.withOpacity(.3)),
                        onPressed: () {},
                        child: const Text('Preview')),
                  )),
              Positioned(
                  bottom: 6.0,
                  right: 6.0,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(LucideIcons.volumeX)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 32.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '${movie.releaseDate!.year}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.grey.shade700),
                    child: const Text(
                      '16+',
                      style: TextStyle(letterSpacing: 1.0),
                    )),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  movie.getRuntime(),
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.grey.shade300),
                    child: const Text(
                      'HD',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.grey.shade900,
                    foregroundColor: Colors.white),
                onPressed: () {},
                icon: const Icon(LucideIcons.download),
                label: const Text('Download S1:E1')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.overview),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                    'Starring: Bob Odenkirk, Jonathan Banks, Rhea Seehorn...'),
                const SizedBox(
                  height: 8.0,
                ),
                const Text('Creators: Vince Gilligan, Peter Gould'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              NewAndHotTileAction(
                icon: LucideIcons.plus,
                label: 'My List',
              ),
              NewAndHotTileAction(
                icon: LucideIcons.thumbsUp,
                label: 'Rate',
              ),
              NewAndHotTileAction(
                icon: LucideIcons.share2,
                label: 'Share',
              ),
              NewAndHotTileAction(
                icon: LucideIcons.download,
                label: 'Download Season 1',
              )
            ],
          ),
          const Text(
            'Fast Laughs',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          SizedBox(
            height: 180.0,
            child: Builder(builder: (context) {
              final movies =
                  context.watch<TrendingTvShowListWeeklyBloc>().state;

              if (movies is TrendingTvShowLisWeekly) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.list.length,
                    itemBuilder: (context, index) {
                      final movie = movies.list[index];
                      return MovieBox(
                        key: ValueKey(movie.id),
                        movie: movie,
                        laughs: 100,
                      );
                    });
              }
              return Container();
            }),
          ),
          const Divider(
            height: 1.0,
          ),
          TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: redColor,
                  width: 4.0,
                )),
              ),
              tabs: [
                if (movie.type == 'tv')
                  const Tab(
                    text: 'Episodes',
                  ),
                const Tab(
                  text: 'Trailers & More',
                ),
                const Tab(
                  text: 'More Like This',
                ),
              ]),
        ])),
        Builder(builder: (context) {
          final tabIndex = context.watch<MovieDetailsTabCubit>().state;
          if (tabIndex == 0 && movie.type == 'tv') {
            final state = context.watch<TvShowSeasonSelectorBloc>().state;
            if (state is SelectedTvShowSeason) {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 0) {
                    return _seasonDropdown(movie, state.season.seasonNumber);
                  }

                  return EpisodeBox(
                      episode: state.season.episodes[index - 1],
                      fill: true,
                      padding: EdgeInsets.zero);
                }, childCount: state.season.episodes.length + 1),
              );
            }
          } else if (tabIndex == 1 && movie.type == 'tv' ||
              tabIndex == 0 && movie.type == 'movie') {
            final movies = context.watch<TrendingMovieListDailyBloc>().state;

            if (movies is TrendingMovieListDaily) {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final movie = movies.list[index];
                  return MovieTrailer(
                      key: ValueKey(movie.id),
                      movie: movie,
                      fill: true,
                      padding: EdgeInsets.zero);
                }, childCount: movies.list.length),
              );
            }
          } else {
            final movies = context.watch<TrendingTvShowListDailyBloc>().state;
            if (movies is TrendingTvShowListDaily) {
              return SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final movie = movies.list[index];
                  return MovieBox(
                      key: ValueKey(movie.id),
                      movie: movie,
                      fill: true,
                      padding: EdgeInsets.zero);
                }, childCount: min(12, movies.list.length)),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0),
              );
            }
          }
          return const SliverToBoxAdapter();
        })
      ],
    );
  }

  void _openSeasonSelector(Movie movie) {
    OverlayEntry? overlay;
    overlay = OverlayEntry(
      builder: (context) {
        return NetflixDropDownScreen(
            movie: movie,
            selected: (context.read<TvShowSeasonSelectorBloc>().state
                    as SelectedTvShowSeason)
                .season
                .seasonNumber,
            onPop: () {
              overlay?.remove();
            });
      },
    );

    Overlay.of(context, rootOverlay: true)?.insert(overlay);
  }

  Widget _seasonDropdown(Movie movie, int seasonNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade900),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Season $seasonNumber',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Icon(
                  LucideIcons.chevronDown,
                  size: 14.0,
                )
              ],
            ),
            onPressed: () {
              _openSeasonSelector(movie);
            }),
        const SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}
