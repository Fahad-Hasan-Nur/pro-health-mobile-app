import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:fdottedline/fdottedline.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/controllers/profile/edit_doctor_profile_controller.dart';
import 'package:pro_health/doctor/controllers/profile/profile_controller.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/doctor/models/payment_method.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/services/api_service/firebase_api.dart';
import 'package:pro_health/doctor/views/drawer/custom_drawer_doctor.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:pro_health/patient/views/bottombar/profile/widgets/camera_icon.dart';
import 'package:pro_health/patient/views/bottombar/profile/widgets/gallery_icon.dart';
// import 'package:select_form_field/select_form_field.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class EditDoctorProfile extends StatefulWidget {
  final List<DoctorSpecialityModel>? doctorSpeciality;
  final memberid;

  const EditDoctorProfile({
    Key? key,
    this.doctorSpeciality,
    this.memberid,
  }) : super(key: key);

  @override
  _EditDoctorProfileState createState() => _EditDoctorProfileState(
        doctorSpeciality: this.doctorSpeciality,
        memberId: this.memberid,
      );
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  final _editController = Get.put(EditDoctorProfileController());

  late File _image;
  File? file;
  UploadTask? task;

  final _paymentMethodAddKey = GlobalKey<FormState>();

  bool imageUploading = false;
  bool isLoading = false;
  bool imageSelected = false;

  bool isOnline = true;
  bool showExperienceEditForm = false;
  bool showPaymentMethodEditForm = false;
  bool updateExperience = false;
  bool updatePaymentMethod = false;

  var imageDownloadUrl;

  var editExpId = 0;
  var editPaymentMethodIdIndex = 0;
  var editPaymentMethodID = 0;
  var selectedExpId = 0;

  final List<DoctorSpecialityModel>? doctorSpeciality;

  final memberId;
  _EditDoctorProfileState({
    this.doctorSpeciality,
    this.memberId,
  });
  final _editDoctorProfileKey = GlobalKey<FormState>();
  final _addExperienceFormKey = GlobalKey<FormState>();

  ApiServices apiServices = ApiServices();

  var chamber1selectedDays = [];
  var chamber2selectedDays = [];
  var doctorProfile = [];
  List<String> chamber1days = [];
  List<String> chamber1daysBangla = [];
  List<String> chamber2days = [];
  List<String> chamber2daysBangla = [];
  String chamber1joinedDays = 'Sun';
  String chamber1joinedDaysBangla = 'রবি';
  String chamber2joinedDays = 'Sun';
  String chamber2joinedDaysBangla = 'রবি';

  double radius = 32;
  double iconSize = 20;
  double distance = 2;
  final format = DateFormat("hh:mm a");

  var itemList = ['Alpha', 'Beta', 'Cat'];
  List experiences = [];
  List<PaymentMethod> paymentMethods = [];

  String? dropdownValue;
  var selectedSpecialityId;

  bool showPaymentCard = false;

  final chamber1values = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final chamber2values = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  // Edit section variables
  var editDoctorProfilePic;
  var editDoctorName;
  var editDoctorNameBangla;
  var editDoctorQualification;
  var editDoctorWorkPlace;
  var editWorkingPlaceBangla;
  var qualificationOne;
  var qualificationTwo;
  var qualificationOneBangla;
  var qualificationTwoBangla;
  var designationOne;
  var designationTwo;
  var designationOneBangla;
  var designationTwoBangla;
  var chamberDoctorID;
  var chamberOneAddress;
  var chamberTwoAddress;
  var chamberOneConsultDay;
  var chamberTwoConsultDay;
  var chamberOneAddressBangla;
  var chamberTwoAddressBangla;
  var chamberOneConsultDayBangla;
  var chamberTwoConsultDayBangla;

  var chamberOneConsultTime;
  var chamberOneConsultTimeBangla;
  var chamberTwoConsultTime;
  var chamberTwoConsultTimeBangla;

  var doctorID;
  // var chamberDoctorId;

  var editDoctorSpeciality;
  // var editDoctorBmdcNum = 0;
  var editDoctorExperience;
  double? editDoctorConsultationFeeOnline = 0.0;
  double? editDoctorConsultationFeePhysical = 0.0;
  double? editDoctorFollowupFee = 0.0;
  var editDoctorChamberAddress1;
  var editDoctorChamberAddress2;
  String? editDoctorConsultationDay = 'sun';
  var editDoctorConsultationStartTime;
  var editDoctorConsultationEndTime;

  String? networkImage = '';

  List gender = ['Male', 'Female'];
  String? selectedGender = 'Male';
  DateTime selectedDate = DateTime.now();

  //controllers
  var nameController = TextEditingController();
  var banglaNameController = TextEditingController();
  var qualificationController = TextEditingController();
  var qualificationOneController = TextEditingController();
  var qualificationTwoController = TextEditingController();
  var qualificationOneBanglaController = TextEditingController();
  var qualificationTwoBanglaController = TextEditingController();
  var workplaceController = TextEditingController();

  var designationOneController = TextEditingController();
  var designationTwoController = TextEditingController();
  var designationOneBanglaController = TextEditingController();
  var designationTwoBanglaController = TextEditingController();
  var banglaWorkplaceController = TextEditingController();
  var experienceController = TextEditingController();
  var consultationFeeOnlineController = TextEditingController();
  var consultationFeePhysicalController = TextEditingController();
  var followupFeeController = TextEditingController();
  var chamberAddress1Controller = TextEditingController();
  var chamberOneAddressController = TextEditingController();
  var chamberOneAddressBanglaController = TextEditingController();
  var chamberTwoAddressController = TextEditingController();
  var chamberTwoAddressBanglaController = TextEditingController();
  var chamberAddress2Controller = TextEditingController();

  var hospitalNameController = TextEditingController();
  var designationController = TextEditingController();
  var departmentController = TextEditingController();
  var durationController = TextEditingController();
  var workingPeriodController = TextEditingController();
  var totalYearOfExpController = TextEditingController();
  var chamberOneConsultTimeController = TextEditingController();
  var chamberOneConsultTimeBanglaController = TextEditingController();
  var chamberTwoConsultTimeController = TextEditingController();
  var chamberTwoConsultTimeBanglaController = TextEditingController();
  var chamberOneConsultDayController = TextEditingController();
  var chamberTwoConsultDayController = TextEditingController();
  var chamberOneConsultDayBanglaController = TextEditingController();
  var chamberTwoConsultDayBanglaController = TextEditingController();

  final paymentPhoneController = TextEditingController();

  var hospitalName = '';
  var designation = '';
  var department = '';
  var duration = '';
  var employmentPeriod = '';

  var totalYearOfExp = '';

  var selectedMobileBank = selectMobileBank;
  bool savingPaymentMethod = false;

  printIntAsDay(int day) {
    print(
        'Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tuesday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    throw '🐞 This should never have happened: $day';
  }

  getChamber1SelectedDaysNames() {
    chamber1days.clear();
    chamber1daysBangla.clear();
    for (var day in chamber1selectedDays) {
      switch (day) {
        case 0:
          chamber1days.add('Sun');
          chamber1daysBangla.add('রবি');
          break;
        case 1:
          chamber1days.add('Mon');
          chamber1daysBangla.add('সোম');
          break;
        case 2:
          chamber1days.add('Tue');
          chamber1daysBangla.add('মঙ্গল');
          break;
        case 3:
          chamber1days.add('Wed');
          chamber1daysBangla.add('বুধ');
          break;
        case 4:
          chamber1days.add('Thu');
          chamber1daysBangla.add('বৃহস্পতি');
          break;
        case 5:
          chamber1days.add('Fri');
          chamber1daysBangla.add('শুক্র');
          break;
        case 6:
          chamber1days.add('Sat');
          chamber1daysBangla.add('শনি');
          break;
      }
    }

    chamber1joinedDays =
        chamber1days.reduce((value, element) => '$value, $element');

    chamber1joinedDaysBangla =
        chamber1daysBangla.reduce((value, element) => '$value, $element');
    // setState(() {});
  }

  getChamber2SelectedDaysNames() {
    chamber2days.clear();
    chamber2daysBangla.clear();
    for (var day in chamber2selectedDays) {
      switch (day) {
        case 0:
          chamber2days.add('Sun');
          chamber2daysBangla.add('রবি');
          break;
        case 1:
          chamber2days.add('Mon');
          chamber2daysBangla.add('সোম');
          break;
        case 2:
          chamber2days.add('Tue');
          chamber2daysBangla.add('মঙ্গল');
          break;
        case 3:
          chamber2days.add('Wed');
          chamber2daysBangla.add('বুধ');
          break;
        case 4:
          chamber2days.add('Thu');
          chamber2daysBangla.add('বৃহস্পতি');
          break;
        case 5:
          chamber2days.add('Fri');
          chamber2daysBangla.add('শুক্র');
          break;
        case 6:
          chamber2days.add('Sat');
          chamber2daysBangla.add('শনি');
          break;
      }
    }

    chamber2joinedDays =
        chamber2days.reduce((value, element) => '$value, $element');

    chamber2joinedDaysBangla =
        chamber2daysBangla.reduce((value, element) => '$value, $element');
  }

  getChamber1SelectedDaysNumber() {
    chamber1selectedDays.clear();
    for (var i = 0; i < chamber1values.length; i++) {
      if (chamber1values[i]) {
        chamber1selectedDays.add(i);
      }
    }

    getChamber1SelectedDaysNames();
  }

  getChamber2SelectedDaysNumber() {
    chamber2selectedDays.clear();
    for (var i = 0; i < chamber2values.length; i++) {
      if (chamber2values[i]) {
        chamber2selectedDays.add(i);
      }
    }

    getChamber2SelectedDaysNames();
  }

  getPaymentMethods() async {
    var response = await apiServices.fetchPaymentMethods();
    if (response.isNotEmpty) {
      if (paymentMethods.isNotEmpty) {
        paymentMethods.clear();
        setState(() {
          paymentMethods.addAll(response);
        });
      } else {
        setState(() {
          paymentMethods.addAll(response);
        });
      }
    }
  }

  _handleUpdatePaymentMethod() async {
    if (selectedMobileBank == selectMobileBank) {
      Get.defaultDialog(
        title: "Opps!",
        middleText: 'Please select a payment first',
        textCancel: 'Ok',
        onCancel: () {},
      );
    } else {
      setState(() {
        savingPaymentMethod = true;
      });
      // insert or update query here
      if (updatePaymentMethod) {
        // update query
        bool updated = await apiServices.udpatePaymentMethod(
            paymentPhoneController.text,
            selectedMobileBank,
            editPaymentMethodID);
        if (updated) {
          paymentPhoneController.clear();
          savingPaymentMethod = false;

          setState(() {
            savingPaymentMethod = false;
            selectedMobileBank = selectMobileBank;
            updatePaymentMethod = false;
          });
          getPaymentMethods();
        } else {
          Get.defaultDialog(
            title: "Opps!",
            middleText: 'Something went wrong, please try again later',
            textCancel: 'Ok',
            onCancel: () {},
          );
        }
      } else {
        // insert query
        bool created = await apiServices.createPaymentMethod(
            paymentPhoneController.text, selectedMobileBank);
        if (created) {
          paymentPhoneController.clear();
          savingPaymentMethod = false;

          setState(() {
            savingPaymentMethod = false;
            selectedMobileBank = selectMobileBank;
            updatePaymentMethod = false;
          });
          getPaymentMethods();
        } else {
          Get.defaultDialog(
            title: "Opps!",
            middleText: 'Something went wrong, please try again later',
            textCancel: 'Ok',
            onCancel: () {},
          );
        }
      }

      // setState(() {
      //   showPaymentCard = false;
      // });
    }
  }

  getDoctorExperiences(var memberId) async {
    var response = await apiServices.fetchDoctorExperience(memberId);
    if (response.isNotEmpty) {
      for (var item in response) {
        Map exp = {};
        exp['experienceID'] = item.experienceID;
        exp['doctorID'] = item.doctorID ?? 0;
        exp['memberID'] = item.memberID ?? 0;
        exp['hospitalName'] = item.hospitalName ?? '';
        exp['designation'] = item.designation ?? '';
        exp['department'] = item.department ?? '';
        exp['duration'] = item.duration ?? '';
        exp['workingPeriod'] = item.workingPeriod ?? '';
        setState(() {
          experiences.add(exp);
        });
      }
    }
  }

  Future selectImage(context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;
    final path = image.path;
    setState(() {
      file = File(path);
      _image = File(image.path);
    });
    setState(() {
      imageUploading = true;
      imageSelected = true;
    });
    await uploadImage(context);
  }

  Future uploadImage(context) async {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    task = FirebaseApi.uploadFile(destination, file!);

    if (task == null) {
      setState(() {
        imageUploading = false;
      });
      showMyDialog(
          context, "Opps!", 'Failed to upload image, please try again.');
      return;
    }

    final snapshot = await task!.whenComplete(() {});
    imageDownloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      imageUploading = false;
    });

    var pathstring = imageDownloadUrl.toString();
    print(pathstring);

    String firstHalf = pathstring.substring(0, pathstring.indexOf('?'));
    String secondHalf = pathstring.substring(pathstring.indexOf('token'));
    final fullString = firstHalf + '-mediahere-' + secondHalf;

    print(fullString);

    setState(() {
      editDoctorProfilePic = fullString;
    });
  }

  Widget removePaymentMethodDialog(BuildContext context, int index) {
    return AlertDialog(
      title: const Text(
        'Remove?',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Are you sure you want to remove this payment method?',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                bool deleted =
                    await apiServices.deletePaymentMethod(editPaymentMethodID);

                if (deleted) {
                  setState(() {
                    updatePaymentMethod = false;
                    selectedMobileBank = selectMobileBank;
                    paymentPhoneController.clear();
                    paymentMethods.removeAt(index);
                  });
                }

                // if (editExpId == index) {

                //   paymentPhoneController.clear();
                //   setState(() {

                //   selectedMobileBank = selectMobileBank;
                //   });
                // } else {}
                // setState(() {
                //   updatePaymentMethod = false;
                //   paymentMethods.removeAt(index);
                // });
                Navigator.of(context).pop();
              },
              child: const Text(
                'Remove',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget removeExpDialog(BuildContext context, int index) {
    return AlertDialog(
      title: const Text(
        'Remove?',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Are you sure you want to remove this experience?',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (editExpId == index) {
                  hospitalNameController.clear();
                  designationController.clear();
                  departmentController.clear();
                  durationController.clear();
                  workingPeriodController.clear();
                } else {}
                setState(() {
                  updateExperience = false;
                  experiences.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                'Remove',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ],
    );
  }

  saveDoctorInfo(BuildContext context) async {
    Map doctorInfoMap = {};
    Map chamberInfoMap = {};

    doctorInfoMap['doctorName'] = editDoctorName;
    doctorInfoMap['doctorID'] = doctorID;
    doctorInfoMap['experience'] = totalYearOfExp;
    doctorInfoMap['gender'] = selectedGender;
    doctorInfoMap['dateOfBirth'] = selectedDate;
    doctorInfoMap['workingPlace'] = editDoctorWorkPlace;
    doctorInfoMap['consultationFeeOnline'] = editDoctorConsultationFeeOnline;
    doctorInfoMap['consultationFeePhysical'] =
        editDoctorConsultationFeePhysical;
    doctorInfoMap['followupFee'] = editDoctorFollowupFee;
    doctorInfoMap['profilePicture'] = editDoctorProfilePic;
    doctorInfoMap['doctorNameBangla'] = editDoctorNameBangla;
    doctorInfoMap['workingPlaceBangla'] = editWorkingPlaceBangla;
    doctorInfoMap['qualificationOne'] = qualificationOne;
    doctorInfoMap['qualificationTwo'] = qualificationTwo;
    doctorInfoMap['qualificationOneBangla'] = qualificationOneBangla;
    doctorInfoMap['qualificationTwoBangla'] = qualificationTwoBangla;
    doctorInfoMap['designationOne'] = designationOne;
    doctorInfoMap['designationTwo'] = designationTwo;
    doctorInfoMap['designationOneBangla'] = designationOneBangla;
    doctorInfoMap['designationTwoBangla'] = designationTwoBangla;
    doctorInfoMap['specialityId'] = selectedSpecialityId;

    chamberInfoMap['chamberDoctorID'] = chamberDoctorID;
    chamberInfoMap['chamberOneAddress'] = chamberOneAddress;
    chamberInfoMap['chamberTwoAddress'] = chamberTwoAddress;
    chamberInfoMap['chamberOneConsultDay'] = chamberOneConsultDay;
    chamberInfoMap['chamberTwoConsultDay'] = chamberTwoConsultDay;
    chamberInfoMap['chamberOneConsultTime'] = chamberOneConsultTime;
    chamberInfoMap['chamberOneConsultTimeBangla'] = chamberOneConsultTimeBangla;
    chamberInfoMap['chamberTwoConsultTime'] = chamberTwoConsultTime;
    chamberInfoMap['chamberTwoConsultTimeBangla'] = chamberTwoConsultTimeBangla;
    chamberInfoMap['chamberOneAddressBangla'] = chamberOneAddressBangla;
    chamberInfoMap['chamberTwoAddressBangla'] = chamberTwoAddressBangla;
    chamberInfoMap['chamberOneConsultDayBangla'] = chamberOneConsultDayBangla;
    chamberInfoMap['chamberTwoConsultDayBangla'] = chamberTwoConsultDayBangla;

    // print('chamberDoctorID ${chamberInfoMap['chamberDoctorID']}');

    var statusCode = await apiServices.updateDoctorInfo(
        doctorInfoMap, chamberInfoMap, memberId, experiences);

    print(statusCode);
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Get.find<DoctorProfileController>().getDoctorProfile();
      // fetchDoctorProfileInfo();
      showMyDialog(
          context, 'Success', 'Account Information Updated Successfully');
    } else {
      setState(() {
        isLoading = false;
      });
      showMyDialog(context, 'Opps!', 'Something went wrong, please try again');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // fetchDoctorInfo(var memberid) async {
  //   var response = await apiServices.fetchDoctorProfile(memberid);
  //   if (response.length > 0) {
  //     setState(() {
  //       editDoctorProfilePic = response[0]['profilePicture'];
  //     });
  //     getDoctorProfilePic(editDoctorProfilePic);
  //   }
  // }

  // getDoctorProfilePic(String? imgString) {
  //   if (imgString == null || imgString == '' || imgString == 'null') {
  //     return null;
  //   } else {
  //     var newzero = imgString.substring(0, imgString.indexOf('files'));
  //     var newfirst = imgString.substring(imgString.indexOf('files') + 6);
  //     var newsecond = newfirst.substring(0, newfirst.indexOf('-media'));
  //     var newthird = newfirst.substring(newfirst.indexOf('token'));

  //     var newfullString =
  //         newzero + 'files%2F' + newsecond + '?alt=media&' + newthird;

  //     setState(() {
  //       networkImage = newfullString;
  //     });
  //   }
  // }

  fetchDoctorProfileInfo() async {
    doctorProfile = await apiServices.fetchDoctorProfile(memberId);

    if (doctorProfile.length > 0) {
      setState(() {
        editDoctorName = doctorProfile[0]['doctorName'] ?? '';
        totalYearOfExp = doctorProfile[0]['experience'] ?? '';
        chamberDoctorID = doctorProfile[0]['chamberDoctorID'] ?? 0;
        totalYearOfExpController.text = doctorProfile[0]['experience'] ?? '';
        doctorID = doctorProfile[0]['doctorID'] ?? 0;
        nameController.text = doctorProfile[0]['doctorName'] ?? '';
        editDoctorNameBangla = doctorProfile[0]['doctorNameBangla'] ?? '';
        banglaNameController.text = doctorProfile[0]['doctorNameBangla'] ?? '';
        // editDoctorQualification = doctorProfile[0]['eduQualificationID'];
        qualificationOne = doctorProfile[0]['qualificationOne'] ?? '';
        qualificationOneController.text =
            doctorProfile[0]['qualificationOne'] ?? '';
        qualificationTwo = doctorProfile[0]['qualificationTwo'] ?? '';
        qualificationTwoController.text =
            doctorProfile[0]['qualificationTwo'] ?? '';
        qualificationOneBangla =
            doctorProfile[0]['qualificationOneBangla'] ?? '';
        qualificationOneBanglaController.text =
            doctorProfile[0]['qualificationOneBangla'] ?? '';
        qualificationTwoBangla =
            doctorProfile[0]['qualificationTwoBangla'] ?? '';
        qualificationTwoBanglaController.text =
            doctorProfile[0]['qualificationTwoBangla'] ?? '';
        designationOne = doctorProfile[0]['designationOne'] ?? '';
        designationOneController.text =
            doctorProfile[0]['designationOne'] ?? '';
        designationTwo = doctorProfile[0]['designationTwo'] ?? '';
        designationTwoController.text =
            doctorProfile[0]['designationTwo'] ?? '';
        designationOneBangla = doctorProfile[0]['designationOneBangla'] ?? '';
        designationOneBanglaController.text =
            doctorProfile[0]['designationOneBangla'] ?? '';
        designationTwoBangla = doctorProfile[0]['designationTwoBangla'] ?? '';
        designationTwoBanglaController.text =
            doctorProfile[0]['designationTwoBangla'] ?? '';
        chamberOneAddress = doctorProfile[0]['chamberOneAddress'] ?? '';
        chamberOneAddressController.text =
            doctorProfile[0]['chamberOneAddress'] ?? '';
        chamberTwoAddress = doctorProfile[0]['chamberTwoAddress'] ?? '';
        chamberTwoAddressController.text =
            doctorProfile[0]['chamberTwoAddress'] ?? '';
        chamberOneConsultDay = doctorProfile[0]['chamberOneConsultDay'] ?? '';
        chamberOneConsultDayController.text =
            doctorProfile[0]['chamberOneConsultDay'] ?? '';

        chamberOneConsultDayBangla =
            doctorProfile[0]['chamberOneConsultDayBangla'] ?? '';
        chamberOneConsultDayBanglaController.text =
            doctorProfile[0]['chamberOneConsultDayBangla'] ?? '';

        chamberTwoConsultDayBangla =
            doctorProfile[0]['chamberTwoConsultDayBangla'] ?? '';
        chamberTwoConsultDayBanglaController.text =
            doctorProfile[0]['chamberTwoConsultDayBangla'] ?? '';

        chamberTwoConsultDay = doctorProfile[0]['chamberTwoConsultDay'] ?? '';
        chamberTwoConsultDayController.text =
            doctorProfile[0]['chamberTwoConsultDay'] ?? '';

        chamberOneConsultTime = doctorProfile[0]['chamberOneConsultTime'] ?? '';
        chamberOneConsultTimeController.text =
            doctorProfile[0]['chamberOneConsultTime'] ?? '';
        chamberOneConsultTimeBangla =
            doctorProfile[0]['chamberOneConsultTimeBangla'] ?? '';
        chamberOneConsultTimeBanglaController.text =
            doctorProfile[0]['chamberOneConsultTimeBangla'] ?? '';
        chamberTwoConsultTime = doctorProfile[0]['chamberTwoConsultTime'] ?? '';
        chamberTwoConsultTimeController.text =
            doctorProfile[0]['chamberTwoConsultTime'] ?? '';

        chamberTwoConsultTimeBangla =
            doctorProfile[0]['chamberTwoConsultTimeBangla'] ?? '';
        chamberTwoConsultTimeBanglaController.text =
            doctorProfile[0]['chamberTwoConsultTimeBangla'] ?? '';
        chamberOneAddressBangla =
            doctorProfile[0]['chamberOneAddressBangla'] ?? '';
        chamberOneAddressBanglaController.text =
            doctorProfile[0]['chamberOneAddressBangla'] ?? '';
        chamberTwoAddressBangla =
            doctorProfile[0]['chamberTwoAddressBangla'] ?? '';
        chamberTwoAddressBanglaController.text =
            doctorProfile[0]['chamberTwoAddressBangla'] ?? '';

        editDoctorWorkPlace = doctorProfile[0]['workingPlace'] ?? '';
        workplaceController.text = doctorProfile[0]['workingPlace'] ?? '';
        editWorkingPlaceBangla = doctorProfile[0]['workingPlaceBangla'] ?? '';
        banglaWorkplaceController.text =
            doctorProfile[0]['workingPlaceBangla'] ?? '';

        selectedSpecialityId = doctorProfile[0]['specialityID'] ?? 0;
        dropdownValue = doctorProfile[0]['specialityName'] ?? '';
        editDoctorExperience = doctorProfile[0]['experience'] ?? '';
        experienceController.text = doctorProfile[0]['experience'] ?? '';
        editDoctorConsultationFeeOnline =
            doctorProfile[0]['consultationFeeOnline'] ?? 0.0;
        consultationFeeOnlineController.text =
            doctorProfile[0]['consultationFeeOnline'].toString();
        editDoctorConsultationFeePhysical =
            doctorProfile[0]['consultationFeePhysical'] ?? 0.0;
        consultationFeePhysicalController.text =
            doctorProfile[0]['consultationFeePhysical'].toString();
        editDoctorFollowupFee = doctorProfile[0]['followupFee'] ?? 0.0;
        followupFeeController.text = doctorProfile[0]['followupFee'].toString();

        selectedGender = doctorProfile[0]['gender'] ?? 'Male';
        selectedDate = DateTime.parse(doctorProfile[0]['dateOfBirth'] ?? '');
        editDoctorProfilePic = doctorProfile[0]['profilePicture'] ?? '';
      });
    }

    getDoctorProfilePic(editDoctorProfilePic);
    getChamber1DaysBoolValues(chamberOneConsultDay!);
    getChamber2DaysBoolValues(chamberTwoConsultDay!);
  }

  getChamber1DaysBoolValues(String days) {
    var daysList = days.split(',');

    if (daysList.length > 0) {
      for (var i = 0; i < daysList.length; i++) {
        switch (daysList[i].trim().toLowerCase()) {
          case 'sun':
            setState(() {
              chamber1values[0] = true;
            });
            break;
          case 'mon':
            setState(() {
              chamber1values[1] = true;
            });
            break;
          case 'tue':
            setState(() {
              chamber1values[2] = true;
            });
            break;
          case 'wed':
            setState(() {
              chamber1values[3] = true;
            });
            break;
          case 'thu':
            setState(() {
              chamber1values[4] = true;
            });
            break;
          case 'fri':
            setState(() {
              chamber1values[5] = true;
            });
            break;
          case 'sat':
            setState(() {
              chamber1values[6] = true;
            });
            break;
          default:
            setState(() {
              chamber1values[i] = false;
            });
        }
      }
    }
  }

  getChamber2DaysBoolValues(String days) {
    var daysList = days.split(',');

    if (daysList.length > 0) {
      for (var i = 0; i < daysList.length; i++) {
        switch (daysList[i].trim().toLowerCase()) {
          case 'sun':
            setState(() {
              chamber2values[0] = true;
            });
            break;
          case 'mon':
            setState(() {
              chamber2values[1] = true;
            });
            break;
          case 'tue':
            setState(() {
              chamber2values[2] = true;
            });
            break;
          case 'wed':
            setState(() {
              chamber2values[3] = true;
            });
            break;
          case 'thu':
            setState(() {
              chamber2values[4] = true;
            });
            break;
          case 'fri':
            setState(() {
              chamber2values[5] = true;
            });
            break;
          case 'sat':
            setState(() {
              chamber2values[6] = true;
            });
            break;
          default:
            setState(() {
              chamber2values[i] = false;
            });
        }
      }
    }
  }

  @override
  void initState() {
    getPaymentMethods();
    if (doctorSpeciality!.length > 0) {
      setState(() {
        dropdownValue = doctorSpeciality![0].specialityName;
        selectedSpecialityId = doctorSpeciality![0].specialityId;
      });
    }

    // fetchDoctorInfo(memberId);
    fetchDoctorProfileInfo();
    getDoctorExperiences(widget.memberid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerDoctor(),
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: kBaseColor,
        shadowColor: Colors.teal,
        iconTheme: IconThemeData(color: kTitleColor),
        toolbarHeight: 50,
        title: Text(
          'Edit My Profile',
          style:
              TextStyle(fontFamily: 'Segoe', fontSize: 18, color: kTitleColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _editDoctorProfileKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 3.0, right: 10.0, bottom: 10.0),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        // ignore: deprecated_member_use
                        overflow: Overflow.visible,
                        children: [
                          Obx(
                            () => Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: (Get.find<DoctorProfileController>()
                                                  .profilePic
                                                  .value ==
                                              '' ||
                                          Get.find<DoctorProfileController>()
                                                  .profilePic
                                                  .value ==
                                              'null'
                                      ? AssetImage(noImagePath)
                                      : NetworkImage(
                                          Get.find<DoctorProfileController>()
                                              .profilePic
                                              .value)) as ImageProvider<Object>,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -(iconSize + radius),
                            right: -(radius + iconSize - distance - 40),
                            bottom: iconSize - 95,
                            left: radius + iconSize + 38,
                            child: RawMaterialButton(
                              elevation: 5.0,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.blue,
                                size: iconSize,
                              ),
                              shape: CircleBorder(),
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(3.0),
                              onPressed: () {
                                // selectImage(context);

                                Get.defaultDialog(
                                  title: 'Select Option',
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CameraIcon(
                                        doctorProfileController:
                                            Get.find<DoctorProfileController>(),
                                        isDoctor: true,
                                      ),
                                      SizedBox(width: 40),
                                      GalleryIcon(
                                        doctorProfileController:
                                            Get.find<DoctorProfileController>(),
                                        isDoctor: true,
                                      ),
                                    ],
                                  ),
                                );

                                //Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditDoctor()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   child: Stack(
                  //     clipBehavior: Clip.none,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       Container(
                  //         height: 115,
                  //         width: 115,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(100),
                  //           color: Colors.blue,
                  //           image: DecorationImage(
                  //             // image: NetworkImage(networkImage),
                  //             image: imageSelected
                  //                 ? FileImage(_image)
                  //                 : (networkImage == null ||
                  //                             networkImage!.isEmpty
                  //                         ? AssetImage(noImagePath)
                  //                         : NetworkImage(networkImage!))
                  //                     as ImageProvider<Object>,
                  //             // image: networkImage == null || networkImage == ''
                  //             //     ? (_image == null
                  //             //         ? AssetImage(noImagePath)
                  //             //         : FileImage(_image))
                  //             //     : NetworkImage(networkImage),
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //         child: imageUploading
                  //             ? Center(
                  //                 child: CircularProgressIndicator(),
                  //               )
                  //             : null,
                  //       ),
                  //       Positioned(
                  //         top: -(iconSize + radius),
                  //         right: -(radius + iconSize - distance - 40),
                  //         bottom: iconSize - 95,
                  //         left: radius + iconSize + 50,
                  //         child: RawMaterialButton(
                  //           elevation: 5.0,
                  //           child: Icon(
                  //             Icons.camera_alt_outlined,
                  //             color: Colors.blue,
                  //             size: iconSize,
                  //           ),
                  //           shape: CircleBorder(),
                  //           fillColor: Colors.white,
                  //           padding: const EdgeInsets.all(3.0),
                  //           onPressed: () {
                  //             // selectImage(context);

                  //             Get.defaultDialog(
                  //               title: 'Select Option',
                  //               content: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   CameraIcon(
                  //                     doctorProfileController:
                  //                         profileController,
                  //                     isDoctor: true,
                  //                   ),
                  //                   SizedBox(width: 40),
                  //                   GalleryIcon(
                  //                     doctorProfileController:
                  //                         profileController,
                  //                     isDoctor: true,
                  //                   ),
                  //                 ],
                  //               ),
                  //             );

                  //             //Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditDoctor()));
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: MediaQuery.of(context).size.width / 1.3,
                      lineThickness: 1.0,
                      dashLength: 4.0,
                      dashColor: kBaseColor,
                      dashRadius: 0.0,
                      dashGapLength: 4.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 0.0,
                    ),
                    // child: FDottedLine(
                    //   color: kBaseColor,
                    //   width: 298.0,
                    //   strokeWidth: 1.0,
                    //   dottedLength: 10.0,
                    //   space: 2.0,
                    //   corner: FDottedLineCorner.all(6.0),
                    // ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (val) => editDoctorName = val,
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Name',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => editDoctorNameBangla = val,
                    controller: banglaNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Name (Bangla)',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  // TextFormField(
                  //   onSaved: (val) => editDoctorQualification = val,
                  //   controller: qualificationController,
                  //   decoration: InputDecoration(
                  //     //icon: Icon(Icons.lock),
                  //     labelText: 'Qualification',
                  //   ),
                  //   validator:
                  //       RequiredValidator(errorText: 'This field is required'),
                  // ),
                  TextFormField(
                    onSaved: (val) => qualificationOne = val,
                    controller: qualificationOneController,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Qualification One',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => qualificationOneBangla = val,
                    controller: qualificationOneBanglaController,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Qualification One (Bangla)',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => qualificationTwo = val,
                    controller: qualificationTwoController,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Qualification Two',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),

                  TextFormField(
                    onSaved: (val) => qualificationTwoBangla = val,
                    controller: qualificationTwoBanglaController,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Qualification Two (Bangla)',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => editDoctorWorkPlace = val,
                    controller: workplaceController,
                    obscureText: false,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Working Place',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => editWorkingPlaceBangla = val,
                    controller: banglaWorkplaceController,
                    obscureText: false,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Working Place (Bangla)',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => designationOne = val,
                    controller: designationOneController,
                    obscureText: false,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Designation One',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => designationOneBangla = val,
                    controller: designationOneBanglaController,
                    obscureText: false,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Designation One (Bangla)',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => designationTwo = val,
                    controller: designationTwoController,
                    obscureText: false,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Designation Two',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => designationTwoBangla = val,
                    controller: designationTwoBanglaController,
                    obscureText: false,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Designation Two (Bangla)',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Speciality',
                          style: TextStyle(color: Color(0xFF949393)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 350,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          isExpanded: true,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                            for (var item in doctorSpeciality!) {
                              if (item.specialityName == newValue) {
                                setState(() {
                                  selectedSpecialityId = item.specialityId;
                                });
                              }
                            }
                          },
                          items: doctorSpeciality!
                              .map((DoctorSpecialityModel data) {
                            return DropdownMenuItem(
                              value: data.specialityName,
                              child: Text(
                                data.specialityName!,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  // TextFormField(
                  //   onSaved: (val) {
                  //     if (val == null || val == '') {
                  //       editDoctorBmdcNum = 0;
                  //     } else {
                  //       editDoctorBmdcNum = int.parse(val);
                  //     }
                  //     print(editDoctorBmdcNum);
                  //   },
                  //   obscureText: false,
                  //   validator:
                  //       RequiredValidator(errorText: 'This field is required'),
                  //   decoration: InputDecoration(
                  //     //icon: Icon(Icons.lock),
                  //     labelText: 'BMDC No.',
                  //   ),
                  // ),
                  // TextFormField(
                  //   onSaved: (val) => editDoctorExperience = val,
                  //   controller: experienceController,
                  //   validator:
                  //       RequiredValidator(errorText: 'This field is required'),
                  //   decoration: InputDecoration(
                  //     //icon: Icon(Icons.lock),
                  //     labelText: 'Experience',
                  //   ),
                  // ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Experience',
                          style: TextStyle(color: Color(0xFF949393)),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    onSaved: (val) {
                      totalYearOfExp = val ?? '';
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: totalYearOfExpController,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Total year of experience',
                      hintText: '10',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  !showExperienceEditForm
                      ? MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.only(
                              top: 1, left: 18, bottom: 5, right: 18),
                          color: kBaseColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Add Experience',
                                style: TextStyle(
                                    fontFamily: "Segoe",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: kWhiteShade),
                              ),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              showExperienceEditForm = true;
                            });
                          },
                        )
                      : Card(
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    updateExperience
                                        ? 'Update Working Experience'
                                        : 'Add Working Experience',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Form(
                                  key: _addExperienceFormKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onSaved: (val) =>
                                            hospitalName = val ?? '',
                                        controller: hospitalNameController,
                                        validator: RequiredValidator(
                                            errorText:
                                                'This field is required'),
                                        decoration: InputDecoration(
                                          //icon: Icon(Icons.lock),
                                          labelText: 'Hospital Name',
                                          hintText:
                                              'e.g: Chattogram Medical College',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                        ),
                                      ),
                                      TextFormField(
                                        onSaved: (val) =>
                                            designation = val ?? '',
                                        controller: designationController,
                                        validator: RequiredValidator(
                                            errorText:
                                                'This field is required'),
                                        decoration: InputDecoration(
                                          //icon: Icon(Icons.lock),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                          labelText: 'Designation',
                                          hintText:
                                              'e.g: Consultant (Neurology)',
                                        ),
                                      ),
                                      TextFormField(
                                        onSaved: (val) =>
                                            department = val ?? '',
                                        controller: departmentController,
                                        validator: RequiredValidator(
                                            errorText:
                                                'This field is required'),
                                        decoration: InputDecoration(
                                          //icon: Icon(Icons.lock),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                          labelText: 'Department',
                                          hintText: 'e.g: Neurology',
                                        ),
                                      ),
                                      TextFormField(
                                        onSaved: (val) => duration = val ?? '',
                                        controller: durationController,
                                        validator: RequiredValidator(
                                            errorText:
                                                'This field is required'),
                                        decoration: InputDecoration(
                                          //icon: Icon(Icons.lock),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                          labelText: 'Duration',
                                          hintText: 'e.g: 2 years',
                                        ),
                                      ),
                                      TextFormField(
                                        onSaved: (val) =>
                                            employmentPeriod = val ?? '',
                                        controller: workingPeriodController,
                                        validator: RequiredValidator(
                                            errorText:
                                                'This field is required'),
                                        decoration: InputDecoration(
                                          //icon: Icon(Icons.lock),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                          labelText: 'Employment Period',
                                          hintText:
                                              'e.g: Jan 01 2019 to Dec 31 2020',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.only(
                                    top: 1, left: 68, bottom: 5, right: 68),
                                color: kBaseColor,
                                child: Text(
                                  updateExperience ? 'Update' : 'Save',
                                  style: TextStyle(
                                      fontFamily: "Segoe",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: kWhiteShade),
                                ),
                                onPressed: () {
                                  if (_addExperienceFormKey.currentState!
                                      .validate()) {
                                    _addExperienceFormKey.currentState!.save();

                                    if (updateExperience) {
                                      setState(() {
                                        experiences[editExpId]['experienceID'] =
                                            selectedExpId;
                                        experiences[editExpId]['doctorID'] =
                                            doctorID;
                                        experiences[editExpId]['memberID'] =
                                            widget.memberid;
                                        experiences[editExpId]['hospitalName'] =
                                            hospitalNameController.text;
                                        experiences[editExpId]['designation'] =
                                            designationController.text;
                                        experiences[editExpId]['department'] =
                                            departmentController.text;
                                        experiences[editExpId]['duration'] =
                                            durationController.text;
                                        experiences[editExpId]
                                                ['workingPeriod'] =
                                            workingPeriodController.text;
                                        setState(() {
                                          updateExperience = false;
                                        });
                                        hospitalNameController.clear();
                                        designationController.clear();
                                        departmentController.clear();
                                        durationController.clear();
                                        workingPeriodController.clear();
                                      });
                                    } else {
                                      Map exp = {};
                                      exp['experienceID'] = 0;
                                      exp['doctorID'] = doctorID;
                                      exp['memberID'] = widget.memberid;
                                      exp['hospitalName'] =
                                          hospitalNameController.text;
                                      exp['designation'] =
                                          designationController.text;
                                      exp['department'] =
                                          departmentController.text;
                                      exp['duration'] = durationController.text;
                                      exp['workingPeriod'] =
                                          workingPeriodController.text;

                                      var contain = experiences.where(
                                          (experience) =>
                                              experience['hospitalName'] ==
                                              hospitalNameController.text);
                                      if (contain.isEmpty) {
                                        setState(() {
                                          experiences.add(exp);
                                        });
                                        hospitalNameController.clear();
                                        designationController.clear();
                                        departmentController.clear();
                                        durationController.clear();
                                        workingPeriodController.clear();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Hospital Name already exists, please enter another one'),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),

                  experiences.length > 0
                      ? ListTile(
                          title: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: experiences.length,
                              itemBuilder: (BuildContext context, int index) {
                                var experince = experiences[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 6,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 25,
                                          color: kCardTitleColor,
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 12.0,
                                                    top: 4.0,
                                                    right: 12,
                                                    bottom: 1),
                                                child: Text(
                                                  experince['hospitalName'],
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kBodyTextColor),
                                                ),
                                                alignment: Alignment.centerLeft,
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: 30,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      updateExperience = true;
                                                      showExperienceEditForm =
                                                          true;
                                                    });
                                                    hospitalNameController
                                                            .text =
                                                        experince[
                                                            'hospitalName'];
                                                    designationController.text =
                                                        experince[
                                                            'designation'];
                                                    departmentController.text =
                                                        experince['department'];
                                                    durationController.text =
                                                        experince['duration'];
                                                    workingPeriodController
                                                            .text =
                                                        experince[
                                                            'workingPeriod'];
                                                    editExpId = index;
                                                    selectedExpId = experince[
                                                        'experienceID'];
                                                    // print(editExpId);
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 20,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: 0,
                                                child: IconButton(
                                                  onPressed: () =>
                                                      showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        removeExpDialog(
                                                            context, index),
                                                  ),
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10, top: 6),
                                                      child: Text(
                                                        'Designation:',
                                                        style: TextStyle(
                                                          fontFamily: 'Segoe,',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 4, top: 6),
                                                      child: Text(
                                                        experince[
                                                            'designation'],
                                                        style: TextStyle(
                                                          fontFamily: 'Segoe,',
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Department:',
                                                        style: TextStyle(
                                                          fontFamily: 'Segoe,',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 4),
                                                      child: Text(
                                                        experince['department'],
                                                        style: TextStyle(
                                                          fontFamily: 'Segoe,',
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Duration:',
                                                        style: TextStyle(
                                                          fontFamily: 'Segoe,',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 4),
                                                      child: Text(
                                                        experince['duration'],
                                                        style: TextStyle(
                                                          fontFamily: 'Segoe,',
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Employment Period:',
                                                        style: TextStyle(
                                                          fontFamily: 'Segoe,',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 4),
                                                      child: Text(
                                                        experince[
                                                            'workingPeriod'],
                                                        style: TextStyle(
                                                          fontFamily: 'Segoe,',
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container(),

                  TextFormField(
                    onSaved: (val) {
                      if (val == null || val == '') {
                        editDoctorConsultationFeeOnline = 0;
                      } else {
                        editDoctorConsultationFeeOnline = double.parse(val);
                      }
                    },
                    controller: consultationFeeOnlineController,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Consultation Fee Online',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) {
                      if (val == null || val == '') {
                        editDoctorConsultationFeePhysical = 0;
                      } else {
                        editDoctorConsultationFeePhysical = double.parse(val);
                      }
                    },
                    controller: consultationFeePhysicalController,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Consultation Fee Physical',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) {
                      if (val == null || val == '') {
                        editDoctorFollowupFee = 0;
                      } else {
                        editDoctorFollowupFee = double.parse(val);
                      }
                    },
                    controller: followupFeeController,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Follow-Up Fees',
                    ),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),

                  //================ start of payemnt card ===============/

                  SizedBox(height: 10),

                  // Card(
                  //   child: Container(
                  //     child: Table(
                  //       // border: TableBorder.all(color: Color(0xFFD2DBDB)),
                  //       columnWidths: const {
                  //         0: FractionColumnWidth(.4),
                  //         1: FractionColumnWidth(.6),
                  //       },
                  //       children: [
                  //         TableRow(
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "Type",
                  //                 style: TextStyle(
                  //                   fontSize: 15,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Color(0xFF525252),
                  //                 ),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Obx(
                  //                 () => Text(
                  //                   '# ${profileController.useId.value}',
                  //                   style: TextStyle(
                  //                     fontSize: 15,
                  //                     color: Color(0xFF525252),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  !showPaymentCard
                      ? MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.only(
                              top: 1, left: 18, bottom: 5, right: 18),
                          color: kBaseColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Add Payment Method',
                                style: TextStyle(
                                    fontFamily: "Segoe",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: kWhiteShade),
                              ),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              showPaymentCard = true;
                            });
                          },
                        )
                      : Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Form(
                            key: _paymentMethodAddKey,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            updatePaymentMethod
                                                ? "Update Payment Method"
                                                : 'Add Payment Method',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: kBaseColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: selectedMobileBank,
                                                  items: <String>[
                                                    selectMobileBank,
                                                    bkash,
                                                    nagad,
                                                    rocket
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      selectedMobileBank = val!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Mobile Number',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextFormField(
                                        controller: paymentPhoneController,
                                        validator: RequiredValidator(
                                            errorText:
                                                'Mobile Number is Required'),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          hintText: "019XXXXXXXX",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          padding: EdgeInsets.only(
                                              top: 1,
                                              left: 18,
                                              bottom: 5,
                                              right: 18),
                                          color: kBaseColor,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                updatePaymentMethod
                                                    ? savingPaymentMethod
                                                        ? 'Please Wait..'
                                                        : "Update"
                                                    : savingPaymentMethod
                                                        ? 'Please Wait..'
                                                        : 'Save',
                                                style: TextStyle(
                                                    fontFamily: "Segoe",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: kWhiteShade),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            if (_paymentMethodAddKey
                                                .currentState!
                                                .validate()) {
                                              _handleUpdatePaymentMethod();
                                            }
                                          },
                                        ),
                                        SizedBox(width: 20),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          padding: EdgeInsets.only(
                                              top: 1,
                                              left: 18,
                                              bottom: 5,
                                              right: 18),
                                          color: Colors.redAccent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    fontFamily: "Segoe",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: kWhiteShade),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showPaymentCard = false;
                                              updatePaymentMethod = false;
                                              selectedMobileBank =
                                                  selectMobileBank;
                                              paymentPhoneController.clear();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                  SizedBox(height: 15),
                  paymentMethods.length > 0
                      ? ListTile(
                          title: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: paymentMethods.length,
                              itemBuilder: (BuildContext context, int index) {
                                PaymentMethod paymentMethod =
                                    paymentMethods[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Table(
                                            // border: TableBorder.all(color: Color(0xFFD2DBDB)),
                                            columnWidths: const {
                                              0: FractionColumnWidth(.3),
                                              1: FractionColumnWidth(.7),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Text(
                                                      "Type",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF525252),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Text(
                                                      '${paymentMethod.paymentMode}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xFF525252),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Phone",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF525252),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '${paymentMethod.paymentPhone}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xFF525252),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                editPaymentMethodIdIndex =
                                                    index;
                                                editPaymentMethodID =
                                                    paymentMethod.id!;
                                                showDialog<String>(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      removePaymentMethodDialog(
                                                          context, index),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  updatePaymentMethod = true;
                                                  showPaymentMethodEditForm =
                                                      true;
                                                  showPaymentCard = true;
                                                  selectedMobileBank =
                                                      paymentMethod
                                                          .paymentMode!;
                                                });
                                                paymentPhoneController.text =
                                                    paymentMethod.paymentPhone!;

                                                editPaymentMethodIdIndex =
                                                    index;
                                                editPaymentMethodID =
                                                    paymentMethod.id!;

                                                // print(editExpId);
                                              },
                                              // onTap: () => showDialog<String>(
                                              //   context: context,
                                              //   builder: (BuildContext
                                              //           context) =>
                                              //       removePaymentMethodDialog(
                                              //           context, index),
                                              // ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container(),
                  Divider(color: kTextLightColor),

                  // Container(
                  //   width: MediaQuery.of(context).size.width - 40,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: kTextLightColor),
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       DropdownButtonHideUnderline(
                  //         child: DropdownButton2(
                  //           customButton: const Text('Select Mobile bank'),
                  //           customItemsIndexes: const [3],
                  //           customItemsHeight: 8,
                  //           items: [
                  //             ...MenuItems.firstItems.map(
                  //               (item) => DropdownMenuItem<MenuItem>(
                  //                 value: item,
                  //                 child: MenuItems.buildItem(item),
                  //               ),
                  //             ),
                  //             const DropdownMenuItem<Divider>(
                  //                 enabled: false, child: Divider()),
                  //             ...MenuItems.secondItems.map(
                  //               (item) => DropdownMenuItem<MenuItem>(
                  //                 value: item,
                  //                 child: MenuItems.buildItem(item),
                  //               ),
                  //             ),
                  //           ],
                  //           onChanged: (value) {
                  //             MenuItems.onChanged(context, value as MenuItem);
                  //           },
                  //           itemHeight: 48,
                  //           itemWidth: MediaQuery.of(context).size.width / 2,
                  //           itemPadding:
                  //               const EdgeInsets.only(left: 16, right: 16),
                  //           dropdownPadding:
                  //               const EdgeInsets.symmetric(vertical: 6),
                  //           dropdownDecoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(4),
                  //             color: Colors.redAccent,
                  //           ),
                  //           dropdownElevation: 8,
                  //           offset: const Offset(0, 8),
                  //         ),
                  //       ),
                  //       SizedBox(width: 15),
                  //       Icon(Icons.arrow_drop_down),
                  //     ],
                  //   ),
                  // ),

                  //================ end of payemnt card ===============/

                  TextFormField(
                    onSaved: (val) => chamberOneAddress = val,
                    controller: chamberOneAddressController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber Address - 1',
                    ),
                    maxLines: 25,
                    minLines: 2,
                    scrollPadding: const EdgeInsets.all(20),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => chamberOneAddressBangla = val,
                    controller: chamberOneAddressBanglaController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber Address - 1 (Bangla)',
                    ),
                    maxLines: 25,
                    minLines: 2,
                    scrollPadding: const EdgeInsets.all(20),
                    validator:
                        RequiredValidator(errorText: 'This field is required'),
                  ),
                  TextFormField(
                    onSaved: (val) => chamberTwoAddress = val,
                    controller: chamberTwoAddressController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber Address - 2',
                    ),
                    maxLines: 25,
                    minLines: 2,
                    scrollPadding: const EdgeInsets.all(20),
                  ),
                  TextFormField(
                    onSaved: (val) => chamberTwoAddressBangla = val,
                    controller: chamberTwoAddressBanglaController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber Address - 2 (Bangla)',
                    ),
                    maxLines: 25,
                    minLines: 2,
                    scrollPadding: const EdgeInsets.all(20),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    onSaved: (val) => chamberOneConsultDay = val,
                    controller: chamberOneConsultDayController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber 1 Consultation Day',
                      hintText: 'e.g: Sun-Tue',
                    ),
                    scrollPadding: const EdgeInsets.all(20),
                  ),

                  TextFormField(
                    onSaved: (val) => chamberOneConsultDayBangla = val,
                    controller: chamberOneConsultDayBanglaController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber 1 Consultation Day (Bangla)',
                      hintText: 'e.g: রবি থেকে মঙ্গল',
                    ),
                    scrollPadding: const EdgeInsets.all(20),
                  ),

                  TextFormField(
                    onSaved: (val) => chamberTwoConsultDay = val,
                    controller: chamberTwoConsultDayController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber 2 Consultation Day',
                      hintText: 'e.g: Wed-Sat',
                    ),
                    scrollPadding: const EdgeInsets.all(20),
                  ),

                  TextFormField(
                    onSaved: (val) => chamberTwoConsultDayBangla = val,
                    controller: chamberTwoConsultDayBanglaController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber 2 Consultation Day (Bangla)',
                      hintText: 'e.g: বুধ থেকে শনি',
                    ),
                    scrollPadding: const EdgeInsets.all(20),
                  ),

                  // Container(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     'Chamber 1 Consultation Day',
                  //     style: TextStyle(fontSize: 16),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // WeekdaySelector(
                  //   displayedDays: {
                  //     DateTime.saturday,
                  //     DateTime.sunday,
                  //     DateTime.monday,
                  //     DateTime.tuesday,
                  //     DateTime.wednesday,
                  //     DateTime.thursday,
                  //     DateTime.friday,
                  //   },
                  //   firstDayOfWeek: DateTime.sunday,
                  //   selectedFillColor: kBaseColor,
                  //   onChanged: (v) {
                  //     // printIntAsDay(v);
                  //     print(v);
                  //     setState(() {
                  //       chamber1values[v % 7] = !chamber1values[v % 7];
                  //     });
                  //     getChamber1SelectedDaysNumber();
                  //   },
                  //   selectedElevation: 15,
                  //   elevation: 5,
                  //   disabledElevation: 0,
                  //   values: chamber1values,
                  // ),
                  // Container(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     'Chamber 2 Consultation Day',
                  //     style: TextStyle(fontSize: 16),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // WeekdaySelector(
                  //   displayedDays: {
                  //     DateTime.saturday,
                  //     DateTime.sunday,
                  //     DateTime.monday,
                  //     DateTime.tuesday,
                  //     DateTime.wednesday,
                  //     DateTime.thursday,
                  //     DateTime.friday,
                  //   },
                  //   firstDayOfWeek: DateTime.sunday,
                  //   selectedFillColor: kBaseColor,
                  //   onChanged: (v) {
                  //     setState(() {
                  //       chamber2values[v % 7] = !chamber2values[v % 7];
                  //     });
                  //     getChamber2SelectedDaysNumber();
                  //     print(v);
                  //     print(chamber2values);
                  //   },
                  //   selectedElevation: 15,
                  //   elevation: 5,
                  //   disabledElevation: 0,
                  //   values: chamber2values,
                  // ),
                  // DateTimeField(
                  //   format: format,
                  //   onSaved: (val) {
                  //     if (val != null) {
                  //       setState(() {
                  //         chamber1ConsultationStartTime = val.toIso8601String();
                  //       });
                  //     }
                  //   },
                  //   // initialValue: DateTime.parse('1970-01-01T13:00:00.000'),
                  //   initialValue: chamber1ConsultationStartTime != null
                  //       ? DateTime.parse(chamber1ConsultationStartTime)
                  //       : null,
                  //   onShowPicker: (context, currentValue) async {
                  //     final time = await showTimePicker(
                  //       context: context,
                  //       initialTime: TimeOfDay.fromDateTime(
                  //           currentValue ?? DateTime.now()),
                  //       builder: (context, child) => MediaQuery(
                  //           data: MediaQuery.of(context)
                  //               .copyWith(alwaysUse24HourFormat: false),
                  //           child: child!),
                  //     );

                  //     return DateTimeField.convert(time);
                  //   },
                  //   decoration: InputDecoration(
                  //       labelText: 'Chamber 1 Consultation Start Time'),
                  // ),

                  TextFormField(
                    onSaved: (val) => chamberOneConsultTime = val,
                    controller: chamberOneConsultTimeController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber 1 Consultation Time',
                      hintText: 'e.g: 7:30 PM to 10:00 PM',
                    ),
                    scrollPadding: const EdgeInsets.all(20),
                  ),

                  TextFormField(
                    onSaved: (val) => chamberOneConsultTimeBangla = val,
                    controller: chamberOneConsultTimeBanglaController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber 1 Consultation Time (Bangla)',
                      hintText: 'e.g: সন্ধ্যা ৭ঃ৩০ থেকে রাত ১০ টা',
                    ),
                    scrollPadding: const EdgeInsets.all(20),
                  ),

                  TextFormField(
                    onSaved: (val) => chamberTwoConsultTime = val,
                    controller: chamberTwoConsultTimeController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber 2 Consultation Time',
                      hintText: 'e.g: 7:30 PM to 10:00 PM',
                    ),
                    scrollPadding: const EdgeInsets.all(20),
                  ),

                  TextFormField(
                    onSaved: (val) => chamberTwoConsultTimeBangla = val,
                    controller: chamberTwoConsultTimeBanglaController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      labelText: 'Chamber 2 Consultation Time (Bangla)',
                      hintText: 'e.g: সন্ধ্যা ৭ঃ৩০ থেকে রাত ১০ টা',
                    ),
                    scrollPadding: const EdgeInsets.all(20),
                  ),

                  // DateTimeField(
                  //   onSaved: (val) {
                  //     if (val != null) {
                  //       setState(() {
                  //         chamber1ConsultationEndTime = val.toIso8601String();
                  //       });
                  //     }
                  //   },
                  //   format: format,
                  //   // initialValue: DateTime.parse('1970-01-01T17:00:00.000'),
                  //   initialValue: chamber1ConsultationEndTime != null
                  //       ? DateTime.parse(chamber1ConsultationEndTime)
                  //       : null,
                  //   onShowPicker: (context, currentValue) async {
                  //     final time = await showTimePicker(
                  //       context: context,
                  //       initialTime: TimeOfDay.fromDateTime(
                  //           currentValue ?? DateTime.now()),
                  //       builder: (context, child) => MediaQuery(
                  //           data: MediaQuery.of(context)
                  //               .copyWith(alwaysUse24HourFormat: false),
                  //           child: child!),
                  //     );

                  //     return DateTimeField.convert(time);
                  //   },
                  //   decoration: InputDecoration(
                  //       labelText: 'Chamber 1 Consultation End Time'),
                  // ),
                  // DateTimeField(
                  //   format: format,
                  //   onSaved: (val) {
                  //     if (val != null) {
                  //       setState(() {
                  //         chamber2ConsultationStartTime = val.toIso8601String();
                  //       });
                  //     }
                  //   },
                  //   // initialValue: DateTime.parse('1970-01-01T13:00:00.000'),
                  //   initialValue: chamber2ConsultationStartTime != null
                  //       ? DateTime.parse(chamber2ConsultationStartTime)
                  //       : null,
                  //   onShowPicker: (context, currentValue) async {
                  //     final time = await showTimePicker(
                  //       context: context,
                  //       initialTime: TimeOfDay.fromDateTime(
                  //           currentValue ?? DateTime.now()),
                  //       builder: (context, child) => MediaQuery(
                  //           data: MediaQuery.of(context)
                  //               .copyWith(alwaysUse24HourFormat: false),
                  //           child: child!),
                  //     );

                  //     return DateTimeField.convert(time);
                  //   },
                  //   decoration: InputDecoration(
                  //       labelText: 'Chamber 2 Consultation Start Time'),
                  // ),

                  // DateTimeField(
                  //   onSaved: (val) {
                  //     if (val != null) {
                  //       setState(() {
                  //         chamber2ConsultationEndTime = val.toIso8601String();
                  //       });
                  //     }
                  //   },
                  //   format: format,
                  //   // initialValue: DateTime.parse('1970-01-01T17:00:00.000'),
                  //   initialValue: chamber2ConsultationEndTime != null
                  //       ? DateTime.parse(chamber2ConsultationEndTime)
                  //       : null,
                  //   onShowPicker: (context, currentValue) async {
                  //     final time = await showTimePicker(
                  //       context: context,
                  //       initialTime: TimeOfDay.fromDateTime(
                  //           currentValue ?? DateTime.now()),
                  //       builder: (context, child) => MediaQuery(
                  //           data: MediaQuery.of(context)
                  //               .copyWith(alwaysUse24HourFormat: false),
                  //           child: child!),
                  //     );

                  //     return DateTimeField.convert(time);
                  //   },
                  //   decoration: InputDecoration(
                  //       labelText: 'Chamber 2 Consultation End Time'),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Gender',
                          style: TextStyle(color: Color(0xFF949393)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 350,
                        child: DropdownButton<String>(
                          value: selectedGender,
                          isExpanded: true,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                          items: <String>['Male', 'Female']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Date of Birth',
                          style: TextStyle(color: Color(0xFF949393)),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${selectedDate.day.toString()} / ${selectedDate.month.toString()} / ${selectedDate.year.toString()}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  // DateTimeField(
                  //   format: format,
                  //   onSaved: (val) {
                  //     if (val != null) {
                  //       editDoctorConsultationStartTime = val.toIso8601String();
                  //     }
                  //   },
                  //   onShowPicker: (context, currentValue) async {
                  //     final date = await showDatePicker(
                  //         context: context,
                  //         initialDate: selectedDate,
                  //         firstDate: DateTime(1900),
                  //         lastDate: DateTime(2100));
                  //     // context: context,
                  //     // initialTime: TimeOfDay.fromDateTime(
                  //     //     currentValue ?? DateTime.now()),
                  //     // builder: (context, child) => MediaQuery(
                  //     //     data: MediaQuery.of(context)
                  //     //         .copyWith(alwaysUse24HourFormat: false),
                  //     //     child: child),
                  //     // );
                  //     // print();
                  //     // if (time != null) {
                  //     //   setState(() {
                  //     //     editDoctorConsultationStartTime =
                  //     //         DateTimeField.convert(time).toIso8601String();
                  //     //   });
                  //     // }
                  //     // print('start time $editDoctorConsultationStartTime');
                  //     return DateTimeField.convert(date);
                  //   },
                  //   decoration:
                  //       InputDecoration(labelText: 'Consultation Start Time'),
                  // ),

                  SizedBox(
                    height: 10,
                  ),

                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        EdgeInsets.only(top: 1, left: 68, bottom: 5, right: 68),
                    color: kBaseColor,
                    child: Text(
                      'Update Profile Info',
                      style: TextStyle(
                          fontFamily: "Segoe",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: kWhiteShade),
                    ),
                    onPressed: () {
                      _editDoctorProfileKey.currentState!.save();
                      setState(() {
                        isLoading = true;
                      });

                      saveDoctorInfo(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =======================

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [bkash, nagad, rocket];

  static const bkash = MenuItem(text: 'Bkash', icon: Icons.home);
  static const nagad = MenuItem(text: 'Nagad', icon: Icons.share);
  static const rocket = MenuItem(text: 'Rocket', icon: Icons.settings);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black87, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.bkash:
        //Do something
        break;
      case MenuItems.nagad:
        //Do something
        break;
      case MenuItems.rocket:
        //Do something
        break;
    }
  }
}
