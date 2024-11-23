import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/constant/preferences.dart';
import 'package:test_project/modules/auth/bloc/auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit() : super(AuthLoading());

  late TextEditingController emailController = TextEditingController();
  late FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final formKey = GlobalKey<FormState>();
  late String errorMessage = "";

  @override
  FutureOr<void> initCubit() {
    emit(AuthLoading());

    emit(AuthLoaded());
  }

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {}

  FutureOr<void> validateUser() {
    Map<String, String> user = {
      "id": "5c8a80f575270ddb54a18f86",
      "firstName": "Lidia",
      "lastName": "Wilkins",
      "email": "lidiawilkins@furnafix.com",
      "dob": "30/1/1962"
    };

    secureStorage.write(key: Preferences.user, value: jsonEncode(user));

    emit(AuthAuthenticate());
  }
}
