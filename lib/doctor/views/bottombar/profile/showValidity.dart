import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/dashboard/dashboard_doctor.dart';
import 'package:pro_health/doctor/views/drawer/item/contact_us.dart';

class ShowValidityPage extends StatefulWidget {
  final daysLeft;
  const ShowValidityPage({Key? key, this.daysLeft}) : super(key: key);

  @override
  _ShowValidityPageState createState() => _ShowValidityPageState();
}

class _ShowValidityPageState extends State<ShowValidityPage> {
  @override
  Widget build(BuildContext context) {
    final newAccountPasswordLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/termsconditions.png'),
        ),
      ),
    );

    final forgotPasswordTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Account Expiring Soon',
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
        height: 250,
        padding:
            EdgeInsets.only(left: 25.0, top: 30.0, right: 25.0, bottom: 20.0),
        child: Text(
          'You Subscription will be expired within ${widget.daysLeft} days, Please contact to Admin Panel to renew your accoun subscription.',
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 19.0,
              color: kBodyTextColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );

    final buttons = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ContactUs(),
                  ),
                );
              },
              padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
              color: kButtonColor,
              child: Text(
                'Go to Contact Page',
                style: TextStyle(
                    fontFamily: "Segoe",
                    letterSpacing: 0.5,
                    fontSize: 18,
                    color: kWhiteShadow),
              ),
            ),
          ),
          Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DashboardDoctor(
                      agreementAcceptedStatus: true,
                    ),
                  ),
                );
              },
              padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
              color: Colors.red,
              child: Text(
                'Ok, I understand',
                style: TextStyle(
                    fontFamily: "Segoe",
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kWhiteShadow),
              ),
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
            Row(
              children: [
                forgotPassInstructions,
              ],
            ),
            buttons,
          ],
        ),
      ),
    );
  }
}
