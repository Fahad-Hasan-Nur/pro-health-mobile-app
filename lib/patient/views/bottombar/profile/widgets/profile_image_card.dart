// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/patient/controllers/profile_controller.dart';

class ProfileImageCard extends StatelessWidget {
  const ProfileImageCard({
    Key? key,
    // required this.profileController,
  }) : super(key: key);

  // final PatientProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Obx(
          () => Container(
            padding: const EdgeInsets.all(8),
            height: 90,
            width: 90,
            child:
                Get.find<PatientProfileController>().uploadingProfileImage.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: Get.find<PatientProfileController>()
                          .selectedImagePath
                          .value ==
                      ''
                  ? Get.find<PatientProfileController>().userProfileImg.value ==
                          ''
                      ? DecorationImage(
                          image: AssetImage(patientNoImagePath),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: NetworkImage(
                              Get.find<PatientProfileController>()
                                  .userProfileImg
                                  .value),
                          fit: BoxFit.cover,
                        )
                  : DecorationImage(
                      image: FileImage(File(Get.find<PatientProfileController>()
                          .selectedImagePath
                          .value)),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        // profileController.openEditInfoCard.value ?
        Positioned(
          bottom: 5,
          right: 0,
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),

        // : Container(),
      ],
    );
  }
}
