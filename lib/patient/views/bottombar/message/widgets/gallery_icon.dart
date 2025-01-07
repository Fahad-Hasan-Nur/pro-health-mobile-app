import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_health/doctor/controllers/chat_controller_doctor.dart';
import 'package:pro_health/patient/controllers/chat_controller.dart';
import 'package:pro_health/patient/models/chatlist_patient.dart';

class GalleryIconChat extends StatelessWidget {
  GalleryIconChat({
    Key? key,
    required this.isDoctor,
    this.chatList,
  }) : super(key: key);
  final ChatList? chatList;

  final bool isDoctor;
  final _chatPatientController = Get.put(ChatControllerPatient());
  final _chatDoctorController = Get.put(ChatControllerDoctor());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (isDoctor) {
              _chatDoctorController.getImage(ImageSource.gallery, chatList!);
            } else {
              _chatPatientController.getImage(ImageSource.gallery, chatList!);
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
