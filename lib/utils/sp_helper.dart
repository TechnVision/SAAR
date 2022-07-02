import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class SPHelper {
  var storage = const FlutterSecureStorage();

  setLoginStatus(bool newStatus) async {
    storage.write(key: "login", value: "$newStatus");
  }

  setLoginMobileMo(String newStatus) async {
    storage.write(key: "mobile", value: newStatus);
  }

  setCompMobileMo(String newStatus) async {
    storage.write(key: "compMobile", value: newStatus);
  }
}
