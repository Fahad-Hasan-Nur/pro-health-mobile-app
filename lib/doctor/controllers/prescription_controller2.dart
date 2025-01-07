import 'package:get/get.dart';
import 'package:pro_health/doctor/models/medication_model.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/service/prescription_service.dart';

class PrescriptionController extends GetxController {
  PrescriptionService prescriptionService = PrescriptionService();
  static var medicationList = <MedicationModel>[].obs;
  static var selectedGenericId = 0.obs;

  getMedicineList() async {
    var response = await prescriptionService.fetchMedicationList();
    medicationList.addAll(response);
  }

  static Future<List<String>> getBrandSuggestions(String query) async {
    List<String> medicines = [];

    for (var item in medicationList) {
      String brandName = item.brandName ?? '';
      if (brandName != '') {
        medicines.add(brandName);
      }
    }

    return List.of(medicines).where((medicine) {
      final medicineLower = medicine.toLowerCase();
      final queryLower = query.toLowerCase();

      return medicineLower.contains(queryLower);
    }).toList();
  }

  static Future<List<String>> getCompareBrandSuggestions(String query) async {
    List<String> medicines = [];

    for (var item in medicationList) {
      String brandName = item.brandName ?? '';

      if (brandName != '' && selectedGenericId.value == item.genericId) {
        medicines.add(brandName);
      }
    }

    return List.of(medicines).where((medicine) {
      final medicineLower = medicine.toLowerCase();
      final queryLower = query.toLowerCase();

      return medicineLower.contains(queryLower);
    }).toList();
  }

  @override
  void onInit() {
    getMedicineList();
    super.onInit();
  }
}
