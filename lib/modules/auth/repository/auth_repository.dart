import 'dart:developer';

import 'package:test_project/component/data/api_provider.dart';
import 'package:test_project/component/data/models/user.dart';

class AuthRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<dynamic> validateEmail(dynamic params) async {
    List<User> users = [];
    bool valid = false;

    var response = await apiProvider.getContactList();
    users = response.map((data) => User.fromJson(data!)).toList();

    User user = users.firstWhere(
      (data) => data.email == params["email"],
      orElse: () => User(),
    );

    if (user != Null && user.email != null) {
      valid = true;
    }

    return {"user": user, "isValid": valid};
  }
}
