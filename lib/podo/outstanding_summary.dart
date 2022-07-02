// To parse this JSON data, do
//
//     final outstandingSummary = outstandingSummaryFromJson(jsonString);

import 'dart:convert';

List<OutstandingSummary> outstandingSummaryFromJson(String str) => List<OutstandingSummary>.from(json.decode(str).map((x) => OutstandingSummary.fromJson(x)));

String outstandingSummaryToJson(List<OutstandingSummary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OutstandingSummary {
  OutstandingSummary({
    required this.party,
    required this.dueAmt,
    required this.compName,
    required this.compGstNo,
  });

  String party;
  dynamic dueAmt;
  String compName;
  String compGstNo;

  factory OutstandingSummary.fromJson(Map<String, dynamic> json) => OutstandingSummary(
    party: json["Party"],
    dueAmt: json["Due_Amt"],
    compName: json["Comp_Name"],
    compGstNo: json["Comp_GstNo"],
  );

  Map<String, dynamic> toJson() => {
    "Party": party,
    "Due_Amt": dueAmt,
    "Comp_Name": compName,
    "Comp_GstNo": compGstNo,
  };
}
