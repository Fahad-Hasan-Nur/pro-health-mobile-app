import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/controllers/dashboard_controller.dart';
import 'package:pro_health/doctor/controllers/profile/profile_controller.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/services/auth_service/auth_service.dart';
import 'package:pro_health/doctor/views/auth/signin/signin_doctor.dart';
import 'package:pro_health/doctor/views/auth/signup/terms_and_conditions.dart';
import 'package:pro_health/doctor/views/bottombar/profile/profile_doctor_part.dart';
import 'package:pro_health/doctor/views/bottombar/profile/showValidity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottombar/appointment/appointment_doctor.dart';
import '../bottombar/home/home_doctor.dart';
import '../bottombar/pharma_updates/pharma_updates.dart';
import '../bottombar/prescription/prescriptionPage.dart';

class DashboardDoctor extends StatefulWidget {
  DashboardDoctor({this.agreementAcceptedStatus, this.doctorPhone});
  static String tag = 'DashboardDoctor';
  final agreementAcceptedStatus;
  final doctorPhone;

  @override
  DashboardDoctorState createState() => DashboardDoctorState();
}

class DashboardDoctorState extends State<DashboardDoctor>
    with WidgetsBindingObserver {
  DoctorDashboardController dashboardController =
      Get.put(DoctorDashboardController());
  DoctorProfileController profileController =
      Get.put(DoctorProfileController());

  var automaticActivityStatus;
  var doctorMemberId;
  var phoneNumber;
  var validityDaysLeft = 0;
  var appJoinDate;
  var expireDate;
  var doctorProfilePic;

  AuthService authService = AuthService();
  ApiServices apiServices = ApiServices();
  int selectedIndex = 2;
  List<Widget> listWidgets = [
    PharmaUpdates(),
    Appointment(),
    Home(),
    PrescriptionPage(),
    ProfileDoctor()
  ];

  getValidityDays(var appJoinDate, var expireDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime dateTimeCreatedAt = DateTime.parse(appJoinDate);
    DateTime dateTimeNow = DateTime.now();
    final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;
    var defaultValidityDays = 365;
    var defaultDaysLeft = defaultValidityDays - differenceInDays;

    if (defaultDaysLeft <= 0) {
      DateTime renewDate = DateTime.parse(expireDate);
      DateTime dateTimeNow = DateTime.now();

      final newDifferenceInDays = renewDate.difference(dateTimeNow).inDays;

      setState(() {
        validityDaysLeft = newDifferenceInDays;
      });
    } else {
      setState(() {
        validityDaysLeft = defaultDaysLeft;
      });
    }

    prefs.setInt('ValidityDaysLeft', validityDaysLeft);

    // checkValidity(validityDaysLeft);
  }

  checkValidity(var daysLeft) {
    daysLeft = 4;
    if (daysLeft <= 5 && daysLeft > 0) {
      // show alert that account validity will be expire soon
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ShowValidityPage(daysLeft: daysLeft),
        ),
      );
    } else if (daysLeft <= 0) {
      // Navigate to renew page.
    }
  }

  getDoctorPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phone = prefs.getString('doctorPhone');
    setState(() {
      phoneNumber = phone;
    });
    checkAgreementStatus();
  }

  checkAgreementStatus() async {
    print(phoneNumber);
    if (phoneNumber != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var doctorInfo = await authService.fetchDoctorSigninInfo(phoneNumber);

      if (doctorInfo.length > 0) {
        prefs.setInt('doctorMemberId', doctorInfo[0]!['memberID']);
        setState(() {
          doctorMemberId = doctorInfo[0]!['memberID'];
          doctorProfilePic = doctorInfo[0]!['profilePicture'];
        });

        print(doctorMemberId);
        getExpireDays(doctorMemberId);

        if (!doctorInfo[0]!['agreementAcceptStatus']) {
          getAutomaticActivityStatus();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TermsAndConditions(
                isDoctor: true,
                doctorPhone: phoneNumber,
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
          builder: (BuildContext context) => SignInDoctor(),
        ),
        (route) => false,
      );
    }
  }

  getExpireDays(var doctorMemberId) async {
    var doctorProfile = await apiServices.fetchDoctorProfile(doctorMemberId);
    if (doctorProfile.length > 0) {
      setState(() {
        appJoinDate = doctorProfile[0]['appJoinDate'];
        expireDate = doctorProfile[0]['expireDate'];
      });

      getValidityDays(appJoinDate, expireDate);
    }
  }

  getAutomaticActivityStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    automaticActivityStatus = prefs.getBool('doctorActivityAutomatic');
    if (automaticActivityStatus) {
      await apiServices.setDoctorActiveStatus(true, doctorMemberId);
    }
  }

  updateActivityStatus(var status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isAutomatic = prefs.getBool('doctorActivityAutomatic') ?? false;
    if (isAutomatic) {
      await apiServices.setDoctorActiveStatus(status, doctorMemberId);
    } else
      return;
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    getDoctorPhone();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      updateActivityStatus(false);
    }

    if (state == AppLifecycleState.resumed) {
      updateActivityStatus(true);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: DoubleBackToCloseApp(
          child: listWidgets[selectedIndex],
          snackBar: const SnackBar(
            content: Text('Tap back again to exit the app'),
          ),
        ),
        // body: listWidgets[selectedIndex],
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
                  'assets/icons/doctor/pharmaupdates.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/doctor/pharmaupdatesactive.png',
                  scale: 12.0,
                )),
            TabItem(
                icon: Image.asset(
                  'assets/icons/doctor/appointment.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/doctor/appointmentactive.png',
                  scale: 12.0,
                )),
            TabItem(
                icon: Image.asset(
                  'assets/icons/doctor/home.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/doctor/homeactive.png',
                  scale: 12.0,
                )),
            TabItem(
                icon: Image.asset(
                  'assets/icons/doctor/rx.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/doctor/rxactive.png',
                  scale: 12.0,
                )),
            TabItem(
                icon: Image.asset(
                  'assets/icons/doctor/profile.png',
                  scale: 12.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/doctor/profileactive.png',
                  scale: 12.0,
                )),
          ],
          initialActiveIndex: selectedIndex,
          activeColor: kBaseColor,
          onTap: onItemTapped,
        ));
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
