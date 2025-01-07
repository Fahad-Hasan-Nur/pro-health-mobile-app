import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/models/advance_doctor_search.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/patient/controllers/dashboard_controller.dart';
import 'package:pro_health/patient/views/bottombar/home/doctor_profile.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

class AppointmentPatient extends StatefulWidget {
  static String tag = 'AppointmentPatient';
  @override
  AppointmentPatientState createState() => new AppointmentPatientState();
}

class AppointmentPatientState extends State<AppointmentPatient> {
  // DashboardController dashboardController = Get.put(DashboardController());

  var rating = 5.0;

  String selectedFilterItem = 'Online Doctors';
  int fId = 1;
  List<FilterList> filterList = [
    FilterList(
      index: 1,
      name: "Online Doctors",
    ),
    FilterList(
      index: 2,
      name: "Male Doctors",
    ),
    FilterList(
      index: 3,
      name: "Female Doctors",
    ),
    FilterList(
      index: 4,
      name: "Free Doctors",
    ),
    FilterList(
      index: 5,
      name: "Top Rated",
    ),
  ];

  String? selectedSortItem = 'Experience: High to Low';
  int? sId = 1;
  List<SortList> sortList = [
    SortList(
      index: 1,
      name: "Experience: High to Low",
    ),
    SortList(
      index: 2,
      name: "Experience: Low to High",
    ),
    SortList(
      index: 3,
      name: "Fees: High to Low",
    ),
    SortList(
      index: 4,
      name: "Fees: Low to High",
    ),
  ];

  var memberId;

