class PaymentMethod {
  int? id;
  int? memberId;
  String? paymentMode;
  String? paymentPhone;
  bool? isDoctor;
  String? createOn;

  PaymentMethod(
      {this.id,
      this.memberId,
      this.paymentMode,
      this.paymentPhone,
      this.isDoctor,
      this.createOn});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['memberId'];
    paymentMode = json['paymentMode'];
    paymentPhone = json['paymentPhone'];
    isDoctor = json['isDoctor'];
    createOn = json['createOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memberId'] = this.memberId;
    data['paymentMode'] = this.paymentMode;
    data['paymentPhone'] = this.paymentPhone;
    data['isDoctor'] = this.isDoctor;
    data['createOn'] = this.createOn;
    return data;
  }
}
