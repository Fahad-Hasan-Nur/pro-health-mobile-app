import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/auth/signup/account_verify_new.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:pro_health/patient/controllers/patient_auth_controller.dart';
import 'package:pro_health/patient/service/auth/patient_auth_service.dart';

class CreateAccountPatient extends StatefulWidget {
  CreateAccountPatient({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'CreateAccountPatient';
  @override
  CreateAccountPatientState createState() => new CreateAccountPatientState();
}

class CreateAccountPatientState extends State<CreateAccountPatient> {
  final format = DateFormat("dd-MM-yyyy");

  final _singUpFormKey = GlobalKey<FormState>();

  PatientAuthService patientAuthService = PatientAuthService();
  PatientAuthController patientAuthController = PatientAuthController();

  String patientName = '';
  String patientPhone = '';
  var dateOfBirth;
  DateTime selectedDate = DateTime.now();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final createNewAccountLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 42.0,
          child: Image.asset('assets/icons/patient/paccountpage.png'),
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
          patientName = val ?? '';
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
          patientPhone = val ?? '';
        },
      ),
    );

    final dateOfBirth = Container(
      height: 70,
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final DateTime? picked = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (picked != null && picked != selectedDate) {}
          setState(() {
            selectedDate = picked!;
          });
          return picked;
        },
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: "Date of Birth",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Container(
            height: 12,
            width: 12,
            padding: EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Image(
              image: AssetImage(
                'assets/icons/patient/dateofbirth.png',
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
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
              var patientExists = await patientAuthController
                  .checkIfPatientExists(patientPhone);
              print(patientPhone);

              if (patientExists) {
                setState(() {
                  isLoading = false;
                });
                showMyDialog(context, 'Account Exists',
                    'An account already exists with this number, please try to login');
              } else {
                var otpStatus = await patientAuthService.sendOTP(
                    patientPhone, "accountCreate");
                var statusCode = otpStatus['response'].statusCode;
                var otpCode = otpStatus['otpCode'];
                print('otp code $otpCode');

                if (statusCode == 200) {
                  setState(() {
                    isLoading = false;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewAccountVerify(
                        patientName: patientName,
                        patientPhone: patientPhone,
                        dateOfBirth: selectedDate,
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
                      context, "Ops", 'Failed to send OTP!, please try again.');
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
              dateOfBirth,
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
