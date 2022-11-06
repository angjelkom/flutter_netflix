import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/netflix_bloc.dart';
import '../model/movie.dart';

class NetflixDropDownScreen extends StatelessWidget {
  const NetflixDropDownScreen(
      {super.key,
      required this.onPop,
      required this.movie,
      required this.selected});

  final Movie movie;
  final int selected;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onPop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.9),
        body: Center(
          child: ListView.builder(
            itemCount: movie.seasons,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              var season = index + 1;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Season $season',
                      style: selected == season
                          ? const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800)
                          : const TextStyle(color: Colors.grey, fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    context
                        .read<TvShowSeasonSelectorBloc>()
                        .add(SelectTvShowSeason(movie.id, season));
                    onPop();
                  },
                ),
              );
            }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: onPop,
            child: const Icon(Icons.close)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
