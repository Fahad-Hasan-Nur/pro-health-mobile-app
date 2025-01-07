import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_health/doctor/controllers/profile/profile_controller.dart';
import 'package:pro_health/patient/controllers/profile_controller.dart';

class GalleryIcon extends StatelessWidget {
  const GalleryIcon({
    Key? key,
    this.profileController,
    this.doctorProfileController,
    required this.isDoctor,
  }) : super(key: key);

  final PatientProfileController? profileController;
  final DoctorProfileController? doctorProfileController;
  final bool isDoctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (isDoctor) {
              doctorProfileController!.getImage(ImageSource.gallery);
            } else {
              profileController!.getImage(ImageSource.gallery);
            }

            Get.back();
          },
          child: const Icon(
            Icons.image,
            size: 50,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 5),
        const Text('Gallery'),
      ],
    );
  }
}
