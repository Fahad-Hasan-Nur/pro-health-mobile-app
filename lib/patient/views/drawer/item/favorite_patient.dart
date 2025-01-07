// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/patient/models/favorite_model.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
import 'package:pro_health/patient/views/bottombar/home/doctor_profile.dart';

class FavoritePatient extends StatefulWidget {
  FavoritePatient({Key? key, this.title, required this.patientId})
      : super(key: key);
  final String? title;
  static String tag = 'FavoritePatient';
  final patientId;

  @override
  FavoritePatientState createState() =>
      new FavoritePatientState(patientId: this.patientId);
}

class FavoritePatientState extends State<FavoritePatient> {
  FavoritePatientState({this.patientId});

  PatientApiService patientApiService = PatientApiService();
  var _timer;
  final patientId;
  var rating = 5.0;
  bool isRemove = false;

  List<FavoriteModel> favoriteDoctors = [];

  getFavoriteDoctors() async {
    if (favoriteDoctors.isNotEmpty) {
      favoriteDoctors.clear();
    }
    var response = await patientApiService.fetchFavoriteDoctors(patientId);
    if (response.isNotEmpty) {
      var reversedFavorites = response.reversed.toList();
      setState(() {
        favoriteDoctors.addAll(reversedFavorites);
      });
    }
  }

  @override
  void initState() {
    getFavoriteDoctors();
    const oneSec = Duration(seconds: 3);
    _timer = Timer.periodic(oneSec, (Timer t) {
      getFavoriteDoctors();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteLogo = Container(
      padding: EdgeInsets.only(top: 2),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/patient/favouritepage.png'),
        ),
      ),
    );

    final favouriteTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Favourite',
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

    final doctorCard = Container(
      height: 95,
      width: 395,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15, top: 5, right: 10),
                        child: CircleAvatar(
                          radius: 27.0,
                          backgroundColor: kBaseColor,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 26.0,
                            child: Image.asset('assets/doctorimg.png'),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Prof. Mohammed Hanif',
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: kBaseColor),
                              ),
                            ),
                            Container(
                              child: Text(
                                'MBBS, FCPS, FRCP (Edin)',
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Dhaka Shishu Hospital',
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontSize: 12,
                                    color: kBodyTextColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 2),
                  child: Text(
                    '21 Feb 2021, 6:00 PM',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 95,
          ),
          Container(
            width: 25,
            child: PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'Remove',
                    child: Text('Remove'),
                  )
                ];
              },
              onSelected: (dynamic result) {
                if (result == 'Remove') {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
    final favoriteDoctorList = Expanded(
      child: favoriteDoctors.isNotEmpty
          ? ListView.builder(
              itemCount: favoriteDoctors.length,
              itemBuilder: (BuildContext context, int index) {
                FavoriteModel doctor = favoriteDoctors[index];
                var time = getCustomDateLocal(doctor.createOn ?? '');
                String qualificationOne = doctor.qualificationOne ?? '';
                String qualificationTwo = doctor.qualificationTwo ?? '';
                String degree = '';
                if (doctor.qualificationOne != '' &&
                    doctor.qualificationTwo != '') {
                  degree =
                      '${doctor.qualificationOne}, ${doctor.qualificationTwo}';
                } else if (doctor.qualificationOne != '') {
                  degree = '${doctor.qualificationOne}';
                } else if (doctor.qualificationTwo != '') {
                  degree = '${doctor.qualificationTwo}';
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorProfile(
                          doctorMemberId: doctor.memberID,
                          doctorId: doctor.doctorID,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 95,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 15, top: 5, right: 10),
                                      child: CircleAvatar(
                                        radius: 27.0,
                                        backgroundColor: kBaseColor,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 26.0,
                                          child: Image.asset(
                                              'assets/doctorimg.png'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              doctor.doctorName ?? '',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: kBaseColor),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '$degree',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '${doctor.workingPlace}',
                                              style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 12,
                                                  color: kBodyTextColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, top: 2),
                                child: Text(
                                  "$time", //'21 Feb 2021, 6:00 PM',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 25,
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'Remove',
                                    child: Text('Remove'),
                                  )
                                ];
                              },
                              onSelected: (dynamic result) async {
                                if (result == 'Remove') {
                                  bool deleted = await patientApiService
                                      .deleteFromFavorite(
                                          patientId, doctor.doctorID ?? 0);
                                  if (deleted) {
                                    getFavoriteDoctors();
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(child: Text('No doctor found in favorite list')),
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
        title: Text('Favourite',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            favouriteLogo,
            favouriteTitle,
            verticalDivider,
            favoriteDoctorList,
          ],
        ),
      ),
    );
  }
}
