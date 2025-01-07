// To parse this JSON data, do
//
//     final doctorSpecialityModel = doctorSpecialityModelFromJson(jsonString);

import 'dart:convert';

List<DoctorSpecialityModel> doctorSpecialityModelFromJson(String str) =>
    List<DoctorSpecialityModel>.from(
        json.decode(str).map((x) => DoctorSpecialityModel.fromJson(x)));

String doctorSpecialityModelToJson(List<DoctorSpecialityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorSpecialityModel {
  DoctorSpecialityModel({
    this.specialityId,
    this.specialityName,
    this.specialityDetail,
  });

  int? specialityId;
  String? specialityName;
  String? specialityDetail;

  factory DoctorSpecialityModel.fromJson(Map<String, dynamic> json) =>
      DoctorSpecialityModel(
        specialityId: json["specialityID"],
        specialityName: json["specialityName"],
        specialityDetail: json["specialityDetail"],
      );

  Map<String, dynamic> toJson() => {
        "specialityID": specialityId,
        "specialityName": specialityName,
        "specialityDetail": specialityDetail,
      };
}
