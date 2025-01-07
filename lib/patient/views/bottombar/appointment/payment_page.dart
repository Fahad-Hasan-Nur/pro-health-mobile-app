import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/constants/app_string.dart';
import 'package:pro_health/doctor/models/payment_method.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
import 'package:pro_health/patient/views/bottombar/home/request_approval.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {Key? key,
      required this.doctorInfo,
      required this.appointmentMap,
      required this.paymentMethods,
      required this.paymentMethodMap,
      required this.isSelf,
      required this.isNewPatient,
      required this.base64imageList})
      : super(key: key);

  final Map<String, dynamic> doctorInfo;
  final Map<String, dynamic> appointmentMap;
  final List<PaymentMethod> paymentMethods;
  final Map<String, dynamic> paymentMethodMap;

  final List<String> base64imageList;

  final bool isSelf;
  final bool isNewPatient;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController trxIDController = TextEditingController();
  TextEditingController doctorNumberController = TextEditingController();

  final _createAppointmentkey = GlobalKey<FormState>();

  bool isLoading = false;
  bool savingAppointment = false;

  String bkashPhone = '';
  String nagadPhone = '';
  String rocketPhone = '';

  String selectedCard = Bkash;
  String paymentPhone = '';

  ApiServices apiServices = ApiServices();
  PatientApiService patientApiService = PatientApiService();

  @override
  void initState() {
    setState(() {
      paymentPhone = widget.paymentMethodMap['bKash'] ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctorCard = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 1, color: Colors.blue),
                            image: DecorationImage(
                              image: (widget.doctorInfo['doctorPic'] ==
                                              'null' ||
                                          widget.doctorInfo['doctorPic'].isEmpty
                                      ? AssetImage(noImagePath)
                                      : NetworkImage(
                                          widget.doctorInfo['doctorPic']))
                                  as ImageProvider<Object>,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${widget.doctorInfo['doctorName']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${widget.doctorInfo['qualification']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kBodyTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '${widget.doctorInfo['rating']}',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        child: RatingStars(
                          value: widget.doctorInfo['rating'],
                          onValueChanged: (v) {},
                          starBuilder: (index, color) => Icon(
                            Icons.star,
                            color: color,
                          ),
                          starCount: 5,
                          starSize: 20,
                          maxValue: 5,
                          starSpacing: 1,
                          maxValueVisibility: true,
                          valueLabelVisibility: false,
                          animationDuration: Duration(milliseconds: 1000),
                          valueLabelPadding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 8),
                          valueLabelMargin: const EdgeInsets.only(right: 8),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final verticalDivider = Container(
      margin: const EdgeInsets.only(top: 10),
      child: Divider(
        color: Colors.black,
        height: 1.0,
        thickness: 0.5,
        indent: 15.0,
        endIndent: 15.0,
      ),
    );

    final paymentTitle = Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please Select Your Mobile Banking Account',
            style: TextStyle(
              color: kBodyTextColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );

    final imageCard = Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PaymentMethodCard(
              type: Bkash,
              selectedCard: selectedCard,
              image: 'assets/bkash.png',
              onTap: () {
                setState(() {
                  selectedCard = Bkash;
                  paymentPhone = widget.paymentMethodMap['bKash'] ?? '';
                });
              },
            ),
            PaymentMethodCard(
              type: Nagad,
              selectedCard: selectedCard,
              image: 'assets/nagad.png',
              onTap: () {
                setState(() {
                  selectedCard = Nagad;
                  paymentPhone = widget.paymentMethodMap['nagad'] ?? '';
                });
              },
            ),
            PaymentMethodCard(
              type: Rocket,
              selectedCard: selectedCard,
              image: 'assets/rocket.jpg',
              onTap: () {
                setState(() {
                  selectedCard = Rocket;
                  paymentPhone = widget.paymentMethodMap['rocket'] ?? '';
                });
              },
            ),
          ],
        ),
      ),
    );

    final paymentEntryCard = Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'প্রথমে আপনার বিকাশ অর্থ প্রদান সম্পন্ন করুণ, তারপরে নিচের ফর্মটি পূরণ করুন, মোট ৳ ${widget.doctorInfo['onlineConsultionFee']} বিকাশে পাঠাতে হবে।',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF01619B),
                        // fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      paymentPhone == ''
                          ? Text('Payment method not available')
                          : Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Doctor's ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: selectedCard,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Personal No. ',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: paymentPhone,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$selectedCard Number (sender)',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: numberController,
                            validator: RequiredValidator(
                                errorText: 'Sender No. is Required'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: "যে নাম্বার থেকে টাকা পাঠিয়েছেন",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Transaction ID',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: trxIDController,
                            validator: RequiredValidator(
                                errorText: 'Transaction ID is Required'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: "ABC12BKDC1",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$selectedCard Number (doctor)',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: doctorNumberController,
                            validator: RequiredValidator(
                                errorText: 'Doctor Receiver No. is Required'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: "যে নাম্বারে টাকা পাঠিয়েছেন",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Grand Total: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF01619B),
                        ),
                      ),
                      Text(
                        '${widget.doctorInfo['onlineConsultionFee']} Tk',
                        style: TextStyle(
                          fontSize: 17,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Your personal data will be used to process your order, support your experience throughout this app, and for other purposes, described in our ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final proceedButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 80),
      child: MaterialButton(
        onPressed: () async {
          if (_createAppointmentkey.currentState!.validate()) {
            _createAppointmentkey.currentState!.save();

            setState(() {
              savingAppointment = true;
            });

            Map<String, dynamic> paymentMap = {};
            paymentMap['paymentPhone'] = numberController.text;
            paymentMap['trxID'] = trxIDController.text;
            paymentMap['paidToPhone'] = doctorNumberController.text;

            var created = false;
            String uuid = generateUid();

            print('uuid = $uuid');

            if (widget.isSelf) {
              for (var item in widget.base64imageList) {
                var body = jsonEncode({
                  "ImageName": "patientImage",
                  "Uuid": uuid,
                  "imageBase64": item,
                  "ImageType": "Appointment",
                  "ImageExtension": ".png",
                });

                await patientApiService.insertAppointmentImage(body);
              }
              created = await patientApiService.createAppointment(
                  widget.appointmentMap, paymentMap, widget.doctorInfo, uuid);
              //
            } else {
              if (widget.isNewPatient) {
                for (var item in widget.base64imageList) {
                  var body = jsonEncode({
                    "ImageName": "patientImage",
                    "Uuid": uuid,
                    "imageBase64": item,
                    "ImageType": "Appointment",
                    "ImageExtension": ".png",
                  });

                  await patientApiService.insertAppointmentImage(body);
                }
                await patientApiService
                    .createRelatives(widget.appointmentMap)
                    .then((value) async {
                  created = await patientApiService.createAppointment(
                      widget.appointmentMap,
                      paymentMap,
                      widget.doctorInfo,
                      uuid);
                });

                //
              } else {
                for (var item in widget.base64imageList) {
                  var body = jsonEncode({
                    "ImageName": "patientImage",
                    "Uuid": uuid,
                    "imageBase64": item,
                    "ImageType": "Appointment",
                    "ImageExtension": ".png",
                  });

                  await patientApiService.insertAppointmentImage(body);
                }
                created = await patientApiService.createAppointment(
                    widget.appointmentMap, paymentMap, widget.doctorInfo, uuid);

                //
              }
            }

            if (created) {
              int memberID = widget.appointmentMap['memberId'];
              List appointments =
                  await apiServices.fetchDoctorAppoinment(memberID);
              int appointmentId = 0;
              if (appointments.isNotEmpty) {
                appointmentId = appointments.last['appoitmentID'];
              }

              // apiServices.insertAppointmentPhoto(
              //   widget.base64imageList,
              //   appointmentId,
              // );

              setState(() {
                savingAppointment = false;
              });
              trxIDController.clear();
              numberController.clear();
              doctorNumberController.clear();
              Get.to(
                () => RequestApproval(
                  createAppointmentMap: widget.appointmentMap,
                  doctorInfo: widget.doctorInfo,
                ),
              );
            } else {
              setState(() {
                savingAppointment = false;
              });
              showMyDialog(
                context,
                'Opps!',
                'Something went wrong, please try again later',
              );
            }
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        color: kBaseColor,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 35),
          child: Text(
            savingAppointment ? 'Please wait..' : 'Proceed',
            style: TextStyle(
                fontFamily: "Segoe",
                letterSpacing: 0.5,
                fontSize: 15,
                color: kTitleColor,
                fontWeight: FontWeight.w700),
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
        title: Text('Select Patient',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Form(
        key: _createAppointmentkey,
        child: Center(
          child: ListView(
            // shrinkWrap: false,
            children: <Widget>[
              doctorCard,
              verticalDivider,
              SizedBox(height: 20),
              paymentTitle,
              imageCard,
              paymentEntryCard,
              proceedButton,
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    Key? key,
    required this.image,
    required this.onTap,
    required this.type,
    required this.selectedCard,
  }) : super(key: key);

  final String image;
  final VoidCallback onTap;
  final String type;
  final String selectedCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: type == selectedCard ? 8 : 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Stack(
              children: [
                Center(child: Image.asset(image)),
                type == selectedCard
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/icons/patient/success.png'),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            height: 95,
            width: MediaQuery.of(context).size.width / 4,
          ),
        ),
      ),
    );
  }
}
