import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/views/drawer/custom_drawer_patient.dart';

class DrugIndexPatient extends StatefulWidget {
  static String tag = 'DrugIndexPatient';
  @override
  DrugIndexPatientState createState() => new DrugIndexPatientState();
}

class DrugIndexPatientState extends State<DrugIndexPatient> {
  @override
  Widget build(BuildContext context) {
    final drugIndexLogo = Container(
      padding: EdgeInsets.only(top: 1),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 36.0,
          child: Image.asset('assets/icons/patient/druginfopage.png'),
        ),
      ),
    );

    final drugIndexTitle = Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Drug Index',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kTextLightColor,
            letterSpacing: 0.5,
            fontSize: 18,
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

    return Scaffold(
      drawer: CustomDrawerPatient(),
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: kBaseColor,
        shadowColor: Colors.teal,
        iconTheme: IconThemeData(color: kTitleColor),
        toolbarHeight: 50,
        title: Text(
          'Drug Index',
          style:
              TextStyle(fontFamily: 'Segoe', fontSize: 18, color: kTitleColor),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            drugIndexLogo,
            drugIndexTitle,
            verticalDivider,
          ],
        ),
      ),
    );
  }
}
