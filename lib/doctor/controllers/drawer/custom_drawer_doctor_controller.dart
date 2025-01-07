import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/doctor/models/doctor_model.dart';
import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';

class CustomDrawerDoctorController extends GetxController {
  var doctor = DoctorModel().obs;
  var doctorProfile = DoctorProfileModel().obs;
  ApiServices apiServices = ApiServices();
  var profilePic = ''.obs;
  var memberId = 0.obs;
  var doctorPhone = ''.obs;

  getDoctorProfile() async {
    memberId.value = await getDoctorMemberId();
    doctorPhone.value = await getDoctorPhone();
    var response = await apiServices.getDoctorProfile(memberId.value);
    if (response.isNotEmpty) {
      doctorProfile.value = response[0];
    }
    getDoctorProfilePic(doctorProfile.value.profilePicture);
  }

  @override
  void onInit() {
    getDoctorProfile();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
