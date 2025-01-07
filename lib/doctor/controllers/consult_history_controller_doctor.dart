import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/doctor/models/consult%20history/consult_history.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';

class ConsultHistoryDoctorController extends GetxController {
  ApiServices apiServices = ApiServices();
  var consultHistory = <ConsultHistoryDoctorModel>[].obs;

  fetchConsultHistory() async {
    int memberId = await getDoctorMemberId();
    var response = await apiServices.fetchConsultHistory(memberId);
    var reversedResponse = response.reversed.toList();
    consultHistory.addAll(reversedResponse);
  }

  @override
  void onInit() {
    fetchConsultHistory();
    super.onInit();
  }
}
