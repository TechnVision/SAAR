// To parse this JSON data, do
//
//     final dispatchSummary = dispatchSummaryFromJson(jsonString);

import 'dart:convert';

List<DispatchSummary> dispatchSummaryFromJson(String str) => List<DispatchSummary>.from(json.decode(str).map((x) => DispatchSummary.fromJson(x)));

String dispatchSummaryToJson(List<DispatchSummary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DispatchSummary {
  DispatchSummary({
    required this.party,
    required this.netAmount,
    required this.compName,
    required this.compGstNo,
  });

  String party;
  dynamic netAmount;
  String compName;
  String compGstNo;

  factory DispatchSummary.fromJson(Map<String, dynamic> json) => DispatchSummary(
    party: json["Party"],
    netAmount: json["NetAmount"],
    compName: json["Comp_Name"],
    compGstNo: json["Comp_GstNo"],
  );

  Map<String, dynamic> toJson() => {
    "Party": party,
    "NetAmount": netAmount,
    "Comp_Name": compName,
    "Comp_GstNo": compGstNo,
  };
}
