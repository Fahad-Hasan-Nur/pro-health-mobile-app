// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';

class ContactUsPatient extends StatefulWidget {
  ContactUsPatient(
      {Key? key,
      this.title,
      required this.patientId,
      required this.patientName,
      required this.patientEmail,
      required this.patientPhone})
      : super(key: key);
  final String? title;
  static String tag = 'ContactUsPatient';
  final patientId;
  final patientName;
  final patientEmail;
  final patientPhone;

  @override
  ContactUsPatientState createState() => new ContactUsPatientState();
}

class ContactUsPatientState extends State<ContactUsPatient> {
  final _contactFormkey = GlobalKey<FormState>();

  PatientApiService patientApiService = PatientApiService();

  String contactName = '';
  String contactPhone = '';
  String contactEmail = '';
  String contactSubject = '';
  String contactMessage = '';

  bool isLoading = false;
  bool sentSuccess = true;
  bool messageSent = false;

  void sendMail(String subject, String text, String name, String phone,
      String email) async {
    String username = 'it.thepharma360@gmail.com';
    String password = 'itd12345';

    final smtpServer = gmail(username, password);

    final equivalentMessage = Message()
      ..from = Address(username, name)
      ..recipients.add(Address('support@prohealth.app'))
      ..subject = subject
      ..text = text
      ..html =
          '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
          <body>

     
          <p><b>Name:</b> $name.</p>
          <p><b>Email:</b> $email</p>
          <p><b>Phone:</b> $phone</p>
          <p><b>Subject:</b> $subject.</p>
          <p><b> Message Description:</b> </p>
          <p>$text</p>

          </body>
          </html>''';

    await send(equivalentMessage, smtpServer);
  }

  sentContactMessage() async {
    var response = await patientApiService.sendContactMessageToDb(
        contactName,
        contactEmail,
        contactPhone,
        contactSubject,
        contactMessage,
        widget.patientId);

    sendMail(
      contactSubject,
      contactMessage,
      contactName,
      contactPhone,
      contactEmail,
    );

    if (response) {
      setState(() {
        isLoading = false;
        messageSent = true;
      });
    } else {
      setState(() {
        isLoading = false;
        messageSent = true;
        sentSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final newAccountPasswordLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/contactpage.png'),
        ),
      ),
    );

    final forgotPasswordTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Contact Us',
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

    final nameField = Padding(
      // height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        keyboardType: TextInputType.streetAddress,
        autofocus: false,
        validator: RequiredValidator(errorText: 'This field is Required'),
        initialValue: widget.patientName,
        onSaved: (val) => contactName = val!,
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          labelText: 'Your Name',
          hintText: 'Your Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kBodyTextColor,
              ),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );

    final emailField = Padding(
      // height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: RequiredValidator(errorText: 'This field is Required'),
        initialValue: widget.patientEmail,
        onSaved: (val) => contactEmail = val!,
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          labelText: 'Your Email',
          hintText: 'Your Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kBodyTextColor,
              ),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );

    final phoneField = Padding(
      // height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        keyboardType: TextInputType.phone,
        autofocus: false,
        initialValue: widget.patientPhone,
        onSaved: (val) => contactPhone = val!,
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          labelText: 'Phone Number',
          hintText: 'Your Phone Number',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kBodyTextColor,
              ),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );

    final subjectField = Padding(
      // height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.streetAddress,
        autofocus: false,
        validator: RequiredValidator(errorText: 'This field is Required'),
        // initialValue: '',
        onSaved: (val) => contactSubject = val!,
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          labelText: 'Subject',
          hintText: 'Subject',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kBodyTextColor,
              ),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );

    final messageField = Padding(
      // height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.streetAddress,
        autofocus: false,
        maxLines: 4,
        validator: RequiredValidator(errorText: 'This field is Required'),
        // initialValue: '',
        onSaved: (val) => contactMessage = val!,
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          labelText: 'Message',
          hintText: 'Message',
          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kBodyTextColor,
              ),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );

    final sendButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_contactFormkey.currentState!.validate()) {
            _contactFormkey.currentState!.save();
            setState(() {
              isLoading = true;
            });
            sentContactMessage();
          }
        },
        padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
        color: kButtonColor,
        child: Text(isLoading ? 'Please Wait..' : 'Send',
            style: TextStyle(
                fontFamily: "Segoe",
                letterSpacing: 0.5,
                fontSize: 18,
                color: kWhiteShadow)),
      ),
    );

    final messageSentText = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            sentSuccess
                ? Icons.check_circle_outline_outlined
                : Icons.error_outline_outlined,
            size: 25,
            color: sentSuccess ? Colors.green : Colors.red,
          ),
          Text(
            sentSuccess
                ? 'Your Message Sent Successfully!'
                : 'Something went wrong, please try again.',
            style: TextStyle(
                fontFamily: 'Segoe',
                color: sentSuccess ? Colors.green : Colors.red,
                letterSpacing: 0.5,
                fontSize: 17,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    final contactForm = Center(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          messageSent
              ? messageSentText
              : SizedBox(
                  height: 30,
                ),
          nameField,
          emailField,
          phoneField,
          subjectField,
          messageField,
          sendButton,
        ],
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
        title: Text('Contact Us',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Form(
        key: _contactFormkey,
        child: Center(
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              newAccountPasswordLogo,
              forgotPasswordTitle,
              verticalDivider,
              contactForm,
            ],
          ),
        ),
      ),
    );
  }
}
