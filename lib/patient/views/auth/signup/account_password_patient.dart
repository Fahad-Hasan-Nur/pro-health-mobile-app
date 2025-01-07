import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/views/auth/signup/terms_conditions_patient.dart';

class AccountPasswordPatient extends StatefulWidget {
  AccountPasswordPatient({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'AccountPasswordPatient';
  @override
  AccountPasswordPatientState createState() =>
      new AccountPasswordPatientState();
}

class AccountPasswordPatientState extends State<AccountPasswordPatient> {
  late bool _passwordVisible;
  late bool _reTypePasswordVisible;
  @override
  void initState() {
    _passwordVisible = false;
    _reTypePasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/patient/ppasswordpage.png'),
        ),
      ),
    );

    final forgotPasswordTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Account Passowrd',
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
        'Please type new password and re-type password to sign in',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 13.0,
            color: kBodyTextColor,
            fontWeight: FontWeight.w500),
      ),
    );

    final newPassword = Container(
      height: 70,
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        keyboardType: TextInputType.visiblePassword,
        obscureText: !_passwordVisible,
        validator: numberValidator,
        initialValue: '',
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
                'assets/icons/patient/password.png',
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );

    final reTypePassword = Container(
      height: 70,
      padding: EdgeInsets.only(top: 0.0, left: 25, bottom: 20, right: 25),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(11)],
        keyboardType: TextInputType.visiblePassword,
        validator: numberValidator,
        obscureText: !_reTypePasswordVisible,
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
                'assets/icons/patient/retypepassword.png',
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _reTypePasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _reTypePasswordVisible = !_reTypePasswordVisible;
              });
            },
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
          onPressed: () {
            Navigator.of(context).pushNamed(TermsAndConditionsPatient.tag);
          },
          color: kButtonColor,
          child: Text('Sgin in',
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
      body: Center(
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            forgotPasswordLogo,
            forgotPasswordTitle,
            verticalDivider,
            forgotPassInstructions,
            newPassword,
            reTypePassword,
            signInButton,
          ],
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
