// To parse this JSON data, do
//
//     final doctorReviewModel = doctorReviewModelFromJson(jsonString);

import 'dart:convert';

List<DoctorReviewModel> doctorReviewModelFromJson(String str) =>
    List<DoctorReviewModel>.from(
        json.decode(str).map((x) => DoctorReviewModel.fromJson(x)));

String doctorReviewModelToJson(List<DoctorReviewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorReviewModel {
  DoctorReviewModel({
    this.doctorId,
    this.memberId,
    this.comments,
    this.rating,
    this.reviewDate,
    this.patientName,
    this.profilePic,
  });

  int? doctorId;
  int? memberId;
  String? comments;
  double? rating;
  DateTime? reviewDate;
  String? patientName;
  String? profilePic;

  factory DoctorReviewModel.fromJson(Map<String, dynamic> json) =>
      DoctorReviewModel(
        doctorId: json["doctorID"],
        memberId: json["memberID"],
        comments: json["comments"],
        rating: json["rating"].toDouble(),
        reviewDate: DateTime.parse(json["reviewDate"]),
        patientName: json["patientName"],
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "doctorID": doctorId,
        "memberID": memberId,
        "comments": comments,
        "rating": rating,
        "reviewDate": reviewDate!.toIso8601String(),
        "patientName": patientName,
        "profilePic": profilePic,
      };
}
