import 'package:get/get.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/doctor/models/payment_method.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';

class EditDoctorProfileController extends GetxController {
  var doctorSpecialityList = <DoctorSpecialityModel>[].obs;
  ApiServices apiServices = ApiServices();

  var paymentMethods = <PaymentMethod>[].obs;

  getSpeciality() async {
    var specialities = await apiServices.fetchSpeciality();

    doctorSpecialityList.addAll(specialities);
  }

  getPaymentMethods() async {
    var response = await apiServices.fetchPaymentMethods();
    if (response.isNotEmpty) {
      paymentMethods.addAll(response);
    }
  }

  @override
  void onInit() {
    getSpeciality();
    getPaymentMethods();
    super.onInit();
  }
}
