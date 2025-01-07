import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/patient/models/consult_history_patient.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';

class ConsultHistoryController extends GetxController {
  PatientApiService patientApiService = PatientApiService();
  ApiServices apiServices = ApiServices();
  var consultHistory = <ConsultHistoryPatientModel>[].obs;

  fetchConsultHistory() async {
    int patientId = await getPatientId();
    var response =
        await patientApiService.fetchConsultHistoryPatient(patientId);
    var reversedResponse = response.reversed.toList();
    consultHistory.addAll(reversedResponse);
    // for (var item in response) {
    //   consultHistory.add(item);
    // }
  }

  @override
  void onInit() {
    fetchConsultHistory();
    super.onInit();
  }
}
