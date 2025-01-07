// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

List<MemberModel> memberModelFromJson(String str) => List<MemberModel>.from(
    json.decode(str).map((x) => MemberModel.fromJson(x)));

String memberModelToJson(List<MemberModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberModel {
  MemberModel({
    this.memberId,
    this.email,
    this.mobile1,
    this.mobile2,
    this.mobile3,
    this.password,
    this.isPatient,
    this.isDoctor,
    this.updateBy,
    this.updateDate,
    this.entryBy,
    this.entryDate,
  });

  int? memberId;
  String? email;
  String? mobile1;
  String? mobile2;
  String? mobile3;
  String? password;
  bool? isPatient;
  bool? isDoctor;
  String? updateBy;
  DateTime? updateDate;
  String? entryBy;
  DateTime? entryDate;

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        memberId: json["memberID"],
        email: json["email"],
        mobile1: json["mobile1"],
        mobile2: json["mobile2"],
        mobile3: json["mobile3"],
        password: json["password"] == null ? null : json["password"],
        isPatient: json["isPatient"],
        isDoctor: json["isDoctor"],
        updateBy: json["updateBy"],
        updateDate: DateTime.parse(json["updateDate"]),
        entryBy: json["entryBy"],
        entryDate: DateTime.parse(json["entryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "memberID": memberId,
        "email": email,
        "mobile1": mobile1,
        "mobile2": mobile2,
        "mobile3": mobile3,
        "password": password == null ? null : password,
        "isPatient": isPatient,
        "isDoctor": isDoctor,
        "updateBy": updateBy,
        "updateDate": updateDate!.toIso8601String(),
        "entryBy": entryBy,
        "entryDate": entryDate!.toIso8601String(),
      };
}
