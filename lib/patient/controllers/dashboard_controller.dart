import 'package:get/get.dart';
import 'package:pro_health/doctor/models/advance_doctor_search.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/patient/models/patient_slider.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';

class DashboardController extends GetxController {
  ApiServices apiServices = ApiServices();
  PatientApiService patientApiService = PatientApiService();
  var onlineDoctors = <AdvanceDoctorSearch>[].obs;
  var foundOnlineDonctors = <AdvanceDoctorSearch>[].obs;
  // var allDoctors = [].obs;
  var allDoctors = <AdvanceDoctorSearch>[].obs;
  var filteredDoctorsList = <AdvanceDoctorSearch>[].obs;
  var doctorsCount = 0.obs;
  var dropdownValue = "All".obs;
  var selectedSpecialityId = 0.obs;
  var isSearching = false.obs;

  var foundDoctors = [].obs;

  var sliderImages = <PatientSliderModel>[].obs;

  var isLoading = false.obs;

  var rating = 0.0.obs;
  final count1 = 0.obs;

  // void runFilter(String enteredKeyword) {
  //   List results = [];
  //   if (enteredKeyword.trim().isEmpty) {
  //     isSearching.value = false;
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     results = allDoctors;
  //   } else {
  //     isSearching.value = true;
  //     results = allDoctors
  //         .where((doctor) =>
  //             doctor["doctorName"]
  //                 .toLowerCase()
  //                 .contains(enteredKeyword.trim().toLowerCase()) ||
  //             doctor["workingPlace"]
  //                 .toLowerCase()
  //                 .contains(enteredKeyword.trim().toLowerCase()) ||
  //             doctor["specialityName"]
  //                 .toLowerCase()
  //                 .contains(enteredKeyword.trim().toLowerCase()) ||
  //             doctor["bmdcNmuber"]
  //                 .toLowerCase()
  //                 .contains(enteredKeyword.trim().toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }
  //   // Refresh the UI

  //   foundDoctors.value = results;
  //   doctorsCount.value = foundDoctors.length;
  // }

