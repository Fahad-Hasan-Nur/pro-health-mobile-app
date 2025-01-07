import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/auth/signin/signin_doctor.dart';
import 'package:pro_health/patient/views/auth/signin/signin_patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppView extends StatefulWidget {
  AppView({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'AppView';
  @override
  AppViewState createState() => new AppViewState();
}

class AppViewState extends State<AppView> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignInDoctor()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenLogo = Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70.0,
          child: Image.asset('assets/prohealthhlogo.png'),
        ),
      ),
    );

    final signInDoctorCard = Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 32),
      child: Container(
        height: 80,
        child: MaterialButton(
          padding:
              EdgeInsets.only(left: 4.0, top: 2.0, right: 4.0, bottom: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          color: kDashBoxColor,
          elevation: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/doctorsignin.png'),
                ),
                title: Text(
                  'Sign In as Doctor',
                  style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 20.0,
                      letterSpacing: 0.5,
                      color: kBodyTextColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(
                  'Connecting Patients for consultation',
                  style: TextStyle(
                      fontFamily: 'Segoe',
                      fontStyle: FontStyle.italic,
                      color: kTextLightColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SignInDoctor(),
              ),
            );
          },
        ),
      ),
    );

    final signInPatientCard = Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 32),
      child: Container(
        height: 80,
        child: MaterialButton(
          padding:
              EdgeInsets.only(left: 4.0, top: 2.0, right: 4.0, bottom: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          color: kDashBoxColor,
          elevation: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30.0,
                  backgroundImage: AssetImage(
                      'assets/patientsignin.png'), // no matter how big it is, it won't overflow
                ),
                title: Text(
                  'Sign In as Patient',
                  style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 20.0,
                      letterSpacing: 0.5,
                      color: kBodyTextColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(
                  'Connecting Doctors for consultation',
                  style: TextStyle(
                      fontFamily: 'Segoe',
                      fontStyle: FontStyle.italic,
                      color: kTextLightColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SignInPatient(),
              ),
            );
          },
        ),
      ),
    );

    final sponsor = Container(
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 0.0, top: 50.0, right: 0.0, bottom: 0.0),
            child: Text(
              'Sponsored by',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 15.0,
                  letterSpacing: 0.5,
                  color: kBodyTextColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 150),
            child: Image.asset('assets/logo.png'),
          )
        ],
      ),
    );

    final developer = Container(
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: 0.0, top: 20.0, right: 0.0, bottom: 0.0),
            child: Text(
              'Developed by',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 15.0,
                  letterSpacing: 0.5,
                  color: kBodyTextColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 125),
            child: Image.asset('assets/pharmalogo.png'),
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: DoubleBackToCloseApp(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              homeScreenLogo,
              signInDoctorCard,
              signInPatientCard,
              sponsor,
              developer,
            ],
          ),
        ),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),
    );
  }
}
