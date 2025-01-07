import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';

class TermsConditions extends StatefulWidget {
  TermsConditions({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'TermsConditions';
  @override
  TermsConditionsState createState() => new TermsConditionsState();
}

class TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    final termsConditionsLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/termsconditionpage.png'),
        ),
      ),
    );

    final termsConditionsTitle = Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Terms and Conditions',
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

    final termsAndConditionsRule = Expanded(
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
                  '1.	REGISTRATION/ACCOUNT',
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
                        '1.1 To register in ProHealth as a Physician first of all you have to purchase our paid app software (ProHealth) with 365 days validity. Once you purchase and filling up the necessary information (Name, Phone number, BMDC Registration Number & email address) to create your account, you will get an OTP password. By accepting terms and conditions, you will be able to use ProHealth.',
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
                        '1.2 You are solely responsible for maintaining the confidentiality of your password and for all activities that occur under your password. You agree to prohibit anyone else from using your password and to immediately notify ProHealth in writing of any unauthorized use of your password or other security concerns of which you become aware.',
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
                        '1.3 ProHealth may contact you by telephone, mail or email to verify your Personal Contact Information. ProHealth reserves the right to request further information from you and you agree to provide such further information, to ensure that you legally completed your registration on the site or subscription to the Services.',
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
                        '2. INTELLECTUAL PROPERTY RIGHTS AND TRADE MARKS',
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
                        '2.1. All logos and trademarks on our Apps and Websites are owned by or licensed to ProHealth. ProHealth hereby reserve all rights to their respective use.',
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
                        '2.2. You may not reproduce, copy, distribute, sell, rent, sub-licence, store, or in any other manner, re-use Content from ProHealth App and Website unless given express written permission to do so by ProHealth.',
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
                        '2.3. Some parts of the App and Website may contain advertising and sponsorship, including advertising and sponsorship by ProHealth. Advertisers and Sponsors are responsible for ensuring that material submitted for inclusion on the Website complies with relevant laws and regulations and codes. ProHealth will not be responsible for any error or inaccuracy in advertising and sponsorship material.',
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
                  '3. PAYMENTS',
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
                        'Doctors can withdraw money from his/her account when A/C balance will be 2,000.00 tk. or more.',
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
                        '3.2Doctors payment will be sent to doctors’ respective bank account or by mobile banking (bKash, Nagad, Rocket).  In case of mobile banking, additional transaction fee may be deducted.',
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
                  '4.	MEMBERSHIP RENEWAL',
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
                        'Membership renewal must be made before the expiration of one’s membership. The renewal fee is the same and payment will be accepted via the same means as before to continue receiving the benefits of the membership program. Members who fail to renew their membership will not be able to access and use the benefits of their premium membership.',
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
                  '5.	TERMS OF USE',
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
                        '5.1Only the Registered doctors having BMDC Registration number can use this app for consultation and learning purposes. If any misdiagnosis happened, the concerned physicians will be liable as a whole.',
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
                        '5.2ProHealth reserves the right to use any information or data for marketing, promotional or research purposes.',
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
                        '5.3ProHealth is not responsible for the ranking Practitioners; this may happens based on external websites and search engines.',
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
                  '6.	COMPLAINTS AND FEEDBACK',
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
                        'If you no longer wish to receive informational or promotional material from us by alerts, texts and similar messages, email and post please contact us at support@prohealth.app.',
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
                  '7. INDEMNIFICATION',
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
                        'You agree to defend, indemnify, and hold us harmless, including our subsidiaries, affiliates, and all of our respective officers, agents, partners, and employees, from and against any loss, damage, liability, claim, or demand, including reasonable attorneys’ fees and expenses, made by any third party due to or arising out of: (1) your contributions, (2) use of the Site, (3) breach of these Terms and Conditions, (4) any breach of your representations and warranties set forth in these Terms and Conditions, (5) your violation of the rights of a third party, including but not limited to intellectual property rights, or (6) any overt harmful act toward any other user of the Site with whom you connected via the Site.',
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
                    EdgeInsets.only(top: 5, left: 10, bottom: 15, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Notwithstanding the foregoing, we reserve the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us, and you agree to cooperate, at your expense, with our defense of such claims. We will use reasonable efforts to notify you of any such claim, action, or proceeding which is subject to this indemnification upon becoming aware of it.',
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
        title: Text('Terms and Conditions',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            termsConditionsLogo,
            termsConditionsTitle,
            verticalDivider,
            termsAndConditionsRule,
          ],
        ),
      ),
    );
  }
}
