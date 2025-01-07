import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
// import 'package:pro_health/doctor/models/signup_login/memberModel.dart';

class AuthService {
  Future<List<Map<String, dynamic>?>> fetchDoctorSigninInfo(
      String phone) async {
    var url = Uri.parse(doctorApi + phone);

    List<Map<String, dynamic>?> doctorInfo = [];

    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var signinJson = json.decode(response.body);
      for (var doctor in signinJson) {
        doctorInfo.add(doctor);
      }
    }
    // print(doctorInfo);
    return doctorInfo;
  }

  Future fetchDoctorMember(var doctorPhoneNum) async {
    var url = Uri.parse(membersApi);
    List<Map<String, dynamic>?> doctors = [];

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var members = json.decode(response.body);
      for (var member in members) {
        if (member['isDoctor']) {
          doctors.add(member);
        }
      }
    }
    return doctors;
  }

  Future<bool> saveDoctorSignupInfoToDb(var memberId, var doctorPhone,
      var doctorName, var doctorEmail, var doctorBmdcNum, var password) async {
    // print('doctor signup function listening');

    String appJoinDate = await getTimeNow();
    String query =
        "insert into doctor(MemberID, DoctorName, MobileNo, AppJoinDate, BmdcNmuber,Password, Email) values('$memberId', N'$doctorName','$doctorPhone','$appJoinDate','$doctorBmdcNum','$password','$doctorEmail')";
    print(query);
    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //
    }
    return false;

    // var url = Uri.parse(doctorApi);
    // var defaultDate = "1800-01-01T00:00:00";
    // var timeNow = DateTime.now().toIso8601String();
    // var data = {
    //   "memberID": memberId,
    //   "specialityID": 1,
    //   "doctorName": doctorName,
    //   "mobileNo": doctorPhone,
    //   "dateOfBirth": defaultDate,
    //   "gender": "default",
    //   "doctorDesc": "default",
    //   "eduQualificationID": 1,
    //   "experience": "default",
    //   "workingPlace": "default",
    //   "consultationFeeOnline": 1.00,
    //   "consultationFeePhysical": 1.00,
    //   "followupFee": 1.00,
    //   "availability": "",
    //   "consultStartTime": "00:00:00",
    //   "consultEndTime": "00:00:00",
    //   "appJoinDate": timeNow,
    //   "bmdcNmuber": doctorBmdcNum,
    //   "consultDiscount": 1.00,
    //   "followupDiscount": 1.00,
    //   "discountStartDate": defaultDate,
    //   "discountEndDate": defaultDate,
    //   "password": password,
    //   "email": doctorEmail,
    //   "profilePicture": null,
    //   "status": null,
    //   "createdBy": null,
    //   "createdOn": timeNow,
    //   "agreementAcceptStatus": false
    // };

    // var header = <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // };

    // // print(DateTime.now().toIso8601String());

    // var response =
    //     await http.post(url, body: jsonEncode(data), headers: header);
    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future<bool> updateDoctorAgreemntStatus(var doctorPhone) async {
    var query =
        "update doctor set AgreementAcceptStatus = 'true' where MobileNo = '$doctorPhone'";
    var url = Uri.parse(postApi + query);
    var response = await http.post(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  updateDoctorPassword(var doctorPhone, var password) async {
    String query =
        "update doctor set Password = '$password'  where MobileNo = '$doctorPhone'";

    var url = Uri.parse(postApi + query);

    try {
      var response = await http.post(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return true;
      }
    } catch (e) {
      //
    }

    return true;
  }

  Future sendOTP(var phone, var otpType) async {
    Map<String, dynamic> otpStatus = Map();

    var rng = new Random();
    var otpCode = rng.nextInt(9000) + 1000;
    var message = otpType == "resetPass"
        ? 'Your OTP for Pro Health Acccount Password reset is $otpCode'
        : 'Your OTP for ProHealth registration is $otpCode';

    var url = Uri.parse(
        'https://license.extreme.com.bd/api/sms?user=prohealth&pswd=22082021&rcvr=$phone&msg=$message');
    var response = await http.get(url);

    print(
        'phone = $phone, time = ${DateTime.now()} response code = ${response.statusCode}, url = $url');

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
}
