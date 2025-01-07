import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/models/district_model.dart';
import 'package:pro_health/doctor/models/police_station_model.dart';
import 'package:pro_health/doctor/models/post_office_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/patient/models/patient_profile_model.dart';
import 'package:pro_health/patient/service/dashboard/profile_service.dart';

class PatientProfileController extends GetxController {
  PatientProfileService patientProfileService = PatientProfileService();

  ApiServices apiServices = ApiServices();
  RxInt patientId = 0.obs;
  // var patients = <PatientProfileModel>[].obs;

  final format = DateFormat("dd-MM-yyyy").obs;

  var patient = PatientProfileModel().obs;
  var districts = <DistrictModel>[].obs;
  var policestations = <PoliceStationModel>[].obs;
  var postOffices = <PostOfficeModel>[].obs;
  var dateOfBirth = ''.obs;

  var count = 0.obs;

  var openEditInfoCard = false.obs;
  var openEditHistoryCard = false.obs;

  var updatingPersonalInfo = false.obs;
  var updatingPersonalHistory = false.obs;

  // personal history
  var allergies = ''.obs;
  var occupation = ''.obs;
  var smoking = ''.obs;
  var maritalStatus = ''.obs;
  var alcohol = ''.obs;
  var exercise = ''.obs;
  var caffeinatedBeverages = ''.obs;

  // personal information
  var name = ''.obs;
  var selectedDistrict = 'Select District'.obs;
  var selectedPoliceStation = 'Select Thana'.obs;
  var selectedDistrictId = 0.obs;
  var selectedPoliceStationId = 0.obs;
  var selectedPostOffice = 'Select Post Office'.obs;
  var selectedPostOfficeId = 0.obs;
  var selectedGender = 'Select Gender'.obs;
  var selectedbloodGroup = 'Select blood group'.obs;
  var weight = ''.obs;
  var selectedMaritalStatus = 'Select Marital Status'.obs;
  var mobileNo = ''.obs;
  var email = ''.obs;
  var editDob = DateTime.now().toIso8601String().obs;

  var selectedImageBase64String = '';
  var selectedImageExt = '';
  var selectedImageName = '';

  File? imageFile;
  var selectedImagePath = ''.obs;
  var userProfileImg = ''.obs;

  var uploadingProfileImage = false.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      imageFile = File(pickedFile.path);
      // log(pickedFile.path);
      // log(pickedFile.path.split('.').last);

      selectedImageBase64String = getStringImage(imageFile) ?? '';
      selectedImageExt = pickedFile.path.split('.').last;
      selectedImageName = pickedFile.path.split('/').last.split('.').first;
      // log(selectedImageBase64String);
      // log(selectedImageExt);
      // log(selectedImageName);

      int patientId = await getPatientId();

      var body = jsonEncode({
        "imageName": "$selectedImageName",
        "imageBase64": "$selectedImageBase64String",
        "imageType": "profile",
        "imageExtension": "$selectedImageExt",
        "tableName": "patient",
        "columnName": "ProfilePic",
        "whereClouse": "patientID",
        "whereValue": "${patientId.toString()}",
      });

      var updated = await patientProfileService.uploadProfileImage(body);