  bool hasBeenPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchDoctor = Container(
      height: 60,
      padding: EdgeInsets.only(left: 10, top: 14, right: 10, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        onChanged: (value) => Get.find<DashboardController>().runFilter(value),
        style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Segoe",
            fontSize: 18,
            color: Colors.black),
        autocorrect: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: kDashBoxColor,
          hintText: 'Search by Doctors name/ Hospital/ Speciality',
          hintStyle: TextStyle(
              fontFamily: 'Segoe', fontSize: 16, fontWeight: FontWeight.w500),
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

    final categorySortFilter = Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 330,
                          child: DropdownButton<String>(
                            value: Get.find<DashboardController>()
                                .dropdownValue
                                .value,
                            isExpanded: true,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                Get.find<DashboardController>()
                                    .dropdownValue
                                    .value = newValue ?? '';
                              });
                              for (var item in Get.find<DashboardController>()
                                  .doctorTypeList) {
                                if (item.specialityName == newValue) {
                                  setState(() {
                                    Get.find<DashboardController>()
                                        .selectedSpecialityId
                                        .value = item.specialityId ?? 0;
                                  });

                                  Get.find<DashboardController>()
                                      .filterDoctorsBySpecialityId(
                                          item.specialityId);
                                  // filterCasesById(item.specialityId);
                                }
                              }
                            },
                            items: Get.find<DashboardController>()
                                .doctorTypeList
                                .map((DoctorSpecialityModel data) {
                              return DropdownMenuItem(
                                value: data.specialityName,
                                child: Text(
                                  data.specialityName!,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 5),
                      child: Obx(
                        () => Text(
                          '( ${Get.find<DashboardController>().doctorsCount.value} ) doctors found',
                          style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: 15,
                              color: kTextLightColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 22,
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.all(1),
                  splashRadius: 20,
                  icon: Image.asset('assets/icons/patient/filter.png'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.black38,
                          insetPadding: EdgeInsets.zero,
                          titlePadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          title: Container(
                            height: 50,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Filter',
                                          style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 18,
                                            letterSpacing: .6,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 40,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                              fontFamily: 'Segoe',
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Divider(
                                    color: kTitleColor,
                                    height: 0.0,
                                    thickness: 0.5,
                                    indent: 0.0,
                                    endIndent: 0.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          content: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              height: 210,
                              child: Column(
                                children: filterList
                                    .map(
                                      (data) => ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: 40, maxWidth: 340),
                                        child: RadioListTile<int?>(
                                          title: Text(
                                            "${data.name}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          activeColor: kTitleColor,
                                          dense: true,
                                          groupValue: fId,
                                          value: data.index,
                                          onChanged: (val) {
                                            setState(() {
                                              fId = data.index ?? 0;
                                            });
                                            print('index = $fId');
                                          },
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }),
                          actions: [
                            Container(
                              width: 360,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 70),
                              child: MaterialButton(
                                onPressed: () {
                                  Get.find<DashboardController>()
                                      .filterDoctorList(fId);
                                  Navigator.of(context).pop();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: EdgeInsets.only(
                                    left: 5, top: 5, right: 5, bottom: 5),
                                color: kBaseColor,
                                child: Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Text(
                                    'Filter Now',
                                    style: TextStyle(
                                        fontFamily: "Segoe",
                                        letterSpacing: 0.5,
                                        fontSize: 15,
                                        color: kTitleColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 30,
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.all(1),
                  splashRadius: 20,
                  icon: Image.asset('assets/icons/patient/sort.png'),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.black38,
                          insetPadding: EdgeInsets.zero,
                          titlePadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          title: Container(
                            height: 50,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 290,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Sort',
                                          style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: 18,
                                            letterSpacing: .6,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 40,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                                fontFamily: 'Segoe',
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Divider(
                                    color: kTitleColor,
                                    height: 0.0,
                                    thickness: 0.5,
                                    indent: 0.0,
                                    endIndent: 0.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Container(
                                height: 170,
                                child: Column(
                                  children: sortList
                                      .map(
                                        (data) => ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 40, maxWidth: 340),
                                          child: RadioListTile<int?>(
                                            title: Text(
                                              "${data.name}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            activeColor: kTitleColor,
                                            dense: true,
                                            groupValue: sId,
                                            value: data.index,
                                            onChanged: (val) {
                                              setState(() {
                                                selectedSortItem = data.name;
                                                sId = data.index;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                            },
                          ),
                          actions: [
                            Container(
                              width: 350,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 70),
                              child: MaterialButton(
                                onPressed: () {
                                  Get.find<DashboardController>()
                                      .sortDoctors(sId ?? 0);
                                  Navigator.of(context).pop();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: EdgeInsets.only(
                                    left: 5, top: 5, right: 5, bottom: 5),
                                color: kBaseColor,
                                child: Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Text(
                                    'Sort Now',
                                    style: TextStyle(
                                        fontFamily: "Segoe",
                                        letterSpacing: 0.5,
                                        fontSize: 15,
                                        color: kTitleColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
    final verticalDivider = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Divider(
        color: Colors.black,
        height: 0.0,
        thickness: 0.8,
        indent: 0.0,
        endIndent: 0.0,
      ),
    );

    final doctorViewCardList = Obx(
      () => Expanded(
        child: !Get.find<DashboardController>().isLoading.value
            ? Get.find<DashboardController>().doctorsCount.value != 0
                ? ListView.builder(
                    itemCount:
                        Get.find<DashboardController>().doctorsCount.value,
                    itemBuilder: (BuildContext context, int index) {
                      var doctor;
                      if (Get.find<DashboardController>().isSearching.value) {
                        doctor =
                            Get.find<DashboardController>().foundDoctors[index];
                      } else {
                        doctor = Get.find<DashboardController>()
                            .filteredDoctorsList[index];
                      }

                      String qualificationOne = doctor['qualificationOne'];
                      String qualificationTwo = doctor['qualificationTwo'];
                      return Container(
                        child: Card(
                          margin: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Column(
                              children: [
                                Container(
                                    height: 60,
                                    color: kCardTitleColor,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 12.0, top: 10.0),
                                                child: Text(
                                                  'Consultation Fees',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kBodyTextColor),
                                                ),
                                              ),
                                              Container(
                                                width: 115,
                                                child: Text(
                                                  '${doctor['consultationFeeOnline']}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: kBodyTextColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 150.0),
                                          child: Text(
                                            doctor['isOnline']
                                                ? 'Online'
                                                : 'Offline',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: kBodyTextColor),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  height: 130,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      top: 10,
                                                      right: 10,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: doctor[
                                                                    'profilePicture'] !=
                                                                ''
                                                            ? NetworkImage(doctor[
                                                                'profilePicture'])
                                                            : AssetImage(
                                                                    noImagePath)
                                                                as ImageProvider<
                                                                    Object>,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  height: 16,
                                                  width: 70,
                                                  padding: EdgeInsets.only(
                                                      bottom: 2),
                                                  decoration: BoxDecoration(
                                                      color: kButtonColor,
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  alignment: Alignment.center,
                                                  child: new Text(
                                                    "${doctor['specialityName']}",
                                                    style: TextStyle(
                                                        fontFamily: 'Segoe',
                                                        letterSpacing: 0.5,
                                                        fontSize: 10,
                                                        color: kWhiteShadow),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    '${doctor['doctorName']}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'Segoe',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kBaseColor),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    '$qualificationOne$qualificationTwo'
                                                            .isEmpty
                                                        ? 'Your Qualification I.e: MBBS etc'
                                                        : '$qualificationOne, $qualificationTwo',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Segoe',
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 6),
                                                  child: Text(
                                                    '${doctor['experience']}+ Years',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    'Total Experience',
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 6),
                                                  child: Text(
                                                    '${doctor['workingPlace']}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    'Working in',
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 12, top: 25, right: 15),
                                        child: Column(
                                          children: [
                                            Text(
                                              '${doctor['rating']}',
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Container(
                                              child: RatingStars(
                                                value: doctor['rating'],
                                                onValueChanged: (v) {},
                                                starBuilder: (index, color) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: color,
                                                ),
                                                starCount: 5,
                                                starSize: 20,
                                                maxValue: 5,
                                                starSpacing: 1,
                                                maxValueVisibility: true,
                                                valueLabelVisibility: false,
                                                animationDuration: Duration(
                                                    milliseconds: 1000),
                                                valueLabelPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1,
                                                        horizontal: 8),
                                                valueLabelMargin:
                                                    const EdgeInsets.only(
                                                        right: 8),
                                                starOffColor:
                                                    const Color(0xffe7e8ea),
                                                starColor: Colors.yellow,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => DoctorProfile(
                                        doctorMemberId: doctor['memberID'],
                                        doctorId: doctor['doctorID'],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      height: 35,
                                      width: 220,
                                      decoration: BoxDecoration(
                                          color: kButtonColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 25, bottom: 2, right: 25),
                                            child: Text(
                                              'See Doctor\'s Details',
                                              style: TextStyle(
                                                  fontFamily: "Segoe",
                                                  letterSpacing: 0.5,
                                                  fontSize: 14,
                                                  color: kWhiteShadow),
                                            ),
                                          ),
                                          Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              child: Container(
                                                width: 44,
                                                color: kTitleColor,
                                                child: IconButton(
                                                  icon: Icon(Icons
                                                      .arrow_forward_rounded),
                                                  onPressed: () {
                                                    Get.to(
                                                      () => DoctorProfile(
                                                        doctorMemberId:
                                                            doctor['memberID'],
                                                        doctorId:
                                                            doctor['doctorID'],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                : Center(
                    child: Text(
                      'No doctor found',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
            : Center(child: CircularProgressIndicator()),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: kBaseColor,
        centerTitle: true,
        toolbarHeight: 50,
        // leading: IconButton(
        //   color: kTitleColor,
        //   onPressed: () => Navigator.of(context).pop(),
        //   icon: Icon(Icons.arrow_back),
        // ),
        title: Text('Appointment',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            searchDoctor,
            categorySortFilter,
            verticalDivider,
            doctorViewCardList,
          ],
        ),
      ),
    );
  }
}

class FilterList {
  String? name;
  int? index;
  FilterList({this.name, this.index});
}

class SortList {
  String? name;
  int? index;
  SortList({this.name, this.index});
}
