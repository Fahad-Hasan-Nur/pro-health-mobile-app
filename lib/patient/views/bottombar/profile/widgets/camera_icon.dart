import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_health/doctor/controllers/profile/profile_controller.dart';
import 'package:pro_health/patient/controllers/profile_controller.dart';

class CameraIcon extends StatelessWidget {
  const CameraIcon({
    Key? key,
    this.profileController,
    required this.isDoctor,
    this.doctorProfileController,
  }) : super(key: key);

  final PatientProfileController? profileController;
  final bool isDoctor;
  final DoctorProfileController? doctorProfileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (isDoctor) {
              doctorProfileController!.getImage(ImageSource.camera);
            } else {
              profileController!.getImage(ImageSource.camera);
            }

            Get.back();
          },
          child: const Icon(
            Icons.camera_alt,
            size: 50,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 5),
        const Text('Camera'),
      ],
    );
  }
}
