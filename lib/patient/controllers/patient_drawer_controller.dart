import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/patient/models/patient.dart';
import 'package:pro_health/patient/service/auth/patient_auth_service.dart';

class PatientDrawerController extends GetxController {
  var patientPhoto = ''.obs;
  var patientName = ''.obs;
  var patientEmail = ''.obs;

  var showUserDetails = false.obs;

  PatientAuthService patientAuthService = PatientAuthService();

  var phoneNumber = ''.obs;
  var patientId = 0.obs;

  var patient = PatientModel().obs;

  getPatientInfo() async {
    phoneNumber.value = await getPatientPhone();
    patientId.value = await getPatientId();
    var patientInfo =
        await patientAuthService.fetchPatientSigninInfo(phoneNumber.value);
    if (patientInfo.isNotEmpty) {
      patient.value = patientInfo[0];
    }
  }

  @override
  void onInit() {
    getPatientInfo();
    super.onInit();
  }
}
