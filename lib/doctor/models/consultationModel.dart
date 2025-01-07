// To parse this JSON data, do
//
//     final consultationModel = consultationModelFromJson(jsonString);

import 'dart:convert';

List<ConsultationModel> consultationModelFromJson(String str) =>
    List<ConsultationModel>.from(
        json.decode(str).map((x) => ConsultationModel.fromJson(x)));

String consultationModelToJson(List<ConsultationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsultationModel {
  ConsultationModel({
    this.consultationId,
    this.doctorId,
    this.patientId,
    this.memberId,
    this.consultationDay,
    this.consultationStartTime,
    this.consultationEndTime,
    this.createdOn,
    this.createdBy,
  });

  int? consultationId;
  int? doctorId;
  int? patientId;
  int? memberId;
  String? consultationDay;
  DateTime? consultationStartTime;
  DateTime? consultationEndTime;
  DateTime? createdOn;
  String? createdBy;

  factory ConsultationModel.fromJson(Map<String, dynamic> json) =>
      ConsultationModel(
        consultationId: json["consultationID"],
        doctorId: json["doctorID"],
        patientId: json["patientID"],
        memberId: json["memberID"],
        consultationDay: json["consultationDay"],
        consultationStartTime: DateTime.parse(json["consultationStartTime"]),
        consultationEndTime: DateTime.parse(json["consultationEndTime"]),
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "consultationID": consultationId,
        "doctorID": doctorId,
        "patientID": patientId,
        "memberID": memberId,
        "consultationDay": consultationDay,
        "consultationStartTime": consultationStartTime!.toIso8601String(),
        "consultationEndTime": consultationEndTime!.toIso8601String(),
        "createdOn": createdOn!.toIso8601String(),
        "createdBy": createdBy,
      };
}
