class MedicationModel {
  int? genericId;
  String? genericName;
  String? dose;
  String? pregnancyCategoryId;
  bool? fdaApproved;
  String? medicineGroup;
  String? medicineCategory;
  int? pregnancyId;
  String? pregnancyName;
  String? pregnancyDescription;
  int? brandId;
  int? companyId;
  String? brandName;
  String? strength;
  String? price;
  String? packsize;
  String? companyName;
  int? sellingCompany;

  MedicationModel(
      {this.genericId,
      this.genericName,
      this.dose,
      this.pregnancyCategoryId,
      this.fdaApproved,
      this.medicineGroup,
      this.medicineCategory,
      this.pregnancyId,
      this.pregnancyName,
      this.pregnancyDescription,
      this.brandId,
      this.companyId,
      this.brandName,
      this.strength,
      this.price,
      this.packsize,
      this.companyName,
      this.sellingCompany});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    genericId = json['generic_id'];
    genericName = json['generic_name'];
    dose = json['dose'];
    pregnancyCategoryId = json['pregnancy_category_id'];
    fdaApproved = json['fdaApproved'];
    medicineGroup = json['medicineGroup'];
    medicineCategory = json['medicineCategory'];
    pregnancyId = json['pregnancy_id'];
    pregnancyName = json['pregnancy_name'];
    pregnancyDescription = json['pregnancy_description'];
    brandId = json['brand_id'];
    companyId = json['company_id'];
    brandName = json['brand_name'];
    strength = json['strength'];
    price = json['price'];
    packsize = json['packsize'];
    companyName = json['company_name'];
    sellingCompany = json['sellingCompany'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generic_id'] = this.genericId;
    data['generic_name'] = this.genericName;
    data['dose'] = this.dose;
    data['pregnancy_category_id'] = this.pregnancyCategoryId;
    data['fdaApproved'] = this.fdaApproved;
    data['medicineGroup'] = this.medicineGroup;
    data['medicineCategory'] = this.medicineCategory;
    data['pregnancy_id'] = this.pregnancyId;
    data['pregnancy_name'] = this.pregnancyName;
    data['pregnancy_description'] = this.pregnancyDescription;
    data['brand_id'] = this.brandId;
    data['company_id'] = this.companyId;
    data['brand_name'] = this.brandName;
    data['strength'] = this.strength;
    data['price'] = this.price;
    data['packsize'] = this.packsize;
    data['company_name'] = this.companyName;
    data['sellingCompany'] = this.sellingCompany;
    return data;
  }
}
