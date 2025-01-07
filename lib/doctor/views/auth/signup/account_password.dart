// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pro_health/doctor/controllers/auth_controller/auth_controller.dart';
import 'package:pro_health/doctor/services/auth_service/auth_service.dart';
import 'package:pro_health/doctor/views/auth/signup/terms_and_conditions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:pro_health/patient/service/auth/patient_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAccountPassword extends StatefulWidget {
  NewAccountPassword(
      {Key? key,
      this.title,
      this.doctorName,
      this.doctorPhone,
      this.doctorBmdcNum,
      this.doctorEmail,
      this.memberId,
      required this.isDoctor,
      this.patientName,
      this.patientPhone,
      this.dateofBirth})
      : super(key: key);
  String? title;
  String? doctorName;
  String? doctorPhone;
  String? doctorBmdcNum;
  String? doctorEmail;
  int? memberId;
  static String tag = 'NewAccountPassword';
  final bool isDoctor;
  String? patientName;
  String? patientPhone;
  DateTime? dateofBirth;

  @override
  NewAccountPasswordState createState() => new NewAccountPasswordState();
}

class NewAccountPasswordState extends State<NewAccountPassword> {
  var patientDefaultPath = 'assets/patientdefault.png';
  final _resetPassFormKey = GlobalKey<FormState>();

  AuthController authController = AuthController();
  AuthService authService = AuthService();
  PatientAuthService patientAuthService = PatientAuthService();

  String? newPass;
  String? confirmPassword;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.patientPhone);
  }

  @override
  Widget build(BuildContext context) {
    final newAccountPasswordLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/accountpassword.png'),
        ),
      ),
    );

    final forgotPasswordTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Account Password',
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

    final forgotPassInstructions = Container(
      padding: EdgeInsets.only(left: 2.0, top: 30.0, right: 2.0, bottom: 120.0),
      child: Text(
        'Please enter new password and re-type password to sign in',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 13.0,
            color: kBodyTextColor,
            fontWeight: FontWeight.w500),
      ),
    );

    final newPassword = Padding(
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        validator: MultiValidator([
          RequiredValidator(errorText: 'This field is required'),
          MinLengthValidator(6,
              errorText: 'Password must be at least 6 character long'),
        ]),
        initialValue: '',
        onChanged: (val) => newPass = val,
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Container(
            height: 12,
            width: 12,
            padding: EdgeInsets.symmetric(
              vertical: 11.0,
            ),
            child: Image(
              image: AssetImage(
                'assets/icons/doctor/password.png',
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );

    final reTypePassword = Padding(
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(11)],
        keyboardType: TextInputType.visiblePassword,
        validator: (val) {
          if (val!.isEmpty) {
            return 'Confirm password is required';
          } else if (val.trim() != newPass!.trim()) {
            return 'Confirm Password not matched';
          } else {
            return null;
          }
        },
        obscureText: true,
        initialValue: '',
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Re-Type Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Container(
            height: 12,
            width: 12,
            padding: EdgeInsets.symmetric(
              vertical: 11.0,
            ),
            child: Image(
              image: AssetImage(
                'assets/icons/doctor/retypepassword.png',
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );

    final signInButton = Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () async {
            if (_resetPassFormKey.currentState!.validate()) {
              bool signupSuccess = false;
              SharedPreferences prefs = await SharedPreferences.getInstance();

              setState(() {
                isLoading = true;
              });

              // authController.saveDoctorInfo(widget.memberId);
              if (widget.isDoctor) {
                signupSuccess = await authService.saveDoctorSignupInfoToDb(
                  widget.memberId,
                  widget.doctorPhone,
                  widget.doctorName,
                  widget.doctorEmail,
                  widget.doctorBmdcNum,
                  newPass,
                );
              } else {
                signupSuccess = await patientAuthService.signupPatient(
                  widget.patientName ?? '',
                  widget.patientPhone ?? '',
                  widget.dateofBirth,
                  newPass ?? '',
                );
              }

              if (signupSuccess) {
                setState(() {
                  isLoading = false;
                });

                if (widget.isDoctor) {
                  prefs.setString('doctorPhone', widget.doctorPhone ?? '');
                  prefs.setString('doctorBmdcNum', widget.doctorBmdcNum ?? '');

                  prefs.setBool('isLoggedIn', true);
                  prefs.setString('loggedInUser', 'doctor');

                  Get.offAll(
                    () => TermsAndConditions(
                      isDoctor: true,
                      doctorPhone: widget.doctorPhone,
                    ),
                  );

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => TermsAndConditions(
                  //       isDoctor: true,
                  //       doctorPhone: widget.doctorPhone,
                  //     ),
                  //   ),
                  //   (route) => false,
                  // );
                } else {
                  prefs.setString('patientPhone', widget.doctorPhone ?? '');
                  prefs.setString('patientPassword', newPass ?? '');
                  prefs.setBool('isLoggedIn', true);
                  prefs.setString('loggedInUser', 'patient');

                  Get.offAll(
                    () => TermsAndConditions(
                      isDoctor: false,
                      patientPhone: widget.patientPhone,
                    ),
                  );

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => TermsAndConditions(
                  //       isDoctor: false,
                  //       patientPhone: widget.patientPhone,
                  //     ),
                  //   ),
                  //   (route) => false,
                  // );
                }
              } else {
                setState(() {
                  isLoading = false;
                });
                showMyDialog(context, "Opps!",
                    'Something went wrong!, please try again later.');
              }
              //
            }
            // Navigator.of(context).pushNamed(TermsAndConditions.tag);
          },
          color: kButtonColor,
          child: Text(isLoading ? 'Please Wait..' : 'Sign in',
              style: TextStyle(
                  fontFamily: "Segoe",
                  letterSpacing: 0.5,
                  fontSize: 18,
                  color: kWhiteShadow)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Form(
        key: _resetPassFormKey,
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              newAccountPasswordLogo,
              forgotPasswordTitle,
              verticalDivider,
              forgotPassInstructions,
              newPassword,
              reTypePassword,
              signInButton,
            ],
          ),
        ),
      ),
    );
  }
}

String? numberValidator(String? value) {
  if (value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if (n == null) {
    return '"$value" is not a valid number!';
  }
  return null;
}
