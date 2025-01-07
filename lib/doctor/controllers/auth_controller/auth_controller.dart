import 'package:pro_health/doctor/services/auth_service/auth_service.dart';

class AuthController {
  AuthService authService = AuthService();

  Future<bool> checkDoctorCanRegister(var doctorPhoneNum) async {
    var doctorInfo = await authService.fetchDoctorMember(doctorPhoneNum);
    List<Map<String, dynamic>?> targetDoctor = [];
    for (var doctor in doctorInfo) {
      var mobile1 = doctor['mobile1'];
      var mobile2 = doctor['mobile2'];
      var mobile3 = doctor['mobile3'];
      if (doctorPhoneNum == mobile1 ||
          doctorPhoneNum == mobile2 ||
          doctorPhoneNum == mobile3) {
        targetDoctor.add(doctor);
      }
    }
    if (targetDoctor.length > 0) {
      if (targetDoctor[0]!['mobile1'] == doctorPhoneNum ||
          targetDoctor[0]!['mobile2'] == doctorPhoneNum ||
          targetDoctor[0]!['mobile3'] == doctorPhoneNum) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<bool> doctorAccountExists(var phone) async {
    var response = await authService.fetchDoctorSigninInfo(phone);
    if (response.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  signInDoctor(var phone, var bmdcNum, var password) async {
    // print('phone $phone, bmdcNum $bmdcNum, password $password');

    Map<String, dynamic> signinStatus = Map();
    var response = await authService.fetchDoctorSigninInfo(phone);

    // print(response);

    var dbphone;
    var dbBmdcNum;
    String? dbPassword;
    var agreementAcceptStatus;

    if (response.length > 0) {
      dbphone = response[0]!['mobileNo'];
      dbBmdcNum = response[0]!['bmdcNmuber'];
      dbPassword = response[0]!['password'];
      agreementAcceptStatus = response[0]!['agreementAcceptStatus'];
    }

    signinStatus['signin'] = false;

    signinStatus['agreementAcceptedStatus'] = false;

    if (dbphone != phone) {
      signinStatus['error'] = 'No account found with this phone number';
    } else if (dbBmdcNum != bmdcNum) {
      signinStatus['error'] = 'BMDC number not matched with our record';
    } else if (dbPassword != password) {
      signinStatus['error'] =
          'Invalid password, Please check your password again';
    } else {
      // if (agreementAcceptStatus != null && agreementAcceptStatus != false) {
      //   print('agreement status = ${signinStatus['agreementAcceptedStatus']}');
      // }
      signinStatus['agreementAcceptedStatus'] = agreementAcceptStatus;
      signinStatus['signin'] = true;
    }
    // print(signinStatus['agreementAcceptedStatus']);
    return signinStatus;
  }

  // saveDoctorInfo(var memberId, var doctorPhone, var doctorName, var doctorEmail, var doctorBmdcNum) {
  //   authService.sendDataToDb(memberId);
  // }

  Future getMemberId(var doctorPhoneNum) async {
    var doctorInfo = await authService.fetchDoctorMember(doctorPhoneNum);
    // List<Map<String, dynamic>> targetDoctor = [];
    var memberId;
    for (var doctor in doctorInfo) {
      var mobile1 = doctor['mobile1'];
      var mobile2 = doctor['mobile2'];
      var mobile3 = doctor['mobile3'];
      if (doctorPhoneNum == mobile1 ||
          doctorPhoneNum == mobile2 ||
          doctorPhoneNum == mobile3) {
        memberId = doctor['memberID'];
      }
    }
    return memberId;
  }

  Future<Map<String, dynamic>> verifyPhoneToSendOtp(
      var phone, var bmdcNum) async {
    Map<String, dynamic> otpStatus = Map();
    otpStatus['sendOtp'] = false;
    var doctorInfo = await authService.fetchDoctorSigninInfo(phone);
    if (doctorInfo.length > 0) {
      var doctor = doctorInfo[0]!;
      if (doctor['mobileNo'] != phone && doctor['bmdcNmuber'] != bmdcNum) {
        otpStatus['error'] =
            "No account found with this Phone number and BMDC Number. Please check again";
      } else if (doctor['mobileNo'] != phone) {
        otpStatus['error'] = "This Phone number is not registered with us";
      } else if (doctor['bmdcNmuber'] != bmdcNum) {
        otpStatus['error'] = "This BMDC number is not registered with us";
      } else {
        otpStatus['error'] = false;
        otpStatus['sendOtp'] = true;
      }
    } else {
      otpStatus['error'] =
          'No account found with this phone number, please check again';
    }
    return otpStatus;
  }
}
