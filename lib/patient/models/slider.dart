class SliderImageModel {
  int? reviewID;
  int? doctorID;
  String? doctorName;
  int? patientID;
  String? profilePicture;
  String? comments;
  double? rating;
  String? reviewDate;

  SliderImageModel(
      {this.reviewID,
      this.doctorID,
      this.doctorName,
      this.patientID,
      this.profilePicture,
      this.comments,
      this.rating,
      this.reviewDate});

  SliderImageModel.fromJson(Map<String, dynamic> json) {
    reviewID = json['reviewID'];
    doctorID = json['doctorID'];
    doctorName = json['doctorName'];
    patientID = json['patientID'];
    profilePicture = json['profilePicture'];
    comments = json['comments'];
    rating = json['rating'];
    reviewDate = json['reviewDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewID'] = this.reviewID;
    data['doctorID'] = this.doctorID;
    data['doctorName'] = this.doctorName;
    data['patientID'] = this.patientID;
    data['profilePicture'] = this.profilePicture;
    data['comments'] = this.comments;
    data['rating'] = this.rating;
    data['reviewDate'] = this.reviewDate;
    return data;
  }
}
