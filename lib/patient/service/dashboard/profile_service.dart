import 'dart:convert';
import 'dart:developer';

import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/patient/models/patient_profile_model.dart';
import 'package:http/http.dart' as http;

class PatientProfileService {
  Future<PatientProfileModel> getPatientProfileInfo(int patientId) async {
    PatientProfileModel patient = PatientProfileModel();
    var url = Uri.parse(patientProfileApi + patientId.toString());

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var patientsJson = json.decode(response.body);
        patient = PatientProfileModel.fromJson(patientsJson[0]);
      }
    } catch (e) {
      //
    }

    return patient;
  }

  Future<bool> uploadProfileImage(var body) async {
    var url = Uri.parse(uploadImagApi);

    var headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    try {
      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> updatePersonalInfo(
      Map<String, dynamic> personalInfoMap, int patientId) async {
    // update patient set Allergies = 'food', Occupation = 'App Developer', Smoking = 'no', maritalStatus = 'Single', Alcohol = 'no', Exercise = 'yes',  caffinatedBeverage = 'yes' where patientId = '12'
    String name = personalInfoMap['name'];
    // String districtID = personalInfoMap['districtID'].toString();
    // String policeStationID = personalInfoMap['policeStationID'].toString();
    // String postOfficeID = personalInfoMap['postOfficeID'].toString();
    String gender = personalInfoMap['gender'];
    String bloodGroup = personalInfoMap['bloodGroup'];
    String weight = personalInfoMap['weight'];
    String dateOfBirth = personalInfoMap['dateOfBirth'];
    String email = personalInfoMap['email'];
    String district = personalInfoMap['district'];
    String policeStation = personalInfoMap['policeStation'];
    String postOffice = personalInfoMap['postOffice'];

    // String query =
    //     "update patient set PatientName = N'$name',  DistrictID = '$districtID', PoliceStationID = '$policeStationID', PostOfficeId = '$postOfficeID', Gender = '$gender', BloodGroup = '$bloodGroup', Weight = '$weight', DateOfBirth = '$dateOfBirth', email = '$email' , District = '$district', Thana = '$policeStation', PostOffice = '$postOffice' where patientId = '$patientId'";
    String query =
        "update patient set PatientName = N'$name', Gender = '$gender', BloodGroup = '$bloodGroup', Weight = '$weight', DateOfBirth = '$dateOfBirth', email = '$email' , District = '$district', Thana = '$policeStation', PostOffice = '$postOffice' where patientId = '$patientId'";
    var url = Uri.parse(postApi + query);
    print(query);
    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }

    return false;
  }

  Future<bool> uploadPatientProfileImageString(
      String imageString, int patientId) async {
    String query =
        "update patient set ProfilePic = '$imageString' where PatientID = '$patientId'";

    var url = Uri.parse(postApi + query);

    try {
      print('try listening');
      var response = await http.post(url);
      print('response code = ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }
    return false;
  }

  Future<bool> updatePersonalHistory(
      Map<String, dynamic> personalInfoMap, int patientId) async {
    // update patient set Allergies = 'food', Occupation = 'App Developer', Smoking = 'no', maritalStatus = 'Single', Alcohol = 'no', Exercise = 'yes',  caffinatedBeverage = 'yes' where patientId = '12'
    String allergies = personalInfoMap['allergies'];
    String occupation = personalInfoMap['occupation'];
    String smoking = personalInfoMap['smoking'];
    String maritalStatus = personalInfoMap['maritalStatus'];
    String alcohol = personalInfoMap['alcohol'];
    String exercise = personalInfoMap['exercise'];
    String caffeinatedBeverage = personalInfoMap['caffeinatedBeverage'];

    String query =
        "update patient set Allergies = N'$allergies', Occupation = N'$occupation', Smoking = N'$smoking', maritalStatus = N'$maritalStatus', Alcohol = N'$alcohol', Exercise = N'$exercise',  caffinatedBeverage = N'$caffeinatedBeverage' where patientId = '$patientId'";
    var url = Uri.parse(postApi + query);
    print(query);
    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      //
    }

    return false;
  }
}
