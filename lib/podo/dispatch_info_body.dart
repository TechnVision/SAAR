// To parse this JSON data, do
//
//     final dispatchInfoBody = dispatchInfoBodyFromJson(jsonString);

import 'dart:convert';

List<DispatchInfoBody> dispatchInfoBodyFromJson(String str) => List<DispatchInfoBody>.from(json.decode(str).map((x) => DispatchInfoBody.fromJson(x)));

String dispatchInfoBodyToJson(List<DispatchInfoBody> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DispatchInfoBody {
  DispatchInfoBody({
    required this.s1,
    required this.companyName,
    required this.partyName,
  });

  S1 s1;
  String companyName;
  String partyName;

  factory DispatchInfoBody.fromJson(Map<String, dynamic> json) => DispatchInfoBody(
    s1: S1.fromJson(json["s1"]),
    companyName: json["CompanyName"],
    partyName: json["PartyName"],
  );

  Map<String, dynamic> toJson() => {
    "s1": s1.toJson(),
    "CompanyName": companyName,
    "PartyName": partyName,
  };
}

class S1 {
  S1({
    required this.id,
    required this.compGsTno,
    required this.vNo,
    required this.bookCode,
    required this.bookShort,
    required this.date,
    required this.partyCode,
    required this.acofCode,
    required this.agentCode,
    required this.srNo,
    required this.caseno,
    required this.desNo,
    this.shade,
    required this.item,
    required this.itemCode,
    required this.unit,
    this.remark,
    required this.noPcs,
    required this.cases,
    required this.cut,
    required this.qty,
    required this.rate,
    required this.amount,
    required this.desc,
    required this.weight,
    required this.billNo,
    required this.billDate,
    required this.ordNo,
    required this.acDate,
    this.chlNo,
    this.shadeNo,
    required this.fVno,
    required this.bookAcCode,
    required this.gstno,
    required this.compMobile,
    this.acofName,
    required this.acofMobile,
  });

  int id;
  String compGsTno;
  dynamic vNo;
  dynamic bookCode;
  String bookShort;
  String date;
  dynamic partyCode;
  dynamic acofCode;
  dynamic agentCode;
  dynamic srNo;
  String caseno;
  String desNo;
  dynamic shade;
  String item;
  dynamic itemCode;
  String unit;
  dynamic remark;
  dynamic noPcs;
  dynamic cases;
  String cut;
  dynamic qty;
  dynamic rate;
  dynamic amount;
  String desc;
  dynamic weight;
  String billNo;
  String billDate;
  String ordNo;
  String acDate;
  dynamic chlNo;
  dynamic shadeNo;
  String fVno;
  dynamic bookAcCode;
  String gstno;
  String compMobile;
  dynamic acofName;
  String acofMobile;

  factory S1.fromJson(Map<String, dynamic> json) => S1(
    id: json["ID"],
    compGsTno: json["Comp_GSTno"],
    vNo: json["VNo"],
    bookCode: json["Book_Code"],
    bookShort: json["Book_Short"],
    date: json["Date"],
    partyCode: json["Party_Code"],
    acofCode: json["Acof_Code"],
    agentCode: json["Agent_Code"],
    srNo: json["Sr_No"],
    caseno: json["Caseno"],
    desNo: json["Des_No"],
    shade: json["Shade"],
    item: json["Item"],
    itemCode: json["Item_Code"],
    unit: json["Unit"],
    remark: json["Remark"],
    noPcs: json["No_Pcs"],
    cases: json["Cases"],
    cut: json["Cut"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["Amount"],
    desc: json["Desc"],
    weight: json["Weight"],
    billNo: json["Bill_No"],
    billDate: json["Bill_Date"],
    ordNo: json["Ord_No"],
    acDate: json["AcDate"],
    chlNo: json["chl_no"],
    shadeNo: json["shade_no"],
    fVno: json["FVno"],
    bookAcCode: json["Book_Ac_Code"],
    gstno: json["GSTNO"],
    compMobile: json["CompMobile"],
    acofName: json["AcofName"],
    acofMobile: json["AcofMobile"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Comp_GSTno": compGsTno,
    "VNo": vNo,
    "Book_Code": bookCode,
    "Book_Short": bookShort,
    "Date": date,
    "Party_Code": partyCode,
    "Acof_Code": acofCode,
    "Agent_Code": agentCode,
    "Sr_No": srNo,
    "Caseno": caseno,
    "Des_No": desNo,
    "Shade": shade,
    "Item": item,
    "Item_Code": itemCode,
    "Unit": unit,
    "Remark": remark,
    "No_Pcs": noPcs,
    "Cases": cases,
    "Cut": cut,
    "Qty": qty,
    "Rate": rate,
    "Amount": amount,
    "Desc": desc,
    "Weight": weight,
    "Bill_No": billNo,
    "Bill_Date": billDate,
    "Ord_No": ordNo,
    "AcDate": acDate,
    "chl_no": chlNo,
    "shade_no": shadeNo,
    "FVno": fVno,
    "Book_Ac_Code": bookAcCode,
    "GSTNO": gstno,
    "CompMobile": compMobile,
    "AcofName": acofName,
    "AcofMobile": acofMobile,
  };
}
