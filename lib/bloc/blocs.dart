import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/animation_status_cubit.dart';
import '../cubit/movie_details_tab_cubit.dart';
import '../repository/repository.dart';
import 'netflix_bloc.dart';

class BlocWidget extends StatelessWidget {
  BlocWidget({super.key, required this.child});

  final Widget child;

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
        child: child,
      ),
    );
  }
}
