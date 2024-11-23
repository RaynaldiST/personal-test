import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/component/data/models/user.dart';
import 'package:test_project/constant/preferences.dart';
import 'package:test_project/modules/contact/bloc/contact_state.dart';
import 'package:test_project/modules/contact/repository/contact_repository.dart';

class ContactCubit extends BaseCubit<ContactState> {
  ContactRepository repository = ContactRepository();

  ContactCubit() : super(ContactLoading());

  TextEditingController searchController = TextEditingController();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  List<User> users = [];
  User user = User();

  @override
  FutureOr<void> initCubit() async {
    emit(ContactLoading());

    String? userString = await secureStorage.read(key: Preferences.user);
    user = User.fromJson(json.decode(userString!));

    var response = await repository.getContacts();
    users = response["users"];

    emit(ContactLoaded());
  }

  @override
  FutureOr<void> loadCubit() async {}

  @override
  FutureOr<void> postCubit() {}
}
