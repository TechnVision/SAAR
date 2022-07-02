// To parse this JSON data, do
//
//     final outstandingDetails = outstandingDetailsFromJson(jsonString);

import 'dart:convert';

List<OutstandingDetails> outstandingDetailsFromJson(String str) => List<OutstandingDetails>.from(json.decode(str).map((x) => OutstandingDetails.fromJson(x)));

String outstandingDetailsToJson(List<OutstandingDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OutstandingDetails {
  OutstandingDetails({
    required this.id,
    required this.agentfldRead,
    required this.compfldRead,
    required this.gstno,
    required this.agentMobile,
    required this.mobile,
    required this.agentName,
    required this.party,
    required this.billDate,
    required this.billNo,
    required this.billAmt,
    required this.dueAmt,
    required this.fldRead,
    required this.compName,
    required this.compMobile,
    required this.compGstNo,
  });

  int id;
  String agentfldRead;
  String compfldRead;
  String gstno;
  String agentMobile;
  String mobile;
  String agentName;
  String party;
  String billDate;
  String billNo;
  dynamic billAmt;
  dynamic dueAmt;
  dynamic fldRead;
  String compName;
  String compMobile;
  String compGstNo;

  factory OutstandingDetails.fromJson(Map<String, dynamic> json) => OutstandingDetails(
    id: json["ID"],
    agentfldRead: json["agentfld_READ"],
    compfldRead: json["compfld_READ"],
    gstno: json["gstno"],
    agentMobile: json["AgentMobile"],
    mobile: json["Mobile"],
    agentName: json["AgentName"],
    party: json["Party"],
    billDate: json["Bill_date"],
    billNo: json["Bill_No"],
    billAmt: json["Bill_Amt"],
    dueAmt: json["Due_Amt"],
    fldRead: json["fld_READ"],
    compName: json["Comp_Name"],
    compMobile: json["CompMobile"],
    compGstNo: json["Comp_GstNo"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "agentfld_READ": agentfldRead,
    "compfld_READ": compfldRead,
    "gstno": gstno,
    "AgentMobile": agentMobile,
    "Mobile": mobile,
    "AgentName": agentName,
    "Party": party,
    "Bill_date": billDate,
    "Bill_No": billNo,
    "Bill_Amt": billAmt,
    "Due_Amt": dueAmt,
    "fld_READ": fldRead,
    "Comp_Name": compName,
    "CompMobile": compMobile,
    "Comp_GstNo": compGstNo,
  };
}
