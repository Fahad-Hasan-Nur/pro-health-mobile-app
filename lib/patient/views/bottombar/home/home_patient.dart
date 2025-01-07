// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:marquee/marquee.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/controllers/dashboard_controller.dart';
import 'package:pro_health/patient/models/patient_slider.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
// import 'package:pro_health/patient/service/dashboard/patient_api_service.dart';
import 'package:pro_health/patient/views/bottombar/home/doctor_profile.dart';
import 'package:pro_health/patient/views/drawer/custom_drawer_patient.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:pro_health/patient/views/bottombar/home/view_doctors.dart';
import 'package:pro_health/patient/views/drawer/item/notification_view.dart';

// class HomePatient extends StatefulWidget {
//   static String tag = 'HomePatient';

//   @override
//   HomePatientState createState() => HomePatientState();
// }

// class HomePatientState extends State<HomePatient> {

// }

class HomePatient extends StatefulWidget {
  HomePatient({Key? key}) : super(key: key);

  @override
  State<HomePatient> createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  // DashboardController dashboardController = Get.put(DashboardController());
  PatientApiService patientApiService = PatientApiService();

  var latestNews = '';
  // List<PatientSliderModel> sliderImages = [];
  List<PatientSliderModel> sliderImages = [];

  getLatestNews() async {
    var news = await patientApiService.fetchlatestNews();
    if (news.latestNewsID != 0) {
      setState(() {
        latestNews = news.description ?? '';
      });
    }
  }

