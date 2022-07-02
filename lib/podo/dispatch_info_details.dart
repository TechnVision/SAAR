// To parse this JSON data, do
//
//     final dispatchInfoDetails = dispatchInfoDetailsFromJson(jsonString);

import 'dart:convert';

List<DispatchInfoDetails> dispatchInfoDetailsFromJson(String str) => List<DispatchInfoDetails>.from(json.decode(str).map((x) => DispatchInfoDetails.fromJson(x)));
String dispatchInfoDetailsToJson(List<DispatchInfoDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DispatchInfoDetails {
  DispatchInfoDetails({
    required this.id,
    required this.agentfldRead,
    required this.compfldRead,
    required this.fldRead,
    required this.fldGroup,
    required this.compGsTno,
    required this.compCode,
    required this.compName,
    required this.compMobile,
    required this.compMail,
    required this.book,
    required this.fvno,
    required this.agent,
    required this.agentMobile,
    required this.agentEmail,
    required this.party,
    required this.supplier,
    required this.mobile,
    required this.eMail,
    required this.acofName,
    required this.orderDate,
    required this.ordNo,
    required this.billDate,
    required this.caseNo,
    required this.billNo,
    required this.lrno,
    required this.lrdate,
    required this.transport,
    required this.despatch,
    required this.item,
    required this.shade,
    required this.desNo,
    required this.rate,
    required this.qty,
    required this.amount,
    required this.addLess,
    required this.rOffAmt,
    required this.netAmount,
    this.invoice,
    this.packingSlip,
    required this.vno,
    required this.bookCode,
    required this.salesmanMobile,
    required this.acofMobile,
  });

  int id;
  String agentfldRead;
  String compfldRead;
  String fldRead;
  String fldGroup;
  String compGsTno;
  dynamic compCode;
  String compName;
  String compMobile;
  String compMail;
  String book;
  String fvno;
  String agent;
  String agentMobile;
  String agentEmail;
  String party;
  String supplier;
  String mobile;
  String eMail;
  String acofName;
  String orderDate;
  String ordNo;
  String billDate;
  String caseNo;
  String billNo;
  String lrno;
  String lrdate;
  String transport;
  String despatch;
  String item;
  String shade;
  String desNo;
  dynamic rate;
  double qty;
  double amount;
  dynamic addLess;
  double rOffAmt;
  dynamic netAmount;
  dynamic invoice;
  dynamic packingSlip;
  dynamic vno;
  dynamic bookCode;
  String salesmanMobile;
  String acofMobile;

  factory DispatchInfoDetails.fromJson(Map<String, dynamic> json) => DispatchInfoDetails(
    id: json["ID"],
    agentfldRead: json["agentfld_READ"],
    compfldRead: json["compfld_READ"],
    fldRead: json["fld_READ"],
    fldGroup: json["fld_GROUP"],
    compGsTno: json["Comp_GSTno"],
    compCode: json["Comp_Code"],
    compName: json["Comp_Name"],
    compMobile: json["CompMobile"],
    compMail: json["CompMail"],
    book: json["Book"],
    fvno: json["Fvno"],
    agent: json["Agent"],
    agentMobile: json["AgentMobile"],
    agentEmail: json["AgentEmail"],
    party: json["Party"],
    supplier: json["Supplier"],
    mobile: json["Mobile"],
    eMail: json["EMail"],
    acofName: json["Acof_Name"],
    orderDate: json["Order_Date"],
    ordNo: json["Ord_No"],
    billDate: json["Bill_date"],
    caseNo: json["CaseNo"],
    billNo: json["Bill_No"],
    lrno: json["Lrno"],
    lrdate: json["Lrdate"],
    transport: json["Transport"],
    despatch: json["Despatch"],
    item: json["Item"],
    shade: json["Shade"],
    desNo: json["Des_No"],
    rate: json["Rate"],
    qty: json["Qty"].toDouble(),
    amount: json["Amount"].toDouble(),
    addLess: json["AddLess"],
    rOffAmt: json["ROff_Amt"].toDouble(),
    netAmount: json["NetAmount"],
    invoice: json["Invoice"],
    packingSlip: json["PackingSlip"],
    vno: json["Vno"],
    bookCode: json["Book_Code"],
    salesmanMobile: json["salesmanMobile"],
    acofMobile: json["AcofMobile"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "agentfld_READ": agentfldRead,
    "compfld_READ": compfldRead,
    "fld_READ": fldRead,
    "fld_GROUP": fldGroup,
    "Comp_GSTno": compGsTno,
    "Comp_Code": compCode,
    "Comp_Name": compName,
    "CompMobile": compMobile,
    "CompMail": compMail,
    "Book": book,
    "Fvno": fvno,
    "Agent": agent,
    "AgentMobile": agentMobile,
    "AgentEmail": agentEmail,
    "Party": party,
    "Supplier": supplier,
    "Mobile": mobile,
    "EMail": eMail,
    "Acof_Name": acofName,
    "Order_Date": orderDate,
    "Ord_No": ordNo,
    "Bill_date": billDate,
    "CaseNo": caseNo,
    "Bill_No": billNo,
    "Lrno": lrno,
    "Lrdate": lrdate,
    "Transport": transport,
    "Despatch": despatch,
    "Item": item,
    "Shade": shade,
    "Des_No": desNo,
    "Rate": rate,
    "Qty": qty,
    "Amount": amount,
    "AddLess": addLess,
    "ROff_Amt": rOffAmt,
    "NetAmount": netAmount,
    "Invoice": invoice,
    "PackingSlip": packingSlip,
    "Vno": vno,
    "Book_Code": bookCode,
    "salesmanMobile": salesmanMobile,
    "AcofMobile": acofMobile,
  };
}
