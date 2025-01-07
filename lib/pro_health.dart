// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/configs/routes.dart';
import 'package:pro_health/app/app_view.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/dashboard/dashboard_doctor.dart';
import 'package:pro_health/patient/views/dashboard/dashboard_patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProHealth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pro Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: kBaseColor,
        fontFamily: 'Nunito',
      ),
      home: CheckLoginPage(),
      routes: routes,
    );
  }
}

class CheckLoginPage extends StatefulWidget {
  const CheckLoginPage({Key? key}) : super(key: key);

  @override
  _CheckLoginPageState createState() => _CheckLoginPageState();
}

class _CheckLoginPageState extends State<CheckLoginPage> {
  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isLoggedIn') == null) {
      prefs.setBool("isLoggedIn", false);
    }

    var status = prefs.getBool('isLoggedIn') ?? true;
    var loggedInUser = prefs.getString('loggedInUser');
    // print(status);
    // print(loggedInUser);
    if (status && loggedInUser == 'doctor') {
      Get.offAll(() => DashboardDoctor());
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (context) => DashboardDoctor(),
      //   ),
      //   (Route<dynamic> route) => false,
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => DashboardDoctor(),
      //   ),
      // );
    } else if (status && loggedInUser == 'patient') {
      Get.offAll(() => DashboardPatient());
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (context) => ,
      //   ),
      //   (Route<dynamic> route) => false,
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => DashboardPatient(),
      //   ),
      // );
    } else {
      Get.offAll(() => AppView());
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (context) => AppView(),
      //   ),
      //   (Route<dynamic> route) => false,
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => AppView(),
      //   ),
      // );
    }
    // print('checking');
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          child: Image.asset('assets/splash-logo.png'),
        ),
      ),
    );
  }
}
