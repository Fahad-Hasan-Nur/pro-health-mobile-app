import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pro_health/doctor/controllers/auth_controller/auth_controller.dart';
import 'package:pro_health/doctor/services/auth_service/auth_service.dart';
import 'package:pro_health/doctor/views/auth/signup/account_verify_new.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';

class CreateNewAccount extends StatefulWidget {
  CreateNewAccount({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'CreateNewAccount';
  @override
  CreateNewAccountState createState() => new CreateNewAccountState();
}

class CreateNewAccountState extends State<CreateNewAccount> {
  final _singUpFormKey = GlobalKey<FormState>();

  AuthService authService = AuthService();
  AuthController authController = AuthController();

  String? doctorName;
  String? doctorEmail;
  var doctorBmdcNum;
  var doctorPhoneNum;
  var memberId;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final createNewAccountLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/createnewaccount.png'),
        ),
      ),
    );

    final createNewAccountTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Create New Account',
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

    final createNewAccountInstructions = Container(
      padding: EdgeInsets.only(top: 30.0, bottom: 60.0),
      child: Text(
        'Please enter following informations to create account',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 14.0,
            color: kBodyTextColor,
            fontWeight: FontWeight.w500),
      ),
    );

    final name = Padding(
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(40)],
        keyboardType: TextInputType.text,
        validator: MultiValidator([
          MinLengthValidator(3, errorText: 'Minimum 3 character required'),
          RequiredValidator(errorText: 'This field is required'),
        ]),
        initialValue: '',
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Icon(Icons.person_rounded),
        ),
        onSaved: (val) {
          doctorName = val;
        },
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
        validator: MultiValidator([
          RequiredValidator(errorText: 'This field is required'),
        ]),
        initialValue: '',
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Phone Number',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Icon(Icons.phone_android_rounded),
        ),
        // controller: phoneController,
        onSaved: (val) {
          doctorPhoneNum = val;
        },
      ),
    );

    final bmdcNo = Padding(
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(11)],
        keyboardType: TextInputType.streetAddress,
        validator: RequiredValidator(errorText: 'This field is required'),
        initialValue: '',
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'BMDC Registration No.',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Icon(Icons.app_registration),
        ),
        onChanged: (val) {
          doctorBmdcNum = val;
        },
      ),
    );

    final email = Padding(
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(40)],
        keyboardType: TextInputType.emailAddress,
        validator: RequiredValidator(errorText: 'This field is required'),
        initialValue: '',
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'E-mail Address',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Icon(Icons.email_rounded),
        ),
        onChanged: (val) {
          doctorEmail = val;
        },
      ),
    );

    final appValidity = Container(
      padding: EdgeInsets.only(left: 2.0, top: 15.0, right: 2.0, bottom: 10.0),
      child: Text(
        'Paid Version: 365 days',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 14.0,
            color: kBodyTextColor,
            fontWeight: FontWeight.w500),
      ),
    );

    final getOTPButton = Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 0.0, right: 25),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () async {
            if (_singUpFormKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              _singUpFormKey.currentState!.save();
              var doctorCanSignup =
                  await authController.checkDoctorCanRegister(doctorPhoneNum);

              memberId = await authController.getMemberId(doctorPhoneNum);

              var doctorAccountExists =
                  await authController.doctorAccountExists(doctorPhoneNum);
              if (doctorAccountExists) {
                setState(() {
                  isLoading = false;
                });
                showMyDialog(context, 'Account Exists',
                    'An account already exists with this number, please try to login');
              } else {
                if (doctorCanSignup) {
                  var otpStatus = await authService.sendOTP(
                      doctorPhoneNum, "accountCreate");
                  var statusCode = otpStatus['response'].statusCode;
                  var otpCode = otpStatus['otpCode'];
                  print(otpCode);

                  if (statusCode == 200) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewAccountVerify(
                          mobileno: doctorPhoneNum,
                          doctorBmdcNum: doctorBmdcNum,
                          doctorEmail: doctorEmail,
                          doctorName: doctorName,
                          memberId: memberId,
                          otpCode: otpCode,
                          isDoctor: true,
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    showMyDialog(context, "Ops",
                        'Failed to send OTP!, please try again.');
                  }

                  // Navigator.of(context).pushNamed(NewAccountVerify.tag);

                } else {
                  setState(() {
                    isLoading = false;
                  });
                  showMyDialog(context, "Not Eligible",
                      'Your phone number is not registered with us. Please contact to Admin Panel');
                }
              }
            }
          },
          color: kButtonColor,
          child: Text(isLoading ? 'Please Wait..' : 'Get OTP',
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
        key: _singUpFormKey,
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              createNewAccountLogo,
              createNewAccountTitle,
              verticalDivider,
              createNewAccountInstructions,
              name,
              phoneNo,
              bmdcNo,
              email,
              appValidity,
              getOTPButton,
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
