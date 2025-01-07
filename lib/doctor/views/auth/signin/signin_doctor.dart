import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pro_health/doctor/controllers/auth_controller/auth_controller.dart';
import 'package:pro_health/doctor/views/auth/signup/terms_and_conditions.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dashboard/dashboard_doctor.dart';
import 'package:pro_health/doctor/views/auth/signup/create_account_doctor.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/auth/forgot_pass/ForgotPassword.dart';

class SignInDoctor extends StatefulWidget {
  SignInDoctor({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'SignInDoctor';
  @override
  SignInDoctorState createState() => new SignInDoctorState();
}

class SignInDoctorState extends State<SignInDoctor> {
  AuthController authController = AuthController();

  TextEditingController mobileController = TextEditingController();
  TextEditingController bmdcController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _signinFormKey = GlobalKey<FormState>();

  var doctorSigninPhone;
  var doctorSigninBmdcNum;
  var doctorSigninPassword;

  bool isLoading = false;

  String? password;
  bool? showvalue = false;
  late bool _passwordVisible;

  getLoggedInUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isRememberMe = prefs.getBool('rememberMe') ?? false;

    if (isRememberMe) {
      var phone = prefs.getString('doctorPhone');
      var bmdc = prefs.getString('doctorBmdcNum');
      var pass = prefs.getString('doctorPassword');

      setState(() {
        mobileController.text = phone ?? '';
        bmdcController.text = bmdc ?? '';
        passwordController.text = pass ?? '';
      });
    }
  }

  checkDoctorSignin() async {
    if (_signinFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _signinFormKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var signinStatus = await authController.signInDoctor(
          doctorSigninPhone, doctorSigninBmdcNum, doctorSigninPassword);

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
        prefs.setString('doctorPhone', mobileController.text);
        prefs.setString('doctorBmdcNum', bmdcController.text);
        prefs.setString('doctorPassword', passwordController.text);

        prefs.setBool('isLoggedIn', true);
        prefs.setString('loggedInUser', 'doctor');

        if (!signinStatus['agreementAcceptedStatus']) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TermsAndConditions(
                isDoctor: true,
                doctorPhone: doctorSigninPhone,
              ),
            ),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              DashboardDoctor.tag, (Route<dynamic> route) => false);
        }
      }
    }
  }

  @override
  void initState() {
    mobileController.text = '';

    getLoggedInUserInfo();
    super.initState();
    _passwordVisible = false;
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
      padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 40.0),
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
        onSaved: (val) => doctorSigninPhone = val,
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

    final bmdcNo = Padding(
      // height: 70,
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(11)],
        keyboardType: TextInputType.streetAddress,
        autofocus: false,
        validator: RequiredValidator(errorText: 'BMDC Number is Required'),
        controller: bmdcController,
        // initialValue: '',
        onSaved: (val) => doctorSigninBmdcNum = val,
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'BMDC Registration No.',
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
                'assets/icons/doctor/bmdcno.png',
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );

    final passwordField = Padding(
      // height: 70,
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(40)],
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        onChanged: (val) => password = val,
        obscureText: !_passwordVisible,
        validator: RequiredValidator(errorText: 'Password is required'),
        // initialValue: '',
        onSaved: (val) => doctorSigninPassword = val,
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
        onPressed: () => checkDoctorSignin(),
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
                print(showvalue);
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
              child: Image.asset('assets/icons/doctor/forgotpass.png'),
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
              Navigator.of(context).pushNamed(ForgotPassword.tag);
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
          Navigator.of(context).pushNamed(CreateNewAccount.tag);
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
      body: Form(
        key: _signinFormKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              signInLogo,
              signInInstructions,
              phoneNo,
              bmdcNo,
              passwordField,
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
