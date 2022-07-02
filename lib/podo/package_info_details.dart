// To parse this JSON data, do
//
//     final packageInfoDetails = packageInfoDetailsFromJson(jsonString);

import 'dart:convert';

List<PackageInfoDetails> packageInfoDetailsFromJson(String str) => List<PackageInfoDetails>.from(json.decode(str).map((x) => PackageInfoDetails.fromJson(x)));

String packageInfoDetailsToJson(List<PackageInfoDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageInfoDetails {
  PackageInfoDetails({
    required this.id,
    required this.compName,
    required this.compGstNo,
    required this.compMobile,
    required this.mobile,
    required this.agMobile,
    required this.party,
    required this.agent,
    required this.accountName,
    this.retailer,
    required this.transName,
    required this.despatch,
    required this.ordNo,
    required this.orderDate,
    required this.caseno,
    required this.date,
    required this.itemName,
    required this.shade,
    required this.desNo,
    required this.qty,
    required this.noPcs,
    required this.fVno,
    required this.vno,
    required this.bookCode,
    required this.acofMobile,
  });

  int id;
  String compName;
  String compGstNo;
  String compMobile;
  String mobile;
  String agMobile;
  String party;
  String agent;
  String accountName;
  dynamic retailer;
  String transName;
  String despatch;
  String ordNo;
  String orderDate;
  String caseno;
  String date;
  String itemName;
  String shade;
  String desNo;
  dynamic qty;
  dynamic noPcs;
  String fVno;
  dynamic vno;
  dynamic bookCode;
  String acofMobile;

  factory PackageInfoDetails.fromJson(Map<String, dynamic> json) => PackageInfoDetails(
    id: json["ID"],
    compName: json["Comp_Name"],
    compGstNo: json["Comp_GstNo"],
    compMobile: json["CompMobile"],
    mobile: json["Mobile"],
    agMobile: json["AgMobile"],
    party: json["Party"],
    agent: json["Agent"],
    accountName: json["account_name"],
    retailer: json["Retailer"],
    transName: json["Trans_Name"],
    despatch: json["Despatch"],
    ordNo: json["Ord_No"],
    orderDate: json["Order_Date"],
    caseno: json["Caseno"],
    date: json["Date"],
    itemName: json["Item_Name"],
    shade: json["Shade"],
    desNo: json["Des_No"],
    qty: json["Qty"],
    noPcs: json["No_Pcs"],
    fVno: json["FVno"],
    vno: json["Vno"],
    bookCode: json["Book_Code"],
    acofMobile: json["AcofMobile"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Comp_Name": compName,
    "Comp_GstNo": compGstNo,
    "CompMobile": compMobile,
    "Mobile": mobile,
    "AgMobile": agMobile,
    "Party": party,
    "Agent": agent,
    "account_name": accountName,
    "Retailer": retailer,
    "Trans_Name": transName,
    "Despatch": despatch,
    "Ord_No": ordNo,
    "Order_Date": orderDate,
    "Caseno": caseno,
    "Date": date,
    "Item_Name": itemName,
    "Shade": shade,
    "Des_No": desNo,
    "Qty": qty,
    "No_Pcs": noPcs,
    "FVno": fVno,
    "Vno": vno,
    "Book_Code": bookCode,
    "AcofMobile": acofMobile,
  };
}