// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pro_health/doctor/services/auth_service/auth_service.dart';
import 'package:pro_health/doctor/views/dashboard/dashboard_doctor.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/service/auth/patient_auth_service.dart';
import 'package:pro_health/patient/views/dashboard/dashboard_patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePassword(
      {Key? key,
      this.title,
      this.doctorPhone,
      this.patientPhone,
      required this.isDoctor})
      : super(key: key);
  final String? title;
  static String tag = 'UpdatePassword';
  String? doctorPhone;
  String? patientPhone;
  bool isDoctor;

  @override
  UpdatePasswordState createState() => new UpdatePasswordState();
}

class UpdatePasswordState extends State<UpdatePassword> {
  final _updatePasswordFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  PatientAuthService patientAuthService = PatientAuthService();
  var doctorNewPass;
  bool isLoading = false;
  var doctorDefaultPath = 'assets/doctor-avatar.jpg';
  var patientDefaultPath = 'assets/patientdefault.png';
  String? doctorProfilePicPath = '';

  String? doctorName = '';

  String? patientName = '';
  String? patientProfilePicPath = '';

  fetchDoctorProfile() async {
    var doctorInfo =
        await authService.fetchDoctorSigninInfo(widget.doctorPhone ?? '');

    if (doctorInfo.length > 0) {
      setState(() {
        doctorProfilePicPath =
            getDoctorProfilePic(doctorInfo[0]!['profilePicture'] ?? '');
        doctorName = doctorInfo[0]!['doctorName'] ?? '';
      });
    }
  }

  fetchPatientProfile() async {
    var patientInfo = await patientAuthService
        .fetchPatientSigninInfo(widget.patientPhone.toString());

    if (patientInfo.length > 0) {
      setState(() {
        doctorName = patientInfo[0].patientName ?? '';
        patientProfilePicPath =
            getDoctorProfilePic(patientInfo[0].profilePic ?? '');
      });
    }
  }

  getDoctorProfilePic(String? imgString) {
    if (imgString == null || imgString == '' || imgString == 'null') {
      return null;
    } else {
      var newzero = imgString.substring(0, imgString.indexOf('files'));
      var newfirst = imgString.substring(imgString.indexOf('files') + 6);
      var newsecond = newfirst.substring(0, newfirst.indexOf('-media'));
      var newthird = newfirst.substring(newfirst.indexOf('token'));

      var newfullString =
          newzero + 'files%2F' + newsecond + '?alt=media&' + newthird;

      return newfullString;
    }
  }

  @override
  void initState() {
    // print(widget.patientPhone);
    fetchDoctorProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final updatePasswordLogo = Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blue,
              image: widget.isDoctor
                  ? DecorationImage(
                      image: (doctorProfilePicPath == '' ||
                                  doctorProfilePicPath == 'null'
                              ? AssetImage(doctorDefaultPath)
                              : NetworkImage(doctorProfilePicPath!))
                          as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: (patientProfilePicPath == '' ||
                                  patientProfilePicPath == 'null'
                              ? AssetImage(patientDefaultPath)
                              : NetworkImage(patientProfilePicPath!))
                          as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
            ),
          )
        ],
      ),
    );

    // final updatePasswordLogo = Container(
    //   padding: EdgeInsets.only(top: 20),
    //   child: Hero(
    //     tag: 'hero',
    //     child: CircleAvatar(
    //       radius: 42,
    //       backgroundColor: kBodyTextColor,
    //       child: CircleAvatar(
    //         backgroundColor: kWhiteShade,
    //         radius: 41,
    //         child: CircleAvatar(
    //           backgroundColor: Colors.transparent,
    //           radius: 40.0,
    //           // child: Image.asset('assets/icons/doctor/doctorimg.png'),
    //           child: widget.isDoctor
    //               ? Image.asset(doctorProfilePicPath == ''
    //                   ? defaultPath
    //                   : doctorProfilePicPath!)
    //               : Image.asset(patientProfilePicPath == ''
    //                   ? defaultPath
    //                   : patientProfilePicPath!),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    final doctorTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        doctorName == '' ? 'Hello Doctor' : doctorName!,
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kBaseColor,
            letterSpacing: 0.5,
            fontSize: 20,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );

    final patientTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        patientName == '' ? 'Hello' : patientName!,
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kBaseColor,
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
          RequiredValidator(errorText: 'This field is requried'),
          MinLengthValidator(6,
              errorText: 'Password should be at least 6 character long.'),
        ]),
        onChanged: (val) => doctorNewPass = val,
        // initialValue: '',
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
          } else if (val.trim() != doctorNewPass.trim()) {
            return 'Confirm Password not matched';
          } else {
            return null;
          }
        },
        obscureText: true,
        // initialValue: '',
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
            if (_updatePasswordFormKey.currentState!.validate()) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              _updatePasswordFormKey.currentState!.save();
              var updatePassStatus;
              setState(() {
                isLoading = true;
              });
              if (widget.isDoctor) {
                updatePassStatus = await authService.updateDoctorPassword(
                    widget.doctorPhone, doctorNewPass);
              } else {
                updatePassStatus = await patientAuthService
                    .updatePatientPassword(widget.patientPhone, doctorNewPass);
              }

              if (updatePassStatus) {
                setState(() {
                  isLoading = false;
                });

                if (widget.isDoctor) {
                  prefs.setString('doctorPhone', widget.doctorPhone ?? '');

                  prefs.setBool('isLoggedIn', true);
                  prefs.setString('loggedInUser', 'doctor');

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DashboardDoctor(
                        doctorPhone: widget.doctorPhone,
                      ),
                    ),
                    (route) => false,
                  );
                } else {
                  prefs.setString('patientPhone', widget.patientPhone ?? '');

                  prefs.setBool('isLoggedIn', true);
                  prefs.setString('loggedInUser', 'patient');

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DashboardPatient(),
                    ),
                    (route) => false,
                  );
                }
              } else {
                setState(() {
                  isLoading = false;
                });
                _showMyDialog(context, "Opps!",
                    'Something went wrong!, please try again ');
              }
            }
            // Navigator.of(context).pushNamed(DashboardDoctor.tag);
          },
          color: kButtonColor,
          child: Text(isLoading ? 'Please Wait' : 'Sign in',
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
        key: _updatePasswordFormKey,
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              updatePasswordLogo,
              widget.isDoctor ? doctorTitle : patientTitle,
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
