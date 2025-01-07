import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'PrivacyPolicy';
  @override
  PrivacyPolicyState createState() => new PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    final privacyPolicyLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/privacypage.png'),
        ),
      ),
    );

    final privacyPolicyTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Privacy Policy',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kBaseColor,
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

    final privacyPolicyDesc = Expanded(
      child: SingleChildScrollView(
        child: Card(
          elevation: 1.0,
          color: kBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListBody(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 20),
                child: Text(
                  'HOW WE PROTECT YOU',
                  style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Your identity is very private and your information is stored in secure operating system that are not available to the public or all ProHealth staffs. All of the ProHealth staff and affiliates are dedicated with a view to maintaining and upholding your privacy and security and are fully aware of our privacy and security policies.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'DATA STORAGE AND RETENTION',
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'ProHealth may retain and use your information if necessary, to comply with legal obligations, resolve dispute resolutions, prevent fraud, enforce agreements or as otherwise permitted by applicable law.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Your account is protected by a password for your privacy and security. You must prevent unauthorized access to your account and Personal Information by selecting and protecting your password and/or other sign-on mechanism appropriately, and limiting access to your computer or device and browser by signing off after you have finished accessing your account.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'THE PERSONAL INFORMATION WE COLLECT OR MAINTAIN MAY INCLUDE:',
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '1. For patients: Your name, age, email address, password, Gender, and other registration information.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '2. Health Information that you provide us, which may include information or records relating to your medical or health history, health status and laboratory testing results, diagnostic images, and other health related information.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '3. Health information about you prepared or obtained by the Healthcare Professionals(s) who provide clinical services through the Site such as medical and therapy records, treatment and examination notes, and other health related information.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '4. Information about the computer or mobile device you are using, such as what Internet browser you use, the kind of computer or mobile device you use, and other information about how you use the Site.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '5. For doctors: Full name, age, BMDC number, Specialty, Gender, Professional Qualification, Experience Information, Chamber Information. This information will be publicly accessible in our app and website. We may also collect confidential personal data such as: NID/Passport number, email address, Mobile number. This information will be only accessible to our internal members of staff. Sensitive data such as passwords will not be accessible by anyone.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '6. Other information you input into the Site or related services.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'We may use your Personal Information for the following purposes (subject to the restrictions relating to the use of Health Information):',
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '1. To provide you with the Services.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '2. To improve healthcare quality through the performance of quality reviews and similar activities.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '3. To create De-identified Information such as aggregate statistics relating to the use of the Services.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '4. To notify you when Site updates are available.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '5. To market and promote the Site and the Services to you.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '6. To fulfill any other purpose for which you provide us Personal Information.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '7. For the purposes described in Section I relating to the use of Health Information.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '8. For any other purpose for which you give us authorization.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 15),
                child: Text(
                  'COOKIES',
                  style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Cookies are small text files that are placed on your computer by websites that you visit. They are widely used in order to make websites work, or work more efficiently, as well as to provide information to the owners of the site.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 15),
                child: Text(
                  'ANY UPDATE OR CHANGES',
                  style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'When ProHealth makes any update, changes or further development in this privacy policy, you will be notified immediately.',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            letterSpacing: 0.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        title: Text('Privacy Policy',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            privacyPolicyLogo,
            privacyPolicyTitle,
            verticalDivider,
            privacyPolicyDesc,
          ],
        ),
      ),
    );
  }
}
