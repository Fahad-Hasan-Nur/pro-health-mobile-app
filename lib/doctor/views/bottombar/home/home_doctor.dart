import 'dart:ui';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/controllers/dashboard_controller.dart';
import 'package:pro_health/doctor/controllers/profile/profile_controller.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/views/bottombar/profile/profile_doctor_part.dart';
// import 'package:pro_health/doctor/views/bottombar/profile/editDoctorProfile.dart';
import 'package:pro_health/doctor/views/dashboard/earnings/earnings.dart';
import 'package:pro_health/doctor/views/dashboard/consultation_history/consultation_history.dart';
import 'package:pro_health/doctor/views/dashboard/online_consultancy/online_consultancy.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/case_exchange.dart';
import 'package:pro_health/doctor/views/drawer/custom_drawer_doctor.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/views/drawer/item/notification.dart';

class Home extends StatefulWidget {
  static String tag = 'Home';

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  ApiServices apiServices = ApiServices();

  DoctorProfileController profileController =
      Get.put(DoctorProfileController());
  // var memberId;
  var doctorPhone;

  var rating = 5.0;

  List<DoctorSpecialityModel> doctorSpeciality = [];

  @override
  Widget build(BuildContext context) {
    Widget appBar = AppBar(
      centerTitle: true,
      title: Container(
        height: 45,
        width: 270,
        padding: EdgeInsets.only(right: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: kBackgroundColor,
          margin: EdgeInsets.only(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.5),
            child: Image.asset('assets/icons/doctor/homebarlogo.png',
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
          width: 10,
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: PopupMenuButton(
            icon: Obx(
              () => Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                  image: DecorationImage(
                    image:
                        (Get.find<DoctorProfileController>().profilePic.value ==
                                    '' ||
                                Get.find<DoctorProfileController>()
                                        .profilePic
                                        .value ==
                                    'null'
                            ? AssetImage(noImagePath)
                            : NetworkImage(Get.find<DoctorProfileController>()
                                .profilePic
                                .value)) as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'ViewProfile',
                  child: Text('View Profile'),
                ),
                // PopupMenuItem<String>(
                //   value: 'EditProfile',
                //   child: Text('Edit Profile'),
                // ),
              ];
            },
            onSelected: (dynamic result) {
              if (result == 'ViewProfile') {
                Get.to(() => ProfileDoctor());
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.0, right: 10.0),
          child: Container(
            height: 50,
            width: 35,
            child: IconButton(
              padding: EdgeInsets.all(2),
              icon: Icon(
                Icons.notifications_active_rounded,
                size: 28,
              ),
              splashRadius: 20,
              color: kTitleColor,
              onPressed: () {
                Get.to(() => NotificationView());
              },
            ),
          ),
        ),
      ],
    );
    final swiperSlide = Container(
      height: 265.0,
      child: Obx(
        () => Get.find<DoctorDashboardController>().sliderImages.length > 0
            ? Swiper(
                outer: false,
                itemBuilder: (BuildContext context, int index) {
                  String networkImage = Get.find<DoctorDashboardController>()
                          .sliderImages[index]
                          .photoURL ??
                      '';
                  String imageUrl =
                      networkImage == '' ? '' : imageBaseUrl + networkImage;

                  return new Container(
                    color: Colors.grey[300],
                    child: imageUrl != ''
                        ? Image.network(
                            "$imageUrl",
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  );
                },
                pagination: new SwiperPagination(
                  margin: new EdgeInsets.all(5.0),
                  builder: SwiperPagination.dots,
                ),
                itemCount:
                    Get.find<DoctorDashboardController>().sliderImages.length,
                autoplay: true,
                duration: 800,
                control: SwiperControl(),
                autoplayDelay: 3500,
              )
            : Container(),
      ),
    );

    final cardWithDividerRow1 = Row(
      children: [
        Expanded(
          child: Container(
            width: 195,
            height: 132,
            padding:
                EdgeInsets.only(top: 10.0, left: 20.0, bottom: 6.0, right: 6.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: kDashBoxColor,
              elevation: 12,
              onPressed: () {
                Get.to(() => OnlineConsultancy());
                // Navigator.of(context).pushNamed(OnlineConsultancy.tag);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 35.0,
                      child: Image.asset(
                          'assets/icons/doctor/onlineconsultancy.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'ONLINE CONSULTANCY',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 12.0,
                          color: kBodyTextColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 195,
            height: 132,
            padding:
                EdgeInsets.only(top: 10.0, left: 6.0, bottom: 6.0, right: 20.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: kDashBoxColor,
              elevation: 12,
              onPressed: () {
                Navigator.of(context).pushNamed(ConsultationHistory.tag);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 35.0,
                      child: Image.asset(
                          'assets/icons/doctor/consultationhistory.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'CONSULTATION HISTORY',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 12.0,
                          color: kBodyTextColor,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    final cardWithDividerRow2 = Row(
      children: [
        Expanded(
          child: Container(
            width: 195,
            height: 132,
            padding:
                EdgeInsets.only(top: 6.0, left: 20.0, bottom: 10.0, right: 6.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: kDashBoxColor,
              elevation: 12,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CaseExchange(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 35.0,
                      child: Image.asset('assets/icons/doctor/cexchange.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'CASE EXCHANGE',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 12.0,
                          color: kBodyTextColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 195,
            height: 132,
            padding:
                EdgeInsets.only(top: 6.0, left: 6.0, bottom: 10.0, right: 20.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: kDashBoxColor,
              elevation: 12,
              onPressed: () {
                Navigator.of(context).pushNamed(Earnings.tag);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 35.0,
                      child: Image.asset('assets/icons/doctor/myearnings.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'MY EARNINGS',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 12.0,
                          color: kBodyTextColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      drawer: CustomDrawerDoctor(),
      appBar: appBar as PreferredSizeWidget?,
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          children: <Widget>[
            swiperSlide,
            SizedBox(
              height: 18,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  cardWithDividerRow1,
                  cardWithDividerRow2,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