  void runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.trim().isEmpty) {
      isSearching.value = false;
      // if the search field is empty or only contains white-space, we'll display all users
      results = allDoctors;
    } else {
      isSearching.value = true;
      results = allDoctors
          .where((doctor) =>
              doctor.doctorName!
                  .toLowerCase()
                  .contains(enteredKeyword.trim().toLowerCase()) ||
              doctor.workingPlace!
                  .toLowerCase()
                  .contains(enteredKeyword.trim().toLowerCase()) ||
              doctor.specialityName!
                  .toLowerCase()
                  .contains(enteredKeyword.trim().toLowerCase()) ||
              doctor.bmdcNmuber!
                  .toLowerCase()
                  .contains(enteredKeyword.trim().toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI

    foundDoctors.value = results;
    doctorsCount.value = foundDoctors.length;
  }

  void runFilterForHomePage(String enteredKeyword) {
    List<AdvanceDoctorSearch> results = [];
    if (enteredKeyword.trim().isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = onlineDoctors;
    } else {
      results = allDoctors
          .where((doctor) =>
              doctor.doctorName!
                  .toLowerCase()
                  .contains(enteredKeyword.trim().toLowerCase()) ||
              doctor.workingPlace!
                  .toLowerCase()
                  .contains(enteredKeyword.trim().toLowerCase()) ||
              doctor.specialityName!
                  .toLowerCase()
                  .contains(enteredKeyword.trim().toLowerCase()) ||
              doctor.bmdcNmuber!
                  .toLowerCase()
                  .contains(enteredKeyword.trim().toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI

    foundOnlineDonctors.value = results;
  }

  getOnlineDoctor() async {
    print('getOnlineDoctor calling');
    // var doctors = await patientApiService.fetcOnlineDoctors();
    var doctors = await patientApiService.fetcOnlineDoctors();

    // print(doctors);

    onlineDoctors.addAll(doctors);
    foundOnlineDonctors.addAll(doctors);
  }

  updateLoading() {
    isLoading.value = true;
    Future.delayed(Duration(seconds: 1));
    isLoading.value = false;
  }

  filterOnlineDoctor() {
    filteredDoctorsList.clear();
    for (var item in allDoctors) {
      if (item.isOnline!) {
        filteredDoctorsList.add(item);
      }
    }
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  filterMaleDoctors() {
    filteredDoctorsList.clear();
    for (var item in allDoctors) {
      if (item.gender.toString().toLowerCase().trim() == 'male') {
        filteredDoctorsList.add(item);
      }
    }
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  filterFemaleDoctors() {
    filteredDoctorsList.clear();
    for (var item in allDoctors) {
      if (item.gender.toString().toLowerCase().trim() == 'female') {
        filteredDoctorsList.add(item);
      }
    }
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  filterFreeDoctors() {
    filteredDoctorsList.clear();
    for (var item in allDoctors) {
      if (item.consultationFeeOnline == 0.0 ||
          item.consultationFeeOnline == 0 ||
          item.consultationFeeOnline == null) {
        filteredDoctorsList.add(item);
      }
    }
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  filterTopRatedDoctors() {
    filteredDoctorsList.clear();
    filteredDoctorsList.addAll(allDoctors);
    filteredDoctorsList.sort((a, b) => b.rating!.compareTo(a.rating!));
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  filterDoctorList(int fid) {
    switch (fid) {
      case 1:
        filterOnlineDoctor();
        break;
      case 2:
        filterMaleDoctors();
        break;
      case 3:
        filterFemaleDoctors();
        break;
      case 4:
        filterFreeDoctors();
        break;
      case 5:
        filterTopRatedDoctors();
        break;
      default:
        return;
    }
  }

  sortDoctorByExpereinceHightToLow() {
    // print('filter calling = ExpereinceHighttolow');
    filteredDoctorsList.clear();
    filteredDoctorsList.addAll(allDoctors);
    // filteredDoctorsList.sort((a, b) => b['rating'].compareTo(a['rating']));
    filteredDoctorsList.sort((a, b) => b.experience!.compareTo(a.experience!));
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  sortDoctorByExpereinceHLowToHigh() {
    // print('filter calling = ExpereinceHLowToHigh');
    filteredDoctorsList.clear();
    filteredDoctorsList.addAll(allDoctors);
    // filteredDoctorsList.sort((a, b) => b['rating'].compareTo(a['rating']));
    filteredDoctorsList.sort((a, b) => a.experience!.compareTo(b.experience!));
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  sortDoctorByFeesHighToLow() {
    // print('filter calling = feesHLowToHigh');
    filteredDoctorsList.clear();
    filteredDoctorsList.addAll(allDoctors);
    // filteredDoctorsList.sort((a, b) => b['rating'].compareTo(a['rating']));
    filteredDoctorsList.sort(
        (a, b) => b.consultationFeeOnline!.compareTo(a.consultationFeeOnline!));
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  sortDoctorByFeesLowToHigh() {
    // print('filter calling = fees low to high');
    filteredDoctorsList.clear();
    filteredDoctorsList.addAll(allDoctors);
    // filteredDoctorsList.sort((a, b) => b['rating'].compareTo(a['rating']));
    filteredDoctorsList.sort(
        (a, b) => a.consultationFeeOnline!.compareTo(b.consultationFeeOnline!));
    doctorsCount.value = filteredDoctorsList.length;
    updateLoading();
  }

  sortDoctors(int sId) {
    // print('sort doctor listening');
    // print('sid = $sId');
    switch (sId) {
      case 1:
        sortDoctorByExpereinceHightToLow();
        break;
      case 2:
        sortDoctorByExpereinceHLowToHigh();
        break;
      case 3:
        sortDoctorByFeesHighToLow();
        break;
      case 4:
        sortDoctorByFeesLowToHigh();
        break;
      default:
    }
  }

  // getAllDoctors() async {
  //   var doctors = await patientApiService.fetchAllDoctors();
  //   allDoctors.addAll(doctors);
  //   filteredDoctorsList.addAll(doctors);
  //   doctorsCount.value = filteredDoctorsList.length;
  // }

  getAllDoctors() async {
    print('get all doctor calling');
    var doctors = await patientApiService.getAdvanceDoctors();
    allDoctors.addAll(doctors);
    filteredDoctorsList.addAll(doctors);

    doctorsCount.value = filteredDoctorsList.length;
  }

  var doctorTypeList = <DoctorSpecialityModel>[].obs;
  List<DoctorSpecialityModel> doctorSpeciality = [];

  fetchSpeciality() async {
    doctorSpeciality = await apiServices.fetchSpeciality();
    doctorTypeList.add(DoctorSpecialityModel.fromJson({
      "specialityID": 0,
      "specialityName": "All",
      "specialityDetail": "initial value"
    }));

    if (doctorSpeciality.length > 0) {
      for (var item in doctorSpeciality) {
        doctorTypeList.add(item);
      }
    }
  }

  filterDoctorsBySpecialityId(var specialityId) {
    if (specialityId == 0) {
      filteredDoctorsList.clear();
      filteredDoctorsList.addAll(allDoctors);
      doctorsCount.value = filteredDoctorsList.length;
    } else {
      filteredDoctorsList.clear();
      for (var item in allDoctors) {
        if (item.specialityID == specialityId) {
          filteredDoctorsList.add(item);
        }
      }
      doctorsCount.value = filteredDoctorsList.length;
    }
  }

  getSliderImages() async {
    var response = await patientApiService.fetchPatientSliderImages();
    if (response.isNotEmpty) {
      sliderImages.addAll(response);
    }
  }

  @override
  void onInit() {
    getSliderImages();
    getOnlineDoctor();
    getAllDoctors();
    fetchSpeciality();

    interval(count1, (callback) {
      getOnlineDoctor();
    }, time: Duration(seconds: 10));

    super.onInit();
  }
}
