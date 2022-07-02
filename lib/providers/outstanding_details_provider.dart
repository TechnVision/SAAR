import 'package:flutter/material.dart';
import 'package:saar/podo/outstanding_details.dart';
import 'package:saar/podo/outstanding_summary.dart';
import 'package:http/http.dart' as http;
import '../services/ws.dart';

class OutstandingDetailsProvider with ChangeNotifier {
  List<OutstandingDetails?> outstandingDetailsList = [];
  List<OutstandingSummary?> outstandingSummaryList = [];
  bool loading1 = true;
  bool loading2 = true;

  // Call API to fetch outstanding details
  Future<List<OutstandingDetails?>> callOutstandingDetails(BuildContext context,
      {required String mobileNo,
      required String partyName,
      required String compGSTno}) async {
    outstandingDetailsList = [];
    loading1 = true;
    try {
      final res = await http.get(Uri.parse(WS.outstandingDetails +
          "MobileNo=$mobileNo&partyname=$partyName&comp_gstno=$compGSTno"));
      outstandingDetailsList = outstandingDetailsFromJson(res.body);
      loading1 = false;
    } catch (e) {
      loading1 = false;
      throw "Something went with Dispatch Info Details $e";
    }
    notifyListeners();
    return outstandingDetailsList;
  }

  // Call API to fetch outstanding summary
  Future<List<OutstandingSummary?>> callOutstandingSummary(BuildContext context, {required String compMobileNo}) async {
    loading1 = true;
    try {
      final res = await http.get(Uri.parse(WS.outstandingSummary + compMobileNo));
      outstandingSummaryList = outstandingSummaryFromJson(res.body);
      loading1 = false;
    } catch (e) {
      loading1 = false;
      throw "Something went with OutstandingSummary $e";
    }
    notifyListeners();
    return outstandingSummaryList;
  }
}
