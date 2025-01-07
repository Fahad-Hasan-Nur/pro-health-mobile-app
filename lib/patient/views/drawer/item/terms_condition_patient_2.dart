import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';

class TermsConditionsPatient extends StatefulWidget {
  TermsConditionsPatient({Key? key, this.title}) : super(key: key);
  final String? title;
  static String tag = 'TermsConditionsPatient';
  @override
  TermsConditionsPatientState createState() =>
      new TermsConditionsPatientState();
}

class TermsConditionsPatientState extends State<TermsConditionsPatient> {
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
                        '1.1. You may not register an account if you are under 18 years of age or minimum legal age. If you are under 18 years of age or minimum legal age and wish to use parts of Our Apps and Websites that require an Account, your parent, guardian should register their own “Master” Account and add you.',
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
                        '1.2. When creating an Account, the information you provide must be accurate and complete. If any of your information changes later, you can update it in your Patient Information page in our Apps and Websites. Falsely provided information may lead to suspension of the Account.',
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
                        '1.3. ProHealth require that you choose a strong password for your Account. It is recommended to combine characters in lowercase and uppercase as well as numbers and not to use simple passwords such as: “Password” or “123457”.',
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
                        '1.4. It is your responsibility to keep your password safe. You must not share your password or Account with anyone else. If you believe your Account has or is used without your permission, please contact ProHealth immediately at operations@prohealth.app. ProHealth will not be liable for any unauthorized access to your Account.',
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
                        '1.5. Any personal information you provide or store in your Account will be collected, used, and held in accordance with our data retention policies.',
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
                        '2.2. You may not reproduce, copy, distribute, sell, rent, sub-licence, store, or in any other manner, re-use Content from Our Apps and Websites unless given express written permission to do so by ProHealth.',
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
                        '2.3. Some part of the Apps and Websites may contain advertising and sponsorship, including advertising and sponsorship by ProHealth. Advertisers and Sponsors are responsible for ensuring that material submitted for inclusion on the Website complies with relevant laws and regulations and codes. ProHealth will not be responsible for any error or inaccuracy in advertising and sponsorship material.',
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
                        '3.1 ProHealth will solely handle all types of financial transactions.',
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
                        '3.2 No other payments will be made other than the ProHealth’s integrated payment gateway.',
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
                        '3.3 If a doctor is unable to consult a patient due to any unavoidable circumstances, the user will be refunded.',
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
                  '4. TERMS OF USE',
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
                        '4.1. In order to have a Consultation with a Doctor you must explicitly agree to our current Terms and Conditions, Privacy Policy and Medical Consent at which point we will store that Sensitive Personal Data in your Personal Information and your Consultation record (collectively your ‘Electronic Medical Record’). This Sensitive Personal Data includes your medical history, symptoms, complaints, allergies and medications. At any point you can update your Personal Information, but we will keep a record of those changes if you have had a Consultation.',
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
                        '4.2. You may only use Our Apps and Websites in a manner that is lawful and that complies with all of our provisions.',
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
                        '4.3.You agree that ProHealth may limit, restrict or remove your right to any or all, of its Services, without reason or notice, where in ProHealth’s sole opinion your usage of the ProHealth Services exceeds ProHealth’s current Acceptable Usage Policy, as determined from time to time.',
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
                        '4.4.ProHealth reserves the right to change this Policy as we may deem necessary from time to time or as may be required by law. Any changes will be immediately posted on the App and Website and you will be notified on the website that the policy has been altered. You will be required to confirm that you accept the changes to the Policy prior to using certain services.',
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
                  '5. COMPLAINTS AND FEEDBACK',
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
                  '6.	INDEMNIFICATION',
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
                    EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
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
