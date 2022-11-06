import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/model/configuration.dart';
import 'package:flutter_netflix/model/season.dart';
import 'package:flutter_netflix/repository/repository.dart';

import '../model/movie.dart';

part 'netflix_event.dart';
part 'netflix_state.dart';

class ProfileSelectorBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileSelectorBloc() : super(ProfileState(0)) {
    on<SelectProfile>((event, emit) async {
      emit(ProfileState(event.profile));
    });
  }
}

class TrendingMovieListWeeklyBloc extends Bloc<MovieEvent, MovieState> {
  final TMDBRepository repository;
  TrendingMovieListWeeklyBloc({required this.repository})
      : super(MovieInitial()) {
    on<FetchTrendingMovieListWeekly>((event, emit) async {
      emit(
          TrendingMovieListWeekly(await repository.getTrending(type: 'movie')));
    });
  }
}

class TrendingMovieListDailyBloc extends Bloc<MovieEvent, MovieState> {
  final TMDBRepository repository;
  TrendingMovieListDailyBloc({required this.repository})
      : super(MovieInitial()) {
    on<FetchTrendingMovieListDaily>((event, emit) async {
      emit(TrendingMovieListDaily(
          await repository.getTrending(type: 'movie', time: 'day')));
    });
  }
}

class TrendingTvShowListWeeklyBloc extends Bloc<MovieEvent, MovieState> {
  final TMDBRepository repository;
  TrendingTvShowListWeeklyBloc({required this.repository})
      : super(MovieInitial()) {
    on<FetchTrendingTvShowListWeekly>((event, emit) async {
      emit(TrendingTvShowLisWeekly(await repository.getTrending(type: 'tv')));
    });
  }
}

class TrendingTvShowListDailyBloc extends Bloc<MovieEvent, MovieState> {
  final TMDBRepository repository;
  TrendingTvShowListDailyBloc({required this.repository})
      : super(MovieInitial()) {
    on<FetchTrendingTvShowListDaily>((event, emit) async {
      emit(TrendingTvShowListDaily(
          await repository.getTrending(type: 'tv', time: 'day')));
    });
  }
}

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final TMDBRepository repository;
  ConfigurationBloc({required this.repository}) : super(ConfigurationState()) {
    on<FetchConfiguration>((event, emit) async {
      emit(ConfigurationState(data: await repository.getConfiguration()));
    });
  }
}

class TvShowSeasonSelectorBloc extends Bloc<MovieEvent, MovieState> {
  final TMDBRepository repository;
  TvShowSeasonSelectorBloc({required this.repository}) : super(MovieInitial()) {
    on<SelectTvShowSeason>((event, emit) async {
      emit(SelectedTvShowSeason(
          await repository.getSeason(event.id, event.season)));
    });
  }
}

class DiscoverTvShowsBloc extends Bloc<MovieEvent, MovieState> {
  final TMDBRepository repository;
  DiscoverTvShowsBloc({required this.repository}) : super(MovieInitial()) {
    on<DiscoverTvShowsEvent>((event, emit) async {
      emit(DiscoverTvShows(await repository.discover('tv')));
    });
  }
}

class DiscoverMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final TMDBRepository repository;
  DiscoverMoviesBloc({required this.repository}) : super(MovieInitial()) {
    on<DiscoverMoviesEvent>((event, emit) async {
      emit(DiscoverMovies(await repository.discover('movie')));
    });
  }
}
