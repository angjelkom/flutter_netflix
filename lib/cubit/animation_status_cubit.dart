import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationStatusCubit extends Cubit<AnimationStatus?> {
  AnimationStatusCubit() : super(null);

  void onStatus(AnimationStatus? status) {
    emit(status);
  }
}
