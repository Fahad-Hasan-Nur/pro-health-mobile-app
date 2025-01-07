import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/auth/forgot_pass/AccountVerify.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:pro_health/patient/controllers/patient_auth_controller.dart';
import 'package:pro_health/patient/service/auth/patient_auth_service.dart';

class ForgotPasswordPatient extends StatefulWidget {
  ForgotPasswordPatient({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'ForgotPasswordPatient';
  @override
  ForgotPasswordPatientState createState() => new ForgotPasswordPatientState();
}

class ForgotPasswordPatientState extends State<ForgotPasswordPatient> {
  PatientAuthController patientAuthController = PatientAuthController();
  PatientAuthService patientAuthService = PatientAuthService();
  final _forgotPassFormKey = GlobalKey<FormState>();

  var phoneNumber;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final forgotPasswordLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/patient/forgotpassword.png'),
        ),
      ),
    );

    final forgotPasswordTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Forgot Password',
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
        'Please enter your previous registered phone number',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 13.0,
            color: kBodyTextColor,
            fontWeight: FontWeight.w500),
      ),
    );

    final phoneNo = Padding(
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11)
        ],
        keyboardType: TextInputType.number,
        validator: RequiredValidator(errorText: 'Phone Number is required'),
        initialValue: '',
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Phone Number',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Icon(Icons.phone_android_rounded),
        ),
        onSaved: (val) => phoneNumber = val,
      ),
    );

    final getCodeButton = Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () async {
            if (_forgotPassFormKey.currentState!.validate()) {
              _forgotPassFormKey.currentState!.save();

              setState(() {
                isLoading = true;
              });

              var otpStatus =
                  await patientAuthController.verifyPhoneToSendOtp(phoneNumber);
              if (!otpStatus['sendOtp']) {
                setState(() {
                  isLoading = false;
                });
                showMyDialog(context, "error", otpStatus['error']);
              } else {
                var otpStatus =
                    await patientAuthService.sendOTP(phoneNumber, "resetPass");
                var statusCode = otpStatus['response'].statusCode;
                var otpCode = otpStatus['otpCode'];
                // print(otpCode);

                if (statusCode == 200) {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AccountVerify(
                        mobileno: phoneNumber,
                        otpCode: otpCode,
                        isDoctor: false,
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  showMyDialog(
                      context, "Ops", 'Failed to send OTP, please try again.');
                }

                // Send otp code here.
                // After sending check and then send usr to account verify page to create new password.
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => AccountVerify(
                //       mobileno: phoneNumber,
                //     ),
                //   ),
                // );
              }
            }

            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (_) => AccountVerify(
            //           mobileno: '',
            //         )));
          },
          color: kButtonColor,
          child: Text(isLoading ? 'Please wait' : 'Get Code',
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
        key: _forgotPassFormKey,
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              forgotPasswordLogo,
              forgotPasswordTitle,
              verticalDivider,
              forgotPassInstructions,
              phoneNo,
              getCodeButton,
            ],
          ),
        ),
      ),
    );
  }
}
