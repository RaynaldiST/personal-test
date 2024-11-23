import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/constant/preferences.dart';
import 'package:test_project/modules/main/bloc/main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit() : super(MainLoading());

  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  late int currentIndex = 0;

  @override
  FutureOr<void> initCubit() async {
    emit(MainLoading());
    var user = await secureStorage.read(key: Preferences.user);

    if (user == null) {
      emit(MainUnauthenticated());
      return;
    } else {
      // Load home page
      emit(MainLoaded());
      emit(MainFirstPage());
    }
  }

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {}

  FutureOr<void> changePage(int index) async {
    if (index == 0) {
      currentIndex = index;
      emit(MainFirstPage());
      return;
    }

    if (index == 1) {
      currentIndex = index;
      emit(MainSecondPage());
      return;
    }
  }
}
