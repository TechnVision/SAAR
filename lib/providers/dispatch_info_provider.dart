import 'package:flutter/material.dart';
import 'package:saar/podo/dispatch_info_body.dart';
import 'package:saar/podo/dispatch_info_details.dart';
import 'package:saar/podo/dispatch_info_summary.dart';
import 'package:http/http.dart' as http;
import '../services/ws.dart';

class DispatchInfoProvider with ChangeNotifier {
  List<DispatchInfoDetails?> dispatchInfoDetailsList = [];
  List<DispatchSummary?> dispatchSummaryList = [];
  List<DispatchInfoBody?> dispatchInfoBodyList = [];
  bool loading1 = true;
  bool loading2 = true;
  bool loading3 = true;

  Future<List<DispatchInfoDetails?>> callDispatchInfoDetails(
    BuildContext context, {
    required String compMobile,
    required String partyName,
    required String comGSTno,
  }) async {
    dispatchInfoDetailsList.clear();
    try {
      final res = await http.get(Uri.parse(WS.dispatchInfoDetails +
          "$compMobile&PartyName=$partyName&Comp_GstNo=$comGSTno"));
      dispatchInfoDetailsList = dispatchInfoDetailsFromJson(res.body);
    } catch (e) {
      throw "Something went with Dispatch Info Details $e";
    }
    notifyListeners();
    return dispatchInfoDetailsList;
  }

  Future<List<DispatchSummary?>> callDispatchSummary(BuildContext context,
      {required String compMobileNo, required String type}) async {
    dispatchSummaryList.clear();
    loading2 = true;
    String url = WS.dispatchInfoSummary + "$compMobileNo&type=$type";
    try {
      final res = await http.get(Uri.parse(url));
      dispatchSummaryList = dispatchSummaryFromJson(res.body);
      loading2 = false;
    } catch (e) {
      loading2 = false;
      throw "Something went with DispatchSummary $e";
    }
    notifyListeners();
    return dispatchSummaryList;
  }

  Future<List<DispatchInfoBody?>> callDispatchInfoBody(BuildContext context,
      {required String compGSTno,
      required String fvNo,
      required String billNo}) async {
    dispatchInfoBodyList.clear();
    loading3 = true;
    try {
      final res = await http.get(Uri.parse(WS.dispatchBillBodyInfo +
          "Comp_GstNo=$compGSTno&Fvno=$fvNo&Bill_No=$billNo"));
      dispatchInfoBodyList = dispatchInfoBodyFromJson(res.body);

      loading3 = false;
    } catch (e) {
      loading3 = false;
      throw "Something went with DispatchInfoBody $e";
    }
    notifyListeners();
    return dispatchInfoBodyList;
  }
}
