import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/patient/models/patient.dart';

class PatientAuthService {
  Future<List<PatientModel>> fetchPatientSigninInfo(String phone) async {
    var url = Uri.parse(patientApi + phone);

    List<PatientModel> patientInfo = [];

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var signinJson = json.decode(response.body);
      for (var item in signinJson) {
        patientInfo.add(PatientModel.fromJson(item));
      }
    }
    // print(doctorInfo);
    return patientInfo;
  }

  Future<bool> updatePatientAgreemntStatus(String phone) async {
    // print(DateTime.now().toIso8601String());

    var query =
        "update patient set AgreementAcceptStatus = 'true' where Mobile = '$phone'";
    var url = Uri.parse(postApi + query);
    var response = await http.post(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future sendOTP(var phone, var otpType) async {
    Map<String, dynamic> otpStatus = Map();

    var rng = Random();
    var otpCode = rng.nextInt(9000) + 1000;
    var message = otpType == "resetPass"
        ? 'Your OTP for Pro Health Acccount Password reset is $otpCode'
        : 'Your OTP for ProHealth registration is $otpCode';

    var url = Uri.parse(
        'https://license.extreme.com.bd/api/sms?user=prohealth&pswd=22082021&rcvr=$phone&msg=$message');
    var response = await http.get(url);

    otpStatus['otpCode'] = otpCode;
    otpStatus['response'] = response;

    return otpStatus;
  }

  bool verifyOTP(var sentOtp, var receivedOtp) {
    if (sentOtp == receivedOtp) {
      return true;
    } else {
      return false;
    }
  }

  updatePatientPassword(var patientPhone, var password) async {
    var query =
        "update patient set Password = '$password' where Mobile = '$patientPhone'";
    // print('query $query');
    var url = Uri.parse(postApi + query);
    var response = await http.post(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signupPatient(String patientName, String patientPhone,
      var dateOfBirth, String password) async {
    String query =
        "insert into Patient(PatientName, DateOfBirth, Mobile, Password, AgreementAcceptStatus) values(N'$patientName', '$dateOfBirth', '$patientPhone', '$password', 'false')";
    // print('signup patient query = $query');
    var url = Uri.parse(postApi + query);

    var response = await http.post(url);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
