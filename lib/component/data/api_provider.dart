import 'dart:convert';

import 'package:flutter/services.dart';

class ApiProvider {
  Future<List<dynamic>> getContactList() async {
    var data = await rootBundle.loadString('assets/test_data.json');
    var dataEncoded = jsonDecode(data);
    return dataEncoded;
  }

  Future<Map<String, dynamic>?> getContactDetail(dynamic params) async {
    var data = await rootBundle.loadString('assets/test_data.json');
    var dataEncoded = jsonDecode(data);

    Map<String, String> selectedData = {};

    return selectedData;
  }
}
