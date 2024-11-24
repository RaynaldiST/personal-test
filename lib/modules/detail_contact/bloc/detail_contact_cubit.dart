import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/component/data/models/user.dart';
import 'package:test_project/constant/preferences.dart';
import 'package:test_project/modules/detail_contact/bloc/detail_contact_state.dart';

class DetailContactCubit extends BaseCubit<DetailContactState> {
  DetailContactCubit({required this.data}) : super(DetailContactLoading());

  dynamic data;
  late bool isEdited = false;
  late bool isSaveActive = false;
  late bool isRemoveActive = false;
  late bool isUpdateActive = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  User user = User();
  User userUpdate = User();

  final formKey = GlobalKey<FormState>();

  String userInitial = "";
  String errorMessage = "";

  @override
  FutureOr<void> initCubit() {
    emit(DetailContactLoading());

    if (data != null) {
      isEdited = true;
      user = data["user"];

      isUpdateActive = true;
      isRemoveActive = true;

      userInitial = "${user.firstName![0]}${user.lastName![0]}";

      firstNameController.text = user.firstName!;
      lastNameController.text = user.lastName!;
      emailController.text = user.email!;
      dobController.text = user.dob!;
    } else {
      isSaveActive = true;
    }

    emit(DetailContactLoaded());
  }

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {
    String? initialName =
        "${firstNameController.text[0]}${lastNameController.text[0]}";

    userUpdate = User(
      id: user.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      dob: dobController.text,
      group: firstNameController.text[0],
      initialName: initialName,
    );

    if (data["isFromProfile"]) {
      secureStorage.write(
        key: Preferences.user,
        value: jsonEncode(userUpdate.toJson()),
      );
      emit(DetailContactUpdated());
    }
  }

  FutureOr<void> removeData() {
    if (data["isFromProfile"]) {
      /// remove data on cache
    }

    emit(DetailContactDelete());
  }

  FutureOr<void> validateInput() async {
    if (firstNameController.text.isEmpty) {
      errorMessage = "First name cant be empty";
      emit(DetailContactInvalid());
    }

    if (lastNameController.text.isEmpty) {
      errorMessage = "Last name cant be empty";
      emit(DetailContactInvalid());
    }

    if (!emailController.text.contains("@")) {
      errorMessage = "Email invalid";
      emit(DetailContactInvalid());
    }

    postCubit();
    emit(DetailContactValid());
  }
}
