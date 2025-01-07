import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/constants/app_string.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/patient/models/chatlist_patient.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
import 'package:pro_health/patient/service/dashboard/chat_service.dart';

class ChatControllerDoctor extends GetxController {
  ApiServices apiServices = ApiServices();
  ChatServicesPatient chatServicesPatient = ChatServicesPatient();
  PatientApiService patientApiService = PatientApiService();
  var selectedImageBase64String = '';
  var selectedImageExt = '';
  var selectedImageName = '';

  File? imageFile;
  var selectedImagePath = ''.obs;
  var userProfileImg = ''.obs;

  void getImage(ImageSource imageSource, ChatList chatList) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      imageFile = File(pickedFile.path);
      selectedImageBase64String = getStringImage(imageFile) ?? '';
      selectedImageExt = pickedFile.path.split('.').last;
      selectedImageName = pickedFile.path.split('/').last.split('.').first;
      // int memberId = await getDoctorMemberId();

      var body = jsonEncode({
        "ImageName": "$selectedImageName",
        "Uuid": generateUid(),
        "imageBase64": "$selectedImageBase64String",
        "ImageType": "Appointment",
        "ImageExtension": "$selectedImageExt",
      });

      var inserted = await patientApiService.insertChatImage(body);

      if (inserted['inserted']) {
        await sendMsgToDB(chatList, inserted['path']);
      }

      if (!inserted['inserted']) {
        Get.defaultDialog(
          title: "Opps!",
          middleText:
              'Something went wrong,failed to send iamge Try again later.',
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

    // int chatId = await sendMsgToDB(chatList);
    // if (chatId == 0) {
    //   Get.defaultDialog(
    //     title: "Opps!",
    //     middleText: 'Something went wrong, failed to send image.',
    //     textCancel: 'Ok',
    //     onCancel: () {},
    //   );
    // } else {
    //   final pickedFile = await ImagePicker().pickImage(source: imageSource);

    //   if (pickedFile != null) {
    //     selectedImagePath.value = pickedFile.path;
    //     imageFile = File(pickedFile.path);
    //     selectedImageBase64String = getStringImage(imageFile) ?? '';
    //     selectedImageExt = pickedFile.path.split('.').last;
    //     selectedImageName = pickedFile.path.split('/').last.split('.').first;
    //     // int memberId = await getDoctorMemberId();

    //     var body = jsonEncode({
    //       "imageName": "$selectedImageName",
    //       "imageBase64": "$selectedImageBase64String",
    //       "imageType": "chatDoctor",
    //       "imageExtension": "$selectedImageExt",
    //       "tableName": "Chat",
    //       "columnName": "attachment",
    //       "whereClouse": "ChatID",
    //       "whereValue": "${chatId.toString()}",
    //     });

    //     var updated = await patientApiService.uploadChatImage(body);

    //     if (!updated) {
    //       Get.defaultDialog(
    //         title: "Opps!",
    //         middleText:
    //             'Something went wrong,failed to send iamge Try again later.',
    //         textCancel: 'Ok',
    //         onCancel: () {},
    //       );
    //     }
    //   } else {
    //     Get.snackbar('error', 'No image selected',
    //         snackPosition: SnackPosition.BOTTOM,
    //         backgroundColor: Colors.red,
    //         colorText: Colors.white);
    //   }
    // }
  }

  sendMsgToDB(ChatList chatList, String imagePath) async {
    int patientId = chatList.patientID ?? 0;

    Map body = {
      "memberID": chatList.memberID ?? 0,
      "patientID": patientId,
      "chatListID": chatList.chatListID,
      "roomID": chatList.roomID,
      "sender": DoctorString,
      "message": 'image',
      "attachment": imagePath,
      "createOn": getTimeNow(),
      "seenByDoctor": true,
      "seenByPatient": false,
      "isDoctor": true,
      "isPatient": false,
    };
    await chatServicesPatient.sendMessageToDb(body);
  }
}
