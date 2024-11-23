import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/component/data/models/user.dart';
import 'package:test_project/modules/detail_contact/bloc/detail_contact_state.dart';

class DetailContactCubit extends BaseCubit<DetailContactState> {
  DetailContactCubit({required this.data}) : super(DetailContactLoading());

  dynamic data;
  late bool isEdited = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  User user = User();

  String userInitial = "";

  @override
  FutureOr<void> initCubit() {
    emit(DetailContactLoading());

    if (data != null) {
      isEdited = true;
      user = data["user"];

      userInitial = "${user.firstName![0]}${user.lastName![0]}";
    }

    emit(DetailContactLoaded());
  }

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {}
}
