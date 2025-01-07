// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
import 'package:pro_health/patient/service/dashboard/profile_service.dart';

class ComplaintPatient extends StatefulWidget {
  static String tag = 'ComplaintPatient';
  @override
  ComplaintPatientState createState() => new ComplaintPatientState();
}

class ComplaintPatientState extends State<ComplaintPatient> {
  PatientApiService patientApiService = PatientApiService();
  PatientProfileService patientProfileService = PatientProfileService();
  final complaintController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _complaintFormKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String phone = '';

  bool isLoading = false;

  List<Map<String, dynamic>> complaints = [];

  getPatientComplaints() async {
    if (complaints.isNotEmpty) {
      setState(() {
        complaints.clear();
      });
    }
    int patientId = await getPatientId();
    var response = await patientApiService.fetchPatientComplaints(patientId);
    if (response.isNotEmpty) {
      List<Map<String, dynamic>> reversedResponse = [];
      reversedResponse = response.reversed.toList();
      setState(() {
        complaints.addAll(reversedResponse);
      });
    }
  }

  getPatientInfo() async {
    int patientId = await getPatientId();
    var patient = await patientProfileService.getPatientProfileInfo(patientId);
    setState(() {
      name = patient.patientName ?? '';
      emailController.text = patient.email ?? '';
      phone = patient.mobile ?? '';
    });
  }

