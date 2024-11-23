import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/constant/preferences.dart';
import 'package:test_project/modules/auth/bloc/auth_state.dart';
import 'package:test_project/modules/auth/repository/auth_repository.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthRepository repository = AuthRepository();

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

  FutureOr<void> validateUser() async {
    String emailUser = emailController.text;
    var params = {"email": emailUser};

    var response = await repository.validateEmail(params);

    if (response["isValid"] == true) {
      Map<String, dynamic> user = response["user"].toJson();
      secureStorage.write(key: Preferences.user, value: jsonEncode(user));
      emit(AuthAuthenticate());
      return;
    } else {
      emit(AuthFailed());
      emit(AuthLoaded());
      return;
    }
  }
}
