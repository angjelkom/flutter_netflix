import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/cubit/animation_status_cubit.dart';
import 'package:flutter_netflix/model/movie.dart';
import 'package:flutter_netflix/screens/home.dart';
import 'package:flutter_netflix/screens/movie_details.dart';
import 'package:flutter_netflix/screens/netflix_scaffold.dart';
import 'package:flutter_netflix/screens/new_and_hot.dart';
import 'package:go_router/go_router.dart';

import 'bloc/blocs.dart';
import 'screens/profile_selection.dart';
import 'utils/utils.dart';

void main() => runApp(NetflixApp());

class NetflixApp extends StatelessWidget {
  NetflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocWidget(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Netflix',
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: backgroundColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
            )),
      ),
    );
  }

  final GlobalKey<NavigatorState> _navigatorState = GlobalKey<NavigatorState>();

  late final GoRouter _router = GoRouter(
    initialLocation: '/profile',
    navigatorKey: _navigatorState,
    routes: [
      GoRoute(
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileSelectionScreen();
        },
      ),
      ShellRoute(
        // observers: [_heroController],
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
