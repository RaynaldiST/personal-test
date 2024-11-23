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
  bool isRefresh = false;

  @override
  FutureOr<void> initCubit() async {
    emit(ContactLoading());

    var response;
    if (isRefresh) {
      users.clear();
      secureStorage.delete(key: Preferences.contacts);
    }

    String? userString = await secureStorage.read(key: Preferences.user);
    user = User.fromJson(json.decode(userString!));

    String? contactsString = await secureStorage.read(
      key: Preferences.contacts,
    );

    if (contactsString != Null) {
      response = await repository.getContacts();
      users = response["users"];
      secureStorage.write(
        key: Preferences.contacts,
        value: jsonEncode(users),
      );
    } else {
      users = json.decode(contactsString!);
    }

    emit(ContactLoaded(users));
  }

  @override
  FutureOr<void> loadCubit() async {}

  @override
  FutureOr<void> postCubit() {
    /// Update selected data
  }

  FutureOr<void> updateData(User updatedUser) async {
    emit(ContactLoading());
    User selectedUser = users.firstWhere((data) => data.id == updatedUser.id);

    if (selectedUser != Null) {
      selectedUser.id = updatedUser.id;
      selectedUser.firstName = updatedUser.firstName;
      selectedUser.lastName = updatedUser.lastName;
      selectedUser.email = updatedUser.email;
      selectedUser.dob = updatedUser.dob;

      secureStorage.delete(key: Preferences.contacts);
      secureStorage.write(key: Preferences.contacts, value: jsonEncode(users));
    }

    emit(ContactLoaded(users));
  }

  FutureOr<void> removeData(User updatedUser) async {
    emit(ContactLoading());
    users.removeWhere((data) => data.id == updatedUser.id);

    secureStorage.delete(key: Preferences.contacts);
    secureStorage.write(key: Preferences.contacts, value: jsonEncode(users));
    emit(ContactLoaded(users));
  }
}
