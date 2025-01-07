// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pro_health/app/app_view.dart';
import 'package:pro_health/doctor/services/auth_service/auth_service.dart';
import 'package:pro_health/doctor/views/dashboard/dashboard_doctor.dart';
import 'package:pro_health/doctor/views/auth/signin/signin_doctor.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/service/auth/patient_auth_service.dart';
import 'package:pro_health/patient/views/auth/signin/signin_patient.dart';
import 'package:pro_health/patient/views/dashboard/dashboard_patient.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class TermsAndConditions extends StatefulWidget {
  TermsAndConditions({
    Key? key,
    this.title,
    required this.isDoctor,
    this.doctorPhone,
    this.patientPhone,
  }) : super(key: key);
  final String? title;
  final bool isDoctor;
  String? doctorPhone;
  String? patientPhone;

  static String tag = 'TermsAndConditions';
  @override
  TermsAndConditionsState createState() =>
      new TermsAndConditionsState(isDoctor: this.isDoctor);
}

class TermsAndConditionsState extends State<TermsAndConditions> {
  final bool isDoctor;
  TermsAndConditionsState({required this.isDoctor});

  AuthService authService = AuthService();
  final patienAuthService = PatientAuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final newAccountPasswordLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/termsconditions.png'),
        ),
      ),
    );

    final forgotPasswordTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Terms and Conditions',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kTextLightColor,
            letterSpacing: 0.5,
            fontSize: 20,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );

    final verticalDivider = Container(
      child: Divider(
        color: Colors.black,
        height: 0.0,
        thickness: 0.5,
        indent: 0.0,
        endIndent: 0.0,
      ),
    );

    final forgotPassInstructions = Expanded(
      child: Container(
        height: 450,
        padding:
            EdgeInsets.only(left: 25.0, top: 30.0, right: 25.0, bottom: 20.0),
        child: Text(
          'These terms and conditions are a set of rules about use of an application. '
          'They set out how users may use the site or application, and what they can and cannot do on the application. '
          'For example, if a user posts offensive or defamatory content on a website, the owner of the app will want'
          ' to have terms and conditions to fall back on which clearly state that the owner of the app does not permit '
          'or take responsibility for that offensive content, and that any liability (such as a defamation claim) '
          'should therefore sit with the user.\nIn addition, the owner of the site may want to have the ability to '
          'terminate the user\'s account - and this also will need to be explained in the terms and conditions.',
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 19.0,
              color: kBodyTextColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );

    final signInButton = Container(
      child: Row(
        children: [
          Container(
            width: 195,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () {
                if (isDoctor) {
                  Get.offAll(() => SignInDoctor());
                } else {
                  Get.offAll(() => SignInPatient());
                }
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => isDoctor ? SignInDoctor() : SignInPatient(),
                //   ),
                // );
              },
              padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
              color: Colors.red,
              child: Text('Decline',
                  style: TextStyle(
                      fontFamily: "Segoe",
                      letterSpacing: 0.5,
                      fontSize: 18,
                      color: kWhiteShadow)),
            ),
          ),
          Container(
            width: 195,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () async {
                bool agreementStatus;
                setState(() {
                  isLoading = true;
                });

                // updatePatientAgreemntStatus;
                if (isDoctor) {
                  agreementStatus = await authService
                      .updateDoctorAgreemntStatus(widget.doctorPhone);
                } else {
                  agreementStatus =
                      await patienAuthService.updatePatientAgreemntStatus(
                    widget.patientPhone.toString(),
                  );
                }

                if (agreementStatus) {
                  setState(() {
                    isLoading = false;
                  });
                  if (isDoctor) {
                    Get.offAll(
                      () => DashboardDoctor(
                        agreementAcceptedStatus: true,
                        doctorPhone: widget.doctorPhone,
                      ),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => DashboardDoctor(
                    //       agreementAcceptedStatus: true,
                    //       doctorPhone: widget.doctorPhone,
                    //     ),
                    //   ),
                    // );
                  } else {
                    Get.offAll(() => DashboardPatient());
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => DashboardPatient(),
                    //   ),
                    // );
                  }
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  _showMyDialog(context, "Opps!",
                      'Something went wrong!, please try again.');
                }
              },
              padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
              color: kButtonColor,
              child: Text(isLoading ? 'Please Wait..' : 'Accept',
                  style: TextStyle(
                      fontFamily: "Segoe",
                      letterSpacing: 0.5,
                      fontSize: 18,
                      color: kWhiteShadow)),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            newAccountPasswordLogo,
            forgotPasswordTitle,
            verticalDivider,
            Row(
              children: [
                forgotPassInstructions,
              ],
            ),
            signInButton,
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(
      BuildContext context, String title, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // false= user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
