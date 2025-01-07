import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/app/app_view.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/controllers/drawer/custom_drawer_doctor_controller.dart';
import 'package:pro_health/doctor/models/doctor_model.dart';
import 'package:pro_health/doctor/models/profile/doctor_profile_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/views/bottombar/profile/profile_doctor_part.dart';
// import 'package:pro_health/doctor/views/auth/signin/signin_doctor.dart';
import 'package:pro_health/doctor/views/dashboard/dashboard_doctor.dart';
import 'package:pro_health/doctor/views/drawer/item/help.dart';
import 'package:pro_health/doctor/views/drawer/item/notification.dart';
import 'package:pro_health/doctor/views/drawer/item/privacy_policy.dart';
import 'package:pro_health/doctor/views/drawer/item/renew.dart';
import 'package:pro_health/doctor/views/drawer/item/reviews.dart';
import 'package:pro_health/doctor/views/drawer/item/settings.dart';
import 'package:pro_health/doctor/views/drawer/item/terms_conditions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'item/about_us.dart';
import 'item/activity_status.dart';
import 'item/contact_us.dart';

// const String _AccountName = 'Prof. Mohammed Hanif';
// const String _AccountEmail = 'doctor101@prohealth.com';

class CustomDrawerDoctor extends StatefulWidget {
  static String tag = 'CustomDrawerDoctor';
  @override
  State<StatefulWidget> createState() {
    return CustomDrawerDoctorState();
  }
}

class CustomDrawerDoctorState extends State<CustomDrawerDoctor> {
  ApiServices apiServices = ApiServices();
  CustomDrawerDoctorController drawerController =
      Get.put(CustomDrawerDoctorController());

  bool showUserDetails = false;

  var doctor = DoctorModel();
  var doctorProfile = DoctorProfileModel();
  var profilePic = '';

  int memberId = 0;

  var doctorPhone = '';

  getDoctorProfile() async {
    memberId = await getDoctorMemberId();
    doctorPhone = await getDoctorPhone();
    var response = await apiServices.getDoctorProfile(memberId);
    if (response.isNotEmpty) {
      setState(() {
        doctorProfile = response[0];
        profilePic = getDoctorProfilePic(doctorProfile.profilePicture);
      });
    }
  }

  @override
  void initState() {
    getDoctorProfile();
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
                      image: (profilePic == '' || profilePic == 'null'
                          ? AssetImage(noImagePath)
                          : NetworkImage(profilePic)) as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                accountName: Text(
                  doctorProfile.doctorName ?? '',
                  style: TextStyle(fontFamily: 'Segoe', fontSize: 16),
                ),
                accountEmail: Text(
                  doctor.email ?? '',
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
                      child: Image.asset('assets/icons/doctor/homed.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(DashboardDoctor.tag);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DashboardDoctor(),
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
                      child: Image.asset('assets/icons/doctor/profiled.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(ProfileDoctor.tag);
                    Get.to(() => ProfileDoctor());
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
                    "Active Status",
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
                      child: Image.asset('assets/icons/doctor/statusd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ActivityStatus(
                          memberId: drawerController.memberId.value,
                          phone: drawerController.doctorPhone.value,
                        ),
                      ),
                    );
                    // Navigator.of(context).pushNamed(ActivityStatus.tag);
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
                      child: Image.asset('assets/icons/doctor/termsd.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(TermsConditions.tag);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TermsConditions(),
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
                    "About Us",
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
                      child: Image.asset('assets/icons/doctor/aboutd.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(AboutUs.tag);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
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
                      child: Image.asset('assets/icons/doctor/contactd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactUs(
                          memberId: drawerController.memberId.value,
                          doctorName:
                              drawerController.doctor.value.doctorName ?? '',
                          doctorEmail:
                              drawerController.doctor.value.email ?? '',
                          doctorPhone: drawerController.doctorPhone.value,
                        ),
                      ),
                    );
                    // Navigator.of(context).pushNamed(ContactUs.tag);
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
                    "Help",
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
                      child: Image.asset('assets/icons/doctor/helpd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Help(),
                      ),
                    );
                    // Navigator.of(context).pushNamed(ContactUs.tag);
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
                      child: Image.asset('assets/icons/doctor/settingsd.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(Settings.tag);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Settings(),
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
                    "Notifications",
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
                      child: Image.asset('assets/icons/doctor/bell.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(Settings.tag);
                    Get.to(() => NotificationView());
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
                      child: Image.asset('assets/icons/doctor/versiond.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.pushNamed(context, "");
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
                      child: Image.asset('assets/icons/doctor/signoutd.png'),
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
                    "Renew",
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
                      child: Image.asset('assets/icons/doctor/renewd.png'),
                    ),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(RenewPage.tag);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RenewPage()));
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
                      child: Image.asset('assets/icons/doctor/reviewsd.png'),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Reviews(
                          memberId: drawerController.memberId.value,
                        ),
                      ),
                    );
                    // Navigator.of(context).pushNamed(Reviews.tag, );
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
          )
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

    Get.offAll(() => AppView());

    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => AppView(),
    //   ),
    //   (route) => false,
    // );
  }
}
