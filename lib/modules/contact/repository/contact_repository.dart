import 'dart:developer';

import 'package:test_project/component/data/api_provider.dart';
import 'package:test_project/component/data/models/user.dart';

class ContactRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<dynamic> getContacts() async {
    List<User> users = [];

    var response = await apiProvider.getContactList();
    users = response.map((data) => User.fromJson(data!)).toList();

    users.forEach((data) {
      var letter = data.firstName![0];
      var initials = "${data.firstName![0]}${data.lastName![0]}";
      data.group = letter;
      data.initialName = initials;
    });

    users.sort((a, b) {
      return a.group!.toLowerCase().compareTo(b.group!.toLowerCase());
    });

    return {"users": users};
  }
}
