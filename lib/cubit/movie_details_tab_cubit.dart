import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsTabCubit extends Cubit<int> {
  MovieDetailsTabCubit() : super(0);

  void setTab(int index) => emit(index);
}
