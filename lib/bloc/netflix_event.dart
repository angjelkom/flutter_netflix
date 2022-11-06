part of 'netflix_bloc.dart';

abstract class MovieEvent {}

class FetchTrendingMovieListWeekly extends MovieEvent {}

class FetchTrendingMovieListDaily extends MovieEvent {}

class FetchTrendingTvShowListWeekly extends MovieEvent {}

class FetchTrendingTvShowListDaily extends MovieEvent {}

class SelectTvShowSeason extends MovieEvent {
  final int id;
  final int season;

  SelectTvShowSeason(this.id, this.season);
}

abstract class ConfigurationEvent {}

class FetchConfiguration extends ConfigurationEvent {}

class DiscoverTvShowsEvent extends MovieEvent {}

class DiscoverMoviesEvent extends MovieEvent {}

abstract class ProfileEvent {}

class SelectProfile extends ProfileEvent {
  final int profile;

  SelectProfile(this.profile);
}
