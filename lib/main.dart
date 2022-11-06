import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/bloc/netflix_bloc.dart';
import 'package:flutter_netflix/cubit/animation_status_cubit.dart';
import 'package:flutter_netflix/cubit/movie_details_tab_cubit.dart';
import 'package:flutter_netflix/model/movie.dart';
import 'package:flutter_netflix/screens/home.dart';
import 'package:flutter_netflix/screens/movie_details.dart';
import 'package:flutter_netflix/screens/netflix_scaffold.dart';
import 'package:flutter_netflix/screens/new_and_hot.dart';
import 'package:go_router/go_router.dart';

import 'repository/repository.dart';
import 'screens/profile_selection.dart';
import 'utils/utils.dart';

void main() => runApp(NetflixApp());

class NetflixApp extends StatelessWidget {
  NetflixApp({super.key});

  final TMDBRepository _repository = TMDBRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileSelectorBloc>(
            create: (BuildContext context) => ProfileSelectorBloc(),
          ),
          BlocProvider<AnimationStatusCubit>(
            create: (BuildContext context) => AnimationStatusCubit(),
          ),
          BlocProvider<MovieDetailsTabCubit>(
            create: (BuildContext context) => MovieDetailsTabCubit(),
          ),
          BlocProvider<ConfigurationBloc>(
            create: (BuildContext context) =>
                ConfigurationBloc(repository: _repository)
                  ..add(FetchConfiguration()),
            lazy: false,
          ),
          BlocProvider<TrendingMovieListWeeklyBloc>(
            create: (BuildContext context) =>
                TrendingMovieListWeeklyBloc(repository: _repository),
          ),
          BlocProvider<TrendingMovieListDailyBloc>(
            create: (BuildContext context) =>
                TrendingMovieListDailyBloc(repository: _repository),
          ),
          BlocProvider<TrendingTvShowListWeeklyBloc>(
            create: (BuildContext context) =>
                TrendingTvShowListWeeklyBloc(repository: _repository),
          ),
          BlocProvider<TrendingTvShowListDailyBloc>(
            create: (BuildContext context) =>
                TrendingTvShowListDailyBloc(repository: _repository),
          ),
          BlocProvider<TvShowSeasonSelectorBloc>(
            create: (BuildContext context) =>
                TvShowSeasonSelectorBloc(repository: _repository),
          ),
          BlocProvider<DiscoverTvShowsBloc>(
            create: (BuildContext context) =>
                DiscoverTvShowsBloc(repository: _repository),
          ),
          BlocProvider<DiscoverMoviesBloc>(
            create: (BuildContext context) =>
                DiscoverMoviesBloc(repository: _repository),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          title: 'GoRouter Example',
          theme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: backgroundColor,
              appBarTheme: const AppBarTheme(backgroundColor: backgroundColor)),
        ),
      ),
    );
  }

  final HeroController _heroController = HeroController();

  late final GoRouter _router = GoRouter(
    initialLocation: '/profile',
    routes: [
      GoRoute(
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileSelectionScreen();
        },
      ),
      ShellRoute(
        observers: [_heroController],
        builder: (context, state, child) {
          return NetflixScaffold(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
              name: 'Home',
              path: '/home',
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
              routes: [
                GoRoute(
                    name: 'TV Shows',
                    path: 'tvshows',
                    builder: (BuildContext context, GoRouterState state) {
                      return HomeScreen(name: state.name);
                    },
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: HomeScreen(name: state.name),
                          transitionDuration: const Duration(milliseconds: 600),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            final status = context.read<AnimationStatusCubit>();
                            animation.removeStatusListener(status.onStatus);
                            animation.addStatusListener(status.onStatus);
                            secondaryAnimation
                                .removeStatusListener(status.onStatus);
                            secondaryAnimation
                                .addStatusListener(status.onStatus);
                            return FadeTransition(
                                opacity: animation, child: child);
                          });
                    },
                    routes: [
                      GoRoute(
                        path: 'details',
                        builder: (BuildContext context, GoRouterState state) {
                          return MovieDetailsScreen(
                              movie: state.extra as Movie);
                        },
                      ),
                    ]),
                GoRoute(
                  path: 'details',
                  builder: (BuildContext context, GoRouterState state) {
                    return MovieDetailsScreen(movie: state.extra as Movie);
                  },
                ),
              ]),
          GoRoute(
              path: '/newandhot',
              builder: (BuildContext context, GoRouterState state) {
                return const NewAndHotScreen();
              },
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (BuildContext context, GoRouterState state) {
                    return MovieDetailsScreen(movie: state.extra as Movie);
                  },
                ),
              ]),
        ],
      ),
    ],
  );
}
