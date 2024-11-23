import 'dart:async';

import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/modules/home/bloc/home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeLoading());
  late int currentIndex = 0;

  @override
  FutureOr<void> initCubit() {
    emit(HomeLoading());

    changePage(currentIndex);
  }

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {}

  FutureOr<void> changePage(int index) async {
    if (index == 0) {
      currentIndex = index;
      emit(HomeFirstPage());
      return;
    }

    if (index == 1) {
      currentIndex = index;
      emit(HomeSecondPage());
      return;
    }
  }
}