  void sendMail(String problem, String name, String phone, String email) async {
    String username = 'it.thepharma360@gmail.com';
    String password = 'itd12345';

    final smtpServer = gmail(username, password);

    final equivalentMessage = Message()
      ..from = Address(username, name)
      ..recipients.add(Address('support@prohealth.app'))
      ..subject = 'complaint from patient $name'
      ..text = problem
      ..html =
          '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
          <body>

     
          <p><b>Name:</b> $name.</p>
          <p><b>Email:</b> $email</p>
          <p><b>Phone:</b> $phone</p>
          <p><b>Subject:</b> Complaint from patient $name.</p>
          <p><b> Message Description:</b> </p>
          <p>$problem</p>

          </body>
          </html>''';

    await send(equivalentMessage, smtpServer);
  }

  saveComplaint() async {
    setState(() {
      isLoading = true;
    });
    int patientId = await getPatientId();
    Map<String, dynamic> complaintMap = {};
    complaintMap['patientId'] = patientId;
    complaintMap['problem'] = complaintController.text;
    complaintMap['date'] = getTimeNow();
    complaintMap['email'] = emailController.text;
    complaintMap['phone'] = phone;

    var complainSaved = await patientApiService.saveComplaint(complaintMap);

    sendMail(
      complaintController.text,
      name,
      phone,
      emailController.text,
    );
    if (complainSaved) {
      setState(() {
        isLoading = false;
      });
      getPatientComplaints();
      showToast(
        "✔ complain was successfully sent!",
        position: ToastPosition.center,
        duration: Duration(seconds: 3),
        backgroundColor: kTitleColor,
        radius: 22.0,
        textAlign: TextAlign.center,
        textStyle: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'Segoe',
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: kBaseColor),
        textPadding: EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 8),
        animationBuilder: Miui10AnimBuilder(),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Opps! something went wrong, please try again later'),
        ),
      );
    }
  }

  @override
  void initState() {
    getPatientInfo();
    getPatientComplaints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final complaintLogo = Padding(
      padding: EdgeInsets.only(top: 2),
      child: Container(
        width: 80.00,
        height: 80.00,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: ExactAssetImage('assets/icons/patient/complaintpage.png'),
          fit: BoxFit.fitHeight,
        )),
      ),
    );
    final complaintTitle = Container(
      width: 250.00,
      height: 30,
      child: Text(
        'Complaint',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kTextLightColor,
            letterSpacing: 0.5,
            fontSize: 20,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
    final descTextfield = Container(
      padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        autofocus: false,
        maxLines: 4,
        validator: RequiredValidator(errorText: 'this field is required'),
        controller: complaintController,
        style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Segoe",
            fontSize: 18,
            color: Colors.black),
        autocorrect: true,
        decoration: InputDecoration(
          hintText: 'Describe the complaint',
          hintStyle: TextStyle(
              fontSize: 17, letterSpacing: 0.8, fontWeight: FontWeight.w300),
          contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
    final emailTextfield = Container(
      padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 20),
      child: TextFormField(
        autofocus: false,
        maxLines: 1,
        controller: emailController,
        validator: MultiValidator(
          [
            EmailValidator(errorText: 'Please enter a valid email'),
            RequiredValidator(errorText: 'email is required'),
          ],
        ),
        style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Segoe",
            fontSize: 18,
            color: Colors.black),
        // autocorrect: true,
        decoration: InputDecoration(
          hintText: 'email',
          labelText: 'email',
          hintStyle: TextStyle(
              fontSize: 17, letterSpacing: 0.8, fontWeight: FontWeight.w300),
          contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
    final sendButton = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 100),
      child: MaterialButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_complaintFormKey.currentState!.validate()) {
            _complaintFormKey.currentState!.save();
            saveComplaint();
          }
          // showToast(
          //   "✔ complain was successfully sent!",
          //   position: ToastPosition.center,
          //   duration: Duration(seconds: 3),
          //   backgroundColor: kTitleColor,
          //   radius: 22.0,
          //   textAlign: TextAlign.center,
          //   textStyle: TextStyle(
          //       decoration: TextDecoration.none,
          //       fontFamily: 'Segoe',
          //       fontSize: 16.0,
          //       fontWeight: FontWeight.w700,
          //       color: kBaseColor),
          //   textPadding:
          //       EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 8),
          //   animationBuilder: Miui10AnimBuilder(),
          // );
        },
        padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
        color: kButtonColor,
        child: Text(isLoading ? 'Sending...' : 'Send',
            style: TextStyle(
                fontFamily: "Segoe",
                letterSpacing: 0.5,
                fontSize: 18,
                color: kWhiteShadow)),
      ),
    );
    final complaintDataTable = ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        padding: EdgeInsets.only(left: 2, right: 2),
        child: DataTable(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey),
          dataRowHeight: 80,
          headingRowHeight: 40,
          headingTextStyle: TextStyle(textBaseline: TextBaseline.ideographic),
          showBottomBorder: true,
          columnSpacing: 20.0,
          columns: [
            DataColumn(
                label: Text(
              "#SL",
              style: TextStyle(
                  fontSize: 15.0,
                  color: kWhiteShade,
                  fontWeight: FontWeight.w900),
            )),
            DataColumn(
                label: Text(
              "Problem",
              style: TextStyle(
                  fontSize: 15.0,
                  color: kWhiteShade,
                  fontWeight: FontWeight.w900),
            )),
            DataColumn(
                label: Text(
              "Date",
              style: TextStyle(
                  fontSize: 15.0,
                  color: kWhiteShade,
                  fontWeight: FontWeight.w900),
            )),
          ],
          rows: complaints.map(
            ((element) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text('${complaints.indexOf(element) + 1}')),
                  DataCell(Text(element['problem'] ?? '')),
                  DataCell(Text(element['date'])),
                ],
              );
            }),
          ).toList(),
        ),
      ),
    );
    return OKToast(
      child: Scaffold(
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
          title: Text('Complaint',
              style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
        ),
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Form(
            key: _complaintFormKey,
            child: Column(
              children: [
                SizedBox(height: 2),
                complaintLogo,
                complaintTitle,
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Colors.black,
                  height: 0.0,
                  thickness: 0.5,
                  indent: 0.0,
                  endIndent: 0.0,
                ),
                emailTextfield,
                descTextfield,
                sendButton,
                Expanded(
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        complaintDataTable,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
