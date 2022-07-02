import 'package:flutter/material.dart';
import 'package:saar/podo/package_info_details.dart';
import 'package:http/http.dart' as http;
import '../services/ws.dart';

class PackageInfoProvider with ChangeNotifier {
  List<PackageInfoDetails?> packageInfoDetailsList = [];
  bool loading = true;

// Call API to fetch package information
  Future<List<PackageInfoDetails?>> callPackageInfoDetails({
    required String caseNo,
    required String compGSTno,
    required String bookCode,
  }) async {
    loading = true;
    String url = WS.packInfoDetails +
        "CaseNo=$caseNo&Comp_GSTno=$compGSTno&BookCode=$bookCode";
    try {
      final res = await http.get(Uri.parse(url));
      packageInfoDetailsList = packageInfoDetailsFromJson(res.body);
      loading = false;
    } catch (e) {
      loading = false;
      throw "Something went with PackageInfoDetails $e";
    }
    notifyListeners();
    return packageInfoDetailsList;
  }
}
