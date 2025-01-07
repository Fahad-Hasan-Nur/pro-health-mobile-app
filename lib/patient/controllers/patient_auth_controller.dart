import 'package:pro_health/patient/service/auth/patient_auth_service.dart';

class PatientAuthController {
  final patientAuthService = PatientAuthService();

  signInPatient(var phone, var password) async {
    Map<String, dynamic> signinStatus = Map();
    var response = await patientAuthService.fetchPatientSigninInfo(phone);
    var dbphone;
    String? dbPassword;
    var agreementAcceptStatus;
    var patientId = 0;

    if (response.length > 0) {
      dbphone = response[0].mobile;
      dbPassword = response[0].password;
      agreementAcceptStatus = response[0].agreementAcceptStatus;
      patientId = response[0].patientID ?? 0;
    }

    signinStatus['signin'] = false;

    signinStatus['agreementAcceptedStatus'] = false;

    if (dbphone != phone) {
      signinStatus['error'] = 'No account found with this phone number';
    } else if (dbPassword != password) {
      signinStatus['error'] =
          'Invalid password, Please check your password again';
    } else {
      signinStatus['agreementAcceptedStatus'] = agreementAcceptStatus;
      signinStatus['signin'] = true;
      signinStatus['patientId'] = patientId;
    }
    // print(signinStatus['agreementAcceptedStatus']);
    return signinStatus;
  }

  Future<Map<String, dynamic>> verifyPhoneToSendOtp(var phone) async {
    Map<String, dynamic> otpStatus = Map();
    otpStatus['sendOtp'] = false;
    var doctorInfo = await patientAuthService.fetchPatientSigninInfo(phone);

    if (doctorInfo.length > 0) {
      var doctor = doctorInfo[0];
      if (doctor.mobile != phone) {
        otpStatus['error'] =
            "No account found with this Phone number. Please check again";
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

  Future<bool> checkIfPatientExists(var patientPhone) async {
    var doctorInfo =
        await patientAuthService.fetchPatientSigninInfo(patientPhone);

    if (doctorInfo.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
