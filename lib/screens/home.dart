import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/bloc/netflix_bloc.dart';
import 'package:flutter_netflix/cubit/animation_status_cubit.dart';
import 'package:flutter_netflix/widgets/highlight_movie.dart';
import 'package:flutter_netflix/widgets/movie_box.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../widgets/netflix_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.name});

  final String? name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });

  @override
  void initState() {
    context
        .read<TrendingTvShowListWeeklyBloc>()
        .add(FetchTrendingTvShowListWeekly());

    context
        .read<TrendingTvShowListDailyBloc>()
        .add(FetchTrendingTvShowListDaily());

    context
        .read<TrendingMovieListWeeklyBloc>()
        .add(FetchTrendingMovieListWeekly());

    context
        .read<TrendingMovieListDailyBloc>()
        .add(FetchTrendingMovieListDaily());

    context.read<DiscoverMoviesBloc>().add(DiscoverMoviesEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (GoRouterState.of(context).location != '/home/tvshows') {
      context.read<AnimationStatusCubit>().onStatus(null);
    }
    super.didChangeDependencies();
  }

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
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
          6,
          (index) => Container(
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red,
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              )),
    ),
  );

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(top: 16.0, bottom: 4.0);
    return NestedScrollView(
      physics: const ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: MultiSliver(children: [
                SliverPersistentHeader(
                  delegate: NetflixHeader(
                      scrollOffset: _scrollOffset, name: widget.name),
                  pinned: true,
                ),
              ])),
        ];
      },
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              const HighlightMovie(),
              const Padding(
                padding: padding,
                child: Text(
                  'Trending TV Shows This Week',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
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
                          );
                        });
                  }
                  return _shimmer;
                }),
              ),
              const Padding(
                padding: padding,
                child: Text(
                  'Trending TV Shows Today',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 180.0,
                child: Builder(builder: (context) {
                  final movies =
                      context.watch<TrendingTvShowListDailyBloc>().state;

                  if (movies is TrendingTvShowListDaily) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.list.length,
                        itemBuilder: (context, index) {
                          final movie = movies.list[index];
                          return MovieBox(
                            key: ValueKey(movie.id),
                            movie: movie,
                          );
                        });
                  }
                  return _shimmer;
                }),
              ),
              const Padding(
                padding: padding,
                child: Text(
                  'Trending Movies This Week',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 180.0,
                child: Builder(builder: (context) {
                  final movies =
                      context.watch<TrendingMovieListWeeklyBloc>().state;

                  if (movies is TrendingMovieListWeekly) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.list.length,
                        itemBuilder: (context, index) {
                          final movie = movies.list[index];
                          return MovieBox(
                            key: ValueKey(movie.id),
                            movie: movie,
                          );
                        });
                  }
                  return _shimmer;
                }),
              ),
              const Padding(
                padding: padding,
                child: Text(
                  'Trending Movies Today',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 180.0,
                child: Builder(builder: (context) {
                  final movies =
                      context.watch<TrendingMovieListDailyBloc>().state;

                  if (movies is TrendingMovieListDaily) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.list.length,
                        itemBuilder: (context, index) {
                          final movie = movies.list[index];
                          return MovieBox(
                            key: ValueKey(movie.id),
                            movie: movie,
                          );
                        });
                  }
                  return _shimmer;
                }),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
