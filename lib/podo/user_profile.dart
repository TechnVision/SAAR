// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    required this.id,
    required this.party,
    required this.mobile,
    required this.agent,
    required this.agentMobile,
    required this.salesman,
    required this.salesmanMobile,
    required this.acofName,
    required this.acofMobile,
    required this.compName,
    required this.compMobile,
    required this.compGstNo,
    required this.userTyp,
  });

  int id;
  String party;
  String mobile;
  String agent;
  String agentMobile;
  String salesman;
  String salesmanMobile;
  String acofName;
  String acofMobile;
  String compName;
  String compMobile;
  String compGstNo;
  String userTyp;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["ID"],
    party: json["Party"],
    mobile: json["Mobile"],
    agent: json["Agent"],
    agentMobile: json["AgentMobile"],
    salesman: json["Salesman"],
    salesmanMobile: json["SalesmanMobile"],
    acofName: json["AcofName"],
    acofMobile: json["AcofMobile"],
    compName: json["Comp_Name"],
    compMobile: json["CompMobile"],
    compGstNo: json["Comp_GstNo"],
    userTyp: json["UserTyp"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Party": party,
    "Mobile": mobile,
    "Agent": agent,
    "AgentMobile": agentMobile,
    "Salesman": salesman,
    "SalesmanMobile": salesmanMobile,
    "AcofName": acofName,
    "AcofMobile": acofMobile,
    "Comp_Name": compName,
    "CompMobile": compMobile,
    "Comp_GstNo": compGstNo,
    "UserTyp": userTyp,
  };
}
