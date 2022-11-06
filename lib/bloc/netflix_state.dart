part of 'netflix_bloc.dart';

class ProfileState {
  final int profile;

  ProfileState(this.profile);
}

abstract class MovieState {}

class MovieInitial extends MovieState {}

class TrendingMovieListWeekly extends MovieState {
  final List<Movie> list;

  TrendingMovieListWeekly(this.list);
}

class TrendingMovieListDaily extends MovieState {
  final List<Movie> list;

  TrendingMovieListDaily(this.list);
}

class TrendingTvShowLisWeekly extends MovieState {
  final List<Movie> list;

  TrendingTvShowLisWeekly(this.list);
}

class TrendingTvShowListDaily extends MovieState {
  final List<Movie> list;

  TrendingTvShowListDaily(this.list);
}

class SelectedTvShowSeason extends MovieState {
  final Season season;

  SelectedTvShowSeason(this.season);
}

class ConfigurationState {
  final Configuration? data;

  ConfigurationState({this.data});
}

class DiscoverTvShows extends MovieState {
  final List<Movie> list;

  DiscoverTvShows(this.list);
}

class DiscoverMovies extends MovieState {
  final List<Movie> list;

  DiscoverMovies(this.list);
}
