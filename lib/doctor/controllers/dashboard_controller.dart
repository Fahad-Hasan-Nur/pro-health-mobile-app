import 'package:get/get.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/patient/models/doctor_slider.dart';

class DoctorDashboardController extends GetxController {
  ApiServices apiServices = ApiServices();

  var sliderImages = <DoctorSliderModel>[].obs;

  getSliderImages() async {
    var response = await apiServices.fetchDoctorSliderImages();
    if (response.isNotEmpty) {
      sliderImages.addAll(response);
    }
  }

  @override
  void onInit() {
    getSliderImages();
    super.onInit();
  }
}
