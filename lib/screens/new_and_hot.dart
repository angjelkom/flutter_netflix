import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/bloc/netflix_bloc.dart';

import '../widgets/new_and_hot_header_delegate.dart';
import '../widgets/new_and_hot_tile.dart';

class NewAndHotScreen extends StatefulWidget {
  const NewAndHotScreen({super.key});

  @override
  State<NewAndHotScreen> createState() => _NewAndHotScreenState();
}

class _NewAndHotScreenState extends State<NewAndHotScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {
      if (_scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        int newIndex = max(0, min(_scrollController.offset ~/ 3000, 2));
        if (_tabController.index != newIndex) {
          _tabController.animateTo(newIndex);
        }
      }
    });

  late final TabController _tabController =
      TabController(length: 3, vsync: this)
        ..addListener(() {
          if (_tabController.indexIsChanging &&
              _scrollController.position.userScrollDirection ==
                  ScrollDirection.idle) {
            var offset = _scrollController.offset,
                minRange = offset - 300,
                maxRange = offset + 300,
                offsetTo = _tabController.index * 3000.0;

            if (!(minRange <= offsetTo && maxRange >= offsetTo)) {
              _scrollController.animateTo(_tabController.index * 3000.0,
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 1000));
            }
          }
        });

  @override
  void initState() {
    context.read<DiscoverTvShowsBloc>().add(DiscoverTvShowsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: NewAndHotHeaderDelegate(tabController: _tabController),
            pinned: true,
          ),
          Builder(builder: (context) {
            final movies = context.watch<DiscoverTvShowsBloc>().state;
            if (movies is DiscoverTvShows) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => NewAndHotTile(
                            movie: movies.list[index],
                          ),
                      childCount: movies.list.length));
            }
            return const SliverToBoxAdapter();
          }),
          Builder(builder: (context) {
            final movies = context.watch<DiscoverMoviesBloc>().state;
            if (movies is DiscoverMovies) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => NewAndHotTile(
                            movie: movies.list[index],
                          ),
                      childCount: movies.list.length));
            }
            return const SliverToBoxAdapter();
          }),
        ],
      ),
    );
  }
}
