import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(State initialState) : super(initialState);

  FutureOr<void> initCubit();

  FutureOr<void> loadCubit();

  FutureOr<void> postCubit();
}
