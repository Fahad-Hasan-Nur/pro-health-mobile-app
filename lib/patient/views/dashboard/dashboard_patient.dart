import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/call/views/pickup/pickup_layout_patient.dart';
import 'package:pro_health/doctor/views/auth/signup/terms_and_conditions.dart';
import 'package:pro_health/patient/controllers/dashboard_controller.dart';
import 'package:pro_health/patient/controllers/profile_controller.dart';
import 'package:pro_health/patient/service/auth/patient_auth_service.dart';
import 'package:pro_health/patient/views/auth/signin/signin_patient.dart';
import 'package:pro_health/patient/views/bottombar/appointment/appointment_patient.dart';
import 'package:pro_health/patient/views/bottombar/drug_info/drug_index_patient.dart';
import 'package:pro_health/patient/views/bottombar/home/home_patient.dart';
import 'package:pro_health/patient/views/bottombar/message/message_patient.dart';
import 'package:pro_health/patient/views/bottombar/profile/profile_patient2.dart';
// import 'package:pro_health/patient/views/drawer/item/profile_patient.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DashboardPatient extends StatefulWidget {
  static String tag = 'DashboardPatient';

  @override
  DashboardPatientState createState() => DashboardPatientState();
}

class DashboardPatientState extends State<DashboardPatient> {
  DashboardController dashboardController = Get.put(DashboardController());
  PatientProfileController profileController =
      Get.put(PatientProfileController());

  int selectedIndex = 2;

  PatientAuthService patientAuthService = PatientAuthService();
  int patientId = 0;
  bool agreementStatus = false;
  var phoneNumber;

  List<Widget> listWidgets = [
    DrugIndexPatient(),
    AppointmentPatient(),
    HomePatient(),
    MessagePatient(),
    ProfilePatient(),
  ];

  checkAgreementStatus() async {
    await Future.delayed(Duration(milliseconds: 300));
    print('phone $phoneNumber');
    if (phoneNumber != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var patientInfo =
          await patientAuthService.fetchPatientSigninInfo(phoneNumber);

      if (patientInfo.length > 0) {
        prefs.setInt('patientId', patientInfo[0].patientID ?? 0);
        setState(() {
          patientId = patientInfo[0].patientID ?? 0;
          agreementStatus = patientInfo[0].agreementAcceptStatus ?? false;
        });
        print('agreement status = $agreementStatus');
        if (!agreementStatus) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TermsAndConditions(
                isDoctor: false,
                patientPhone: phoneNumber,
              ),
            ),
            (route) => false,
          );
        }
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignInPatient(),
        ),
        (route) => false,
      );
    }
  }

  getPatientPhoneNumber() async {
    String phone = await getPatientPhone();
    setState(() {
      phoneNumber = phone;
    });
    checkAgreementStatus();
  }

  @override
  void initState() {
    getPatientPhoneNumber();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(milliseconds: 600), () {
    //   checkAgreementStatus();
    // });
    return PickupLayoutPatient(
      scaffold: Scaffold(
        backgroundColor: kBackgroundColor,
        body: DoubleBackToCloseApp(
          child: listWidgets[selectedIndex],
          snackBar: const SnackBar(
            content: Text('Tap back again to exit the app'),
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: kBaseColor,
          color: Colors.white,
          height: 45,
          top: -15,
          curveSize: 80,
          style: TabStyle.reactCircle,
          items: [
            TabItem(
                icon: Image.asset(
                  'assets/icons/patient/druginfo.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/patient/druginfo_active.png',
                  scale: 12.0,
                )),
            TabItem(
                icon: Image.asset(
                  'assets/icons/patient/appointment.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/patient/appointment_active.png',
                  scale: 12.0,
                )),
            TabItem(
                icon: Image.asset(
                  'assets/icons/patient/home.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/patient/home_active.png',
                  scale: 12.0,
                )),
            TabItem(
                icon: Image.asset(
                  'assets/icons/patient/message.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/patient/message_active.png',
                  scale: 12.0,
                )),
            TabItem(
                icon: Image.asset(
                  'assets/icons/patient/profile.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/patient/profile_active.png',
                  scale: 12.0,
                )),
          ],
          initialActiveIndex: selectedIndex,
          activeColor: kBaseColor,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
