import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/auth/signup/terms_and_conditions.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:pro_health/patient/controllers/patient_auth_controller.dart';
import 'package:pro_health/patient/views/auth/forgot_pass/forgot_password_patient.dart';
import 'package:pro_health/patient/views/auth/signup/create_account_patient.dart';
import 'package:pro_health/patient/views/dashboard/dashboard_patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPatient extends StatefulWidget {
  SignInPatient({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'SignInPatient';
  @override
  SignInPatientState createState() => new SignInPatientState();
}

class SignInPatientState extends State<SignInPatient> {
  bool? showvalue = false;
  late bool _passwordVisible;
  bool isLoading = false;

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _signinFormKey = GlobalKey<FormState>();

  final patientAuthController = PatientAuthController();

  var patientSigninPhone;
  var patientSigninPassword;
  String? password;

  checkPatientSignin() async {
    if (_signinFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _signinFormKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var signinStatus = await patientAuthController.signInPatient(
        patientSigninPhone,
        patientSigninPassword,
      );

      if (!signinStatus['signin']) {
        setState(() {
          isLoading = false;
        });
        showMyDialog(context, "error", signinStatus['error']);
      } else {
        setState(() {
          isLoading = false;
        });
        if (showvalue!) {
          prefs.setBool('rememberMe', true);
        } else {
          prefs.setBool('rememberMe', false);
        }
        prefs.setString('patientPhone', patientSigninPhone);
        prefs.setString('patientPassword', patientSigninPassword);

        prefs.setBool('isLoggedIn', true);
        prefs.setInt('patientId', signinStatus['patientId']);
        prefs.setString('loggedInUser', 'patient');

        if (!signinStatus['agreementAcceptedStatus']) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TermsAndConditions(
                isDoctor: false,
                patientPhone: patientSigninPhone,
              ),
            ),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => DashboardPatient(),
              ),
              (Route<dynamic> route) => false);

          // signinStatus['patientId']
        }
      }
    }
  }

  getLoggedInUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isRememberMe = prefs.getBool('rememberMe') ?? false;

    if (isRememberMe) {
      var phone = prefs.getString('patientPhone') ?? '';
      var pass = prefs.getString('patientPassword') ?? '';

      setState(() {
        mobileController.text = phone;
        passwordController.text = pass;
      });
    }
  }

  @override
  void initState() {
    _passwordVisible = false;
    getLoggedInUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signInLogo = Container(
      padding: EdgeInsets.only(top: 60, bottom: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70.0,
          child: Image.asset('assets/prohealthhlogo.png'),
        ),
      ),
    );

    final signInInstructions = Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 60.0),
      child: Text(
        'Please enter following informations to sign in',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 13.0,
            letterSpacing: 0.5,
            color: kBodyTextColor,
            fontWeight: FontWeight.w500),
      ),
    );

    final phoneNo = Padding(
      // height: 70,
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11)
        ],
        validator: MultiValidator([
          RequiredValidator(errorText: 'Phone number is required'),
          MinLengthValidator(11,
              errorText: 'Phone number length must be eleven character'),
        ]),
        keyboardType: TextInputType.number,
        autofocus: false,
        obscureText: false,
        controller: mobileController,
        // initialValue: '',
        onSaved: (val) => patientSigninPhone = val,
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        autocorrect: true,
        decoration: InputDecoration(
          hintText: 'Phone Number',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: Container(
            height: 10,
            width: 10,
            padding: EdgeInsets.symmetric(
              vertical: 11.0,
            ),
            child: Image(
              image: AssetImage(
                'assets/icons/doctor/phoneno.png',
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );

    final password = Padding(
      // height: 70,
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(40)],
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: !_passwordVisible,
        validator: RequiredValidator(errorText: 'Password is required'),
        // initialValue: '',
        onSaved: (val) => patientSigninPassword = val,
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
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );

    final signInButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () => checkPatientSignin(),
        padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
        color: kButtonColor,
        child: Text(isLoading ? 'Please Wait..' : 'Sign in',
            style: TextStyle(
                fontFamily: "Segoe",
                letterSpacing: 0.5,
                fontSize: 18,
                color: kWhiteShadow)),
      ),
    );

    final rememberForgotLabel = Container(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 30,
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: kBackgroundColor,
              activeColor: kBaseColor,
              value: this.showvalue,
              onChanged: (bool? value) {
                setState(() {
                  this.showvalue = value;
                });
              },
            ),
          ),
          Container(
            child: Text(
              'Remember Me',
              style: TextStyle(
                  fontFamily: 'Segoe', letterSpacing: 0.5, fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: 40,
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/icons/patient/forgotpass.png'),
            ),
          ),
          InkWell(
            highlightColor: kBackgroundColor,
            hoverColor: kBackgroundColor,
            //splashColor: kBackgroundColor,
            child: Container(
              child: Text(
                'Forgotten Password?',
                style: TextStyle(
                    fontFamily: 'Segoe', letterSpacing: 0.5, fontSize: 15),
                textAlign: TextAlign.right,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ForgotPasswordPatient.tag);
            },
          ),
        ],
      ),
    );

    final createAccountButton = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(CreateAccountPatient.tag);
        },
        padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
        color: kButtonColor,
        child: Text('Create new Account',
            style: TextStyle(
                fontFamily: "Segoe",
                letterSpacing: 0.5,
                fontSize: 18,
                color: kWhiteShadow)),
      ),
    );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Form(
          key: _signinFormKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              signInLogo,
              signInInstructions,
              phoneNo,
              password,
              signInButton,
              rememberForgotLabel,
              createAccountButton,
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
