import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'AboutUs';
  @override
  AboutUsState createState() => new AboutUsState();
}

class AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final aboutUsLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/aboutpage.png'),
        ),
      ),
    );

    final aboutUsTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'About Us',
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

    final descTitle = Expanded(
      child: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 30, bottom: 5, right: 30),
              child: Text(
                'According to WHO, there are an estimated 3.05 physicians per 10,000 '
                'population in Bangladesh; which is very insignificant to serve such a huge '
                'population. On the other hand, there are millions of patients in Bangladesh who '
                'could not reach to the right doctor for their right treatment purposes. '
                'Therefore, we need to adopt with such a technology which will connect the doctors '
                'with the patient.',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  letterSpacing: 0.5,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 30, bottom: 10, right: 30),
              child: Text(
                'ProHealth is one of the service wings of “The Pharma 360” who started '
                'it’s journey since 2016. ProHealth is a healthcare solution provider '
                'through 24/7 instant video calling system and other means with a slogan'
                ' ’Complete Healthcare Solution in Your Pocket’. We have developed ‘ProHealth’ app'
                ' with latest technology and language which is suitable for mobile phone, windows '
                'and iOS. The motto of ProHealth is to ensure complete healthcare solutions in '
                'everyone’s pocket.',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  letterSpacing: 0.5,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kBaseColor,
        centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(
          color: kTitleColor,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('About Us',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            aboutUsLogo,
            aboutUsTitle,
            verticalDivider,
            descTitle,
          ],
        ),
      ),
    );
  }
}