      if (!updated) {
        Get.defaultDialog(
          title: "Opps!",
          middleText:
              'Something went wrong, failed to update profile picture. Try again later.',
          textCancel: 'Ok',
          onCancel: () {},
        );
      }
    } else {
      Get.snackbar('error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // void getImage(ImageSource imageSource) async {
  //   final pickedFile = await ImagePicker().pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     selectedImagePath.value = pickedFile.path;
  //     imageFile = File(pickedFile.path);
  //     uploadingProfileImage.value = true;

  //     int patientId = await getPatientId();

  //     String imageString = getStringImage(imageFile) ?? '';
  //     print('imageString $imageString');
  //     bool imageUploaded = await patientProfileService
  //         .uploadPatientProfileImageString(imageString, patientId);
  //     print('image uploaded = $imageUploaded');
  //   } else {
  //     Get.snackbar('error', 'No image selected',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }

  fetchPoliceStations() async {
    if (selectedDistrictId.value == 0) {
      if (policestations.isNotEmpty) {
        policestations.clear();
      }
      policestations.add(
        PoliceStationModel(
          policeStationID: 0,
          districtID: 0,
          policeStationName: 'Select Thana',
          entryBy: 'default',
          entryDate: getTimeNow(),
        ),
      );
      selectedPoliceStation.value = policestations[0].policeStationName;
      selectedPoliceStationId.value = policestations[0].policeStationID;
    } else {
      if (policestations.isNotEmpty) {
        policestations.clear();
      }
      policestations.add(
        PoliceStationModel(
          policeStationID: 0,
          districtID: 0,
          policeStationName: 'Select Thana',
          entryBy: 'default',
          entryDate: getTimeNow(),
        ),
      );
      var response = await apiServices
          .fetchPoliceStations(selectedDistrictId.value.toString());

      if (response.isNotEmpty) {
        policestations.addAll(response);
      }
    }
    fetchPostOffices();
  }

  fetchPostOffices() async {
    print('post office calling');
    if (selectedPoliceStationId.value == 0) {
      if (postOffices.isNotEmpty) {
        postOffices.clear();
      }
      postOffices.add(
        PostOfficeModel(
          postOfficeId: 0,
          districtID: 0,
          policeStationID: 0,
          postOfficeName: 'Select Post Office',
          postCode: '000',
        ),
      );
      selectedPostOffice.value = postOffices[0].postOfficeName;
      selectedPostOfficeId.value = postOffices[0].postOfficeId;
    } else {
      if (postOffices.isNotEmpty) {
        postOffices.clear();
      }
      postOffices.add(
        PostOfficeModel(
          postOfficeId: 0,
          districtID: 0,
          policeStationID: 0,
          postOfficeName: 'Select Post Office',
          postCode: '000',
        ),
      );
      var response = await apiServices
          .fetchPostOffices(selectedPoliceStationId.value.toString());

      if (response.isNotEmpty) {
        postOffices.addAll(response);
      }
    }
  }

  fetchDistricts() async {
    if (districts.isNotEmpty) {
      districts.clear();
    }
    if (policestations.isNotEmpty) {
      policestations.clear();
    }
    if (postOffices.isNotEmpty) {
      postOffices.clear();
    }
    var response = await apiServices.fetchDistricts();

    if (response.isNotEmpty) {
      districts.add(
        DistrictModel(
          districtID: 0,
          districtName: 'Select District',
          entryBy: 'default',
          entryDate: getTimeNow(),
        ),
      );
      districts.addAll(response);
    }
    fetchPoliceStations();
  }

  Future<bool> updatePersonalHistory() async {
    updatingPersonalHistory.value = true;
    int patientId = await getPatientId();

    Map<String, dynamic> personalHistoryMap = {};
    personalHistoryMap['allergies'] = allergies.value;
    personalHistoryMap['occupation'] = occupation.value;
    personalHistoryMap['smoking'] = smoking.value;
    personalHistoryMap['maritalStatus'] = selectedMaritalStatus.value;
    personalHistoryMap['alcohol'] = alcohol.value;
    personalHistoryMap['exercise'] = exercise.value;
    personalHistoryMap['caffeinatedBeverage'] = caffeinatedBeverages.value;

    bool response = await patientProfileService.updatePersonalHistory(
        personalHistoryMap, patientId);
    if (response) {
      updatingPersonalHistory.value = false;
      // getPatientProfileInfo();
      return true;
    } else {
      updatingPersonalHistory.value = false;
      return false;
    }
  }

  Future<bool> updatePersonalInformation() async {
    updatingPersonalInfo.value = true;
    int patientId = await getPatientId();

    Map<String, dynamic> personalInfoMap = {};
    print('selected district id = ${selectedDistrictId.value}');
    personalInfoMap['name'] = name.value;
    personalInfoMap['districtID'] = selectedDistrictId.value;
    personalInfoMap['policeStationID'] = selectedPoliceStationId.value;
    personalInfoMap['postOfficeID'] = selectedPostOfficeId.value;
    personalInfoMap['gender'] = selectedGender.value;
    personalInfoMap['bloodGroup'] = selectedbloodGroup.value;
    personalInfoMap['weight'] = weight.value;

    personalInfoMap['dateOfBirth'] =
        editDob.value; // getValidDateTime(editDob.value);
    personalInfoMap['email'] = email.value;

    bool response = await patientProfileService.updatePersonalInfo(
        personalInfoMap, patientId);
    if (response) {
      updatingPersonalInfo.value = false;
      getPatientProfileInfo();
      return true;
    } else {
      updatingPersonalInfo.value = false;
      return false;
    }
  }

  getPatientProfileInfo() async {
    patientId.value = await getPatientId();

    patient.value =
        await patientProfileService.getPatientProfileInfo(patientId.value);
    // print(getCustomDateLocal(patient.value.dateOfBirth));
    dateOfBirth.value = getCustomDate(patient.value.dateOfBirth ?? '');
    editDob.value = patient.value.dateOfBirth ?? getTimeNow();
    selectedDistrict.value = patient.value.districtName ?? 'Select District';
    selectedDistrictId.value = patient.value.districtID ?? 0;

    userProfileImg.value = (patient.value.profilePic ?? '').isNotEmpty
        ? (dynamicImageGetApi + patient.value.profilePic!)
        : '';
    //     await createFileFromString(patient.value.profilePic ?? '');
    // print(userProfileImg);

    selectedPostOfficeId.value = patient.value.postOfficeId ?? 0;

    name.value = patient.value.patientName ?? '';

    selectedPoliceStation.value =
        patient.value.policeStationName ?? 'Select Thana';
    selectedPoliceStationId.value = patient.value.policeStationID ?? 0;

    selectedPostOffice.value =
        patient.value.postOfficeName ?? 'Select Post Office';
    selectedPostOfficeId.value = patient.value.postOfficeId ?? 0;

    selectedGender.value = patient.value.gender ?? 'Male';
    selectedbloodGroup.value = patient.value.bloodGroup ?? 'A+';
    weight.value = patient.value.weight ?? '';
    selectedMaritalStatus.value = patient.value.maritalStatus ?? 'Married';
    mobileNo.value = patient.value.mobile ?? '';
    email.value = patient.value.email ?? '';
    allergies.value = patient.value.allergies ?? '';
    occupation.value = patient.value.occupation ?? '';
    smoking.value = patient.value.smoking ?? '';
    alcohol.value = patient.value.alcohol ?? '';
    exercise.value = patient.value.exercise ?? '';
    caffeinatedBeverages.value = patient.value.caffinatedBeverage ?? '';

    fetchDistricts();
  }

  @override
  void onInit() {
    // fetchDistricts();
    getPatientProfileInfo();

    // fetchPostOffices();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
