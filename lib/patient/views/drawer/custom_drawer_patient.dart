import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/app/app_view.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/views/drawer/item/privacy_policy.dart';
import 'package:pro_health/patient/controllers/patient_drawer_controller.dart';
import 'package:pro_health/patient/models/patient.dart';
import 'package:pro_health/patient/service/auth/patient_auth_service.dart';
import 'package:pro_health/patient/views/dashboard/dashboard_patient.dart';
import 'package:pro_health/patient/views/drawer/item/favorite_patient.dart';
import 'package:pro_health/patient/views/drawer/item/recent_patient.dart';
import 'package:pro_health/patient/views/drawer/item/settings_patient.dart';
import 'package:pro_health/patient/views/drawer/item/profile_patient.dart';
import 'package:pro_health/patient/views/drawer/item/reviews_patient.dart';
import 'package:pro_health/patient/views/drawer/item/terms_condition_patient_2.dart';
// import 'package:pro_health/patient/views/drawer/item/terms_conditions_patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'item/complaint_patient.dart';
import 'item/consultation_history_patient.dart';
import 'item/contactus_patient.dart';

class CustomDrawerPatient extends StatefulWidget {
  static String tag = 'CustomDrawerPatient';
  @override
  State<StatefulWidget> createState() {
    return CustomDrawerPatientState();
  }
}

class CustomDrawerPatientState extends State<CustomDrawerPatient> {
  PatientDrawerController patientDrawerController =
      Get.put(PatientDrawerController(), permanent: true);

  bool showUserDetails = false;

  PatientAuthService patientAuthService = PatientAuthService();

  String phoneNumber = '';
  int patientId = 0;

  PatientModel patient = PatientModel();

  getPatientInfo() async {
    phoneNumber = await getPatientPhone();
    patientId = await getPatientId();
    List<PatientModel> patientInfo =
        await patientAuthService.fetchPatientSigninInfo(phoneNumber);
    if (patientInfo.isNotEmpty) {
      setState(() {
        patient = patientInfo[0];
      });
    }
  }

  @override
  void initState() {
    getPatientInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: kBaseColor,
                ),
                currentAccountPicture: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                    image: DecorationImage(
                      image: (patient.profilePic == '' ||
                              patient.profilePic == null ||
                              patient.profilePic == 'null'
                          ? AssetImage(patientNoImagePath)
                          : NetworkImage((patient.profilePic ?? '').isNotEmpty
                              ? dynamicImageGetApi + patient.profilePic!
                              : '')) as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                accountName: Text(
                  patient.patientName ?? '',
                  style: TextStyle(fontFamily: 'Segoe', fontSize: 16),
                ),
                accountEmail: Text(
                  patient.email ?? '',
                  style: TextStyle(fontFamily: 'Segoe', fontSize: 14),
                ),
                onDetailsPressed: () {
                  setState(() {
                    showUserDetails = !showUserDetails;
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: false,
              children: [
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Home",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/homed.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(DashboardPatient.tag);
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text("Profile",
                      style: TextStyle(
                          color: kBaseColor,
                          fontFamily: 'Segoe',
                          fontSize: 16,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.w700)),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/profiled.png'),
                    ),
                  ),
                  onTap: () {
                    Get.to(() => ProfilePatient());
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => ProfilePatient(),
                    //   ),
                    // );
                    // Navigator.of(context).pushNamed(ProfilePatient.tag);
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Favourite",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/favourited.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FavoritePatient(
                            patientId: patientDrawerController.patientId.value),
                      ),
                    );
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Recent",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/recentd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RecentPatient(
                            patientId: patientDrawerController.patientId.value),
                      ),
                    );
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Consultation History",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/chistoryd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ConsultationHistoryPatient.tag);
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Medicine Remainder",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/remainderd.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed('');
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Terms and Conditions",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/termsd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TermsConditionsPatient()));
                  },
                ),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/doctor/privacyd.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(PrivacyPolicy.tag);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicy(),
                      ),
                    );
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Contact Us",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/contactd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactUsPatient(
                          patientEmail:
                              patientDrawerController.patient.value.email,
                          patientId: patientDrawerController.patientId.value,
                          patientName:
                              patientDrawerController.patient.value.patientName,
                          patientPhone:
                              patientDrawerController.phoneNumber.value,
                        ),
                      ),
                    );
                    // Navigator.of(context).pushNamed(ContactUsPatient.tag);
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Settings",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/settingsd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(SettingsPatient.tag);
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Version 0.8.57+6",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/versiond.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "");
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/signoutd.png'),
                    ),
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        logoutAlertDialog(context),
                  ),
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Complaint",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/complaintd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(ComplaintPatient.tag);
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
                ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  title: Text(
                    "Reviews",
                    style: TextStyle(
                        color: kBaseColor,
                        fontFamily: 'Segoe',
                        fontSize: 16,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: kShadowColor,
                    radius: 13,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 12.0,
                      child: Image.asset('assets/icons/patient/reviewsd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ReviewsPatient(
                            patientId: patientDrawerController.patientId.value),
                      ),
                    );

                    // Navigator.of(context).pushNamed(ReviewsPatient.tag);
                  },
                ),
                Divider(
                    height: 0.0,
                    thickness: 0.5,
                    indent: 18.0,
                    endIndent: 0.0,
                    color: kTitleTextColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget logoutAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Logout?',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Are you sure you want to logout?',
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
              onPressed: () => logout(),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => AppView(),
      ),
      (route) => false,
    );
  }
}