  getSliderImages() async {
    var response = await patientApiService.fetchPatientSliderImages();
    if (response.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 300));
      setState(() {
        sliderImages.addAll(response);
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getSliderImages();
      getLatestNews();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _controller = SwiperController();
    var appBar = AppBar(
      centerTitle: true,
      title: Container(
        height: 45,
        width: 280,
        padding: EdgeInsets.only(right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: kBackgroundColor,
          margin: EdgeInsets.only(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.5),
            child: Image.asset('assets/icons/patient/homebarlogo.png',
                fit: BoxFit.fitHeight),
          ),
        ),
      ),
      elevation: 2.0,
      backgroundColor: kBaseColor,
      iconTheme: IconThemeData(color: kTitleColor),
      toolbarHeight: 50,
      actions: <Widget>[
        SizedBox(
          width: 90,
          height: 50,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                    color: kTitleColor, width: 0.5, style: BorderStyle.solid),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('');
              },
              padding:
                  EdgeInsets.only(left: 12, top: 4.0, bottom: 2.0, right: 12),
              color: kBaseColor,
              child: Text('বাংলা',
                  style: TextStyle(
                      fontFamily: "Segoe",
                      letterSpacing: 0.5,
                      fontSize: 15,
                      color: kTextLightColor)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => NotificationView());
          },
          child: SizedBox(
            height: 50,
            width: 35,
            child: Container(
              padding: EdgeInsets.only(left: 0.0, right: 10.0),
              child: Icon(
                Icons.notifications_active,
                size: 30,
                color: kTitleColor,
              ),
            ),
          ),
        ),
      ],
    );

    final swiperSlide = Container(
      // padding: const EdgeInsets.all(8),
      height: 230.0,
      child: sliderImages.length > 0
          ? Swiper(
              outer: false,
              // controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                // _controller.move(index, animation: false);
                String networkImage = sliderImages[index].photoURL ?? '';
                String imageUrl =
                    networkImage == '' ? '' : imageBaseUrl + networkImage;

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  ),
                );
              },
              pagination: const SwiperPagination(
                margin: EdgeInsets.all(5.0),
                builder: SwiperPagination.dots,
              ),
              itemCount: sliderImages.length,
              autoplay: true,
              autoplayDelay: 3000,
              duration: 1000,
            )
          : Container(),
    );

    final searchDoctor = Container(
      height: 60,
      padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        onChanged: (value) =>
            Get.find<DashboardController>().runFilterForHomePage(value),
        style:
            TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
        autocorrect: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: kDashBoxColor,
          hintText: 'Search by Doctors name/ Hospital/ Speciality name',
          hintStyle: TextStyle(
              fontFamily: 'Segoe', fontSize: 14, fontWeight: FontWeight.w500),
          contentPadding:
              EdgeInsets.only(left: 10.0, top: 3.0, right: 10.0, bottom: 3.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
          prefixIcon: Container(
            child: Icon(
              Icons.search_rounded,
              size: 26,
            ),
          ),
        ),
      ),
    );

    final viewLabel = Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 50),
                child: Text(
                  'Available for consultation now',
                  style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 18,
                      color: kBaseColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                highlightColor: kBackgroundColor,
                hoverColor: kBackgroundColor,
                child: Container(
                  padding: EdgeInsets.only(left: 35, right: 15),
                  child: Text(
                    'View all',
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(ViewDoctors.tag);
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            child: Divider(
              color: Colors.black,
              height: 0.0,
              thickness: 0.8,
              indent: 15.0,
              endIndent: 15.0,
            ),
          ),
        ],
      ),
    );

    final doctorCard = Container(
      height: 222,
      padding: EdgeInsets.only(left: 6, top: 10, right: 5, bottom: 2),
      child: PageView(
        children: [
          Obx(
            () => Container(
              child: Get.find<DashboardController>()
                      .foundOnlineDonctors
                      .isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Get.find<DashboardController>()
                                  .foundOnlineDonctors
                                  .length >
                              10
                          ? 10
                          : Get.find<DashboardController>()
                              .foundOnlineDonctors
                              .length,
                      itemBuilder: (BuildContext context, int index) {
                        var doctor = Get.find<DashboardController>()
                            .foundOnlineDonctors[index];

                        String networkImage =
                            getDoctorProfilePic(doctor.profilePicture);

                        print('networkImage $networkImage');

                        return GestureDetector(
                          onTap: () {
                            // print('doctor.memberID ${doctor.memberID}');
                            Get.to(
                              () => DoctorProfile(
                                doctorMemberId: doctor.memberID,
                                doctorId: doctor.doctorID,
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            color: kCardTitleColor,
                            child: Container(
                              width: 119,
                              height: 220,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 2, top: 4, right: 2, bottom: 0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: networkImage != ''
                                                  ? NetworkImage(networkImage)
                                                  : ExactAssetImage(
                                                          'assets/doctorimg.png')
                                                      as ImageProvider<Object>,
                                              fit: BoxFit.contain),
                                        ),
                                        child: Align(
                                          alignment: Alignment(1.2, -0.8),
                                          child: Container(
                                            height: 16,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: kOnlineColor,
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(bottom: 2),
                                            child: new Text(
                                              doctor.isOnline != null &&
                                                      doctor.isOnline == true
                                                  ? "Online"
                                                  : "Offline",
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  letterSpacing: 0.5,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      doctor.doctorName != null ||
                                              doctor.doctorName!.isNotEmpty
                                          ? "${doctor.doctorName ?? ''}"
                                          : 'No Name',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'Segoe',
                                          fontSize: 12.0,
                                          color: kBaseColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 16,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: kButtonColor,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: new Text(
                                      doctor.specialityName != null
                                          ? "${doctor.specialityName ?? ''}"
                                          : "Doctor Speciality",
                                      style: TextStyle(
                                          fontFamily: 'Segoe',
                                          letterSpacing: 0.5,
                                          fontSize: 10,
                                          color: kWhiteShadow),
                                    ),
                                  ),
                                  Container(
                                    child: RatingStars(
                                      value: doctor.rating ?? 0,
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
                                      animationDuration:
                                          Duration(milliseconds: 1000),
                                      valueLabelPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 1, horizontal: 8),
                                      valueLabelMargin:
                                          const EdgeInsets.only(right: 8),
                                      starOffColor: const Color(0xffe7e8ea),
                                      starColor: Colors.yellow,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => DoctorProfile(
                                          doctorMemberId: doctor.memberID,
                                          doctorId: doctor.doctorID,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 16,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: kBaseColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: new Text(
                                        "Details",
                                        style: TextStyle(
                                            fontFamily: 'Segoe',
                                            letterSpacing: 0.5,
                                            fontSize: 12,
                                            color: kWhiteShadow),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
        // controller: controller,
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
      ),
    );

    final latestUpdate = Container(
      height: 70,
      padding: EdgeInsets.only(left: 10, top: 4, right: 10, bottom: 10),
      child: PageView(
        children: [
          Card(
            elevation: 6,
            child: Row(
              children: [
                Container(
                  height: 47,
                  width: 140,
                  padding:
                      EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
                  color: kBaseColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Covid-19 Update',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16,
                          color: kBackgroundColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 220,
                  padding:
                      EdgeInsets.only(left: 2, top: 10, right: 5, bottom: 10),
                  color: Colors.white,
                  child: Marquee(
                    text: latestNews != '' ? '$latestNews' : 'breaking news',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    pauseAfterRound: Duration(seconds: 1),
                    showFadingOnlyWhenScrolling: true,
                    fadingEdgeStartFraction: 0.1,
                    fadingEdgeEndFraction: 0.1,
                    numberOfRounds: null,
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
              ],
            ),
          ),
        ],
        // controller: controller,
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        scrollDirection: Axis.vertical,
      ),
    );

    return Scaffold(
      drawer: CustomDrawerPatient(),
      appBar: appBar,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              swiperSlide,
              searchDoctor,
              viewLabel,
              doctorCard,
              // Expanded(child: Text('')),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  latestUpdate,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
