import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/component/data/models/user.dart';
import 'package:test_project/constant/preferences.dart';
import 'package:test_project/modules/profile/bloc/profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  User user = User();
  String userInitial = "";

  @override
  FutureOr<void> initCubit() async {
    emit(ProfileLoading());

    String? userString = await secureStorage.read(key: Preferences.user);
    user = User.fromJson(json.decode(userString!));

    userInitial = "${user.firstName![0]}${user.lastName![0]}";

    emit(ProfileLoaded());
  }

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {
    secureStorage.delete(key: Preferences.user);
    emit(ProfileUnauthenticated());
  }
}
