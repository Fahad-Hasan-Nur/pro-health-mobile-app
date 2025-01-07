import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/views/auth/signin/signin_patient.dart';
import 'package:pro_health/patient/views/dashboard/dashboard_patient.dart';

class TermsAndConditionsPatient extends StatefulWidget {
  TermsAndConditionsPatient({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'TermsAndConditionsPatient';
  @override
  TermsAndConditionsPatientState createState() =>
      new TermsAndConditionsPatientState();
}

class TermsAndConditionsPatientState extends State<TermsAndConditionsPatient> {
  @override
  Widget build(BuildContext context) {
    final newAccountPasswordLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/patient/termsconditions.png'),
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
          'They set out how users may use the application, and what they can and cannot do on the application. '
          'For example, if a user posts offensive or defamatory content on an application, the owner of the app will want'
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
                Navigator.of(context).pushNamed(SignInPatient.tag);
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
              onPressed: () {
                Navigator.of(context).pushNamed(DashboardPatient.tag);
              },
              padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
              color: kButtonColor,
              child: Text('Accept',
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
            forgotPassInstructions,
            signInButton,
          ],
        ),
      ),
    );
  }
}
