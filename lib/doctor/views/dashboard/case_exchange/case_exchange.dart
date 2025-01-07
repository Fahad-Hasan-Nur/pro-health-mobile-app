import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/models/Api_response.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
// import 'package:pro_health/doctor/models/case_exchange_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/create_case.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/saved_case.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/case_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaseExchange extends StatefulWidget {
  static String tag = 'CaseExchange';
  @override
  CaseExchangeState createState() => new CaseExchangeState();
}

class CaseExchangeState extends State<CaseExchange> {
  ApiServices apiServices = ApiServices();

  List casesList = [];
  List filteredCasesList = [];
  List caseLikesList = [];
  List<DoctorSpecialityModel> doctorSpeciality = [];

  var memberId;

  int caseCount = 0;

  bool hasBeenPressed = false;

  var dropdownValue = "All";
  var selectedSpecialityId = 0;

  // List<Map<String, dynamic>> caseTypeList = [
  //   {"specialityID": 0, "specialityName": 'All'}
  // ];

  List<DoctorSpecialityModel> caseTypeList = [];

  fetchSpeciality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId = prefs.getInt('doctorMemberId');
    print('member id $memberId');
    doctorSpeciality = await apiServices.fetchSpeciality();
    caseTypeList.add(DoctorSpecialityModel.fromJson({
      "specialityID": 0,
      "specialityName": "All",
      "specialityDetail": "initial value"
    }));

    if (doctorSpeciality.length > 0) {
      for (var item in doctorSpeciality) {
        setState(() {
          caseTypeList.add(item);
        });
      }
    }
  }

  fetchCases() async {
    var cases = await apiServices.fetchCases();

    for (var item in cases) {
      if (item.caseExchangeId != 0) {
        List<dynamic> likesList = [];
        List<dynamic> commentList = [];
        List<dynamic> photoList = [];
        Map caseMap = Map();
        var caseExchangeId = item.caseExchangeId;

        ApiResponse likeResponse =
            await apiServices.fetchCaseLikes(caseExchangeId);
        if (likeResponse.data != null) {
          likesList = likeResponse.data as List<dynamic>;
        }

        ApiResponse commentResponse =
            await apiServices.fetchCaseComments(caseExchangeId);
        if (commentResponse.data != null) {
          commentList = commentResponse.data as List<dynamic>;
        }

        ApiResponse photoResponse =
            await apiServices.fetchCasePhotos(caseExchangeId);
        if (photoResponse.data != null) {
          photoList = photoResponse.data as List<dynamic>;
        }

        caseMap['doctorID'] = item.doctorID;
        caseMap['memberID'] = item.memberID;
        caseMap['doctorName'] = item.doctorName;
        caseMap['eduQualificationID'] = item.eduQualificationID;
        caseMap['profilePicture'] = getDoctorProfilePic(item.profilePicture);
        caseMap['heading'] = item.heading;
        caseMap['description'] = item.description;
        caseMap['isSave'] = item.isSave;
        caseMap['caseType'] = item.caseType;
        caseMap['dateTime'] = getDataAndTime(item.dateTime);
        caseMap['caseExchangeId'] = item.caseExchangeId;
        caseMap['specialityID'] = item.specialityID;
        caseMap['saveByMemberID'] = item.saveByMemberID;
        caseMap['likes_count'] = getCount(likesList.length);
        caseMap['comment_count'] = getCount(commentList.length);
        caseMap['self_liked'] = getLikedBy(likesList, item.memberID);
        caseMap['case_photos'] = photoList;

        setState(() {
          casesList.add(caseMap);
        });
      }
    }

    for (var item in casesList) {
      setState(() {
        filteredCasesList.add(item);
      });
    }

    setState(() {
      caseCount = filteredCasesList.length;
    });
  }

  getLikedBy(var likes, int memberId) {
    List selfLiked = [];
    for (var item in likes) {
      if (item.memberID == memberId) {
        print('match found');
        selfLiked.add(item);
      }
    }
    print('self liked length ${selfLiked.length}');
    if (selfLiked.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  getCount(int count) {
    if (count > 1000) {
      var number = (count / 1000).toStringAsFixed(1);
      return "$number" + "K";
    } else if (count > 1000000) {
      var number = (count / 1000000).toStringAsFixed(1);
      return "$number" + "M";
    } else if (count > 1000000000) {
      var number = (count / 1000000000).toStringAsFixed(1);
      return "$number" + "B";
    } else {
      return "$count";
    }
  }

  getDataAndTime(String dateTimeString) {
    var date = DateTime.parse(dateTimeString);

    var year = date.year;
    var month = date.month;
    var day = date.day;
    var newMonth = month < 10 ? '0$month' : '$month';
    var newDay = day < 10 ? '0$day' : '$day';

    var newDate = '$year-$newMonth-$newDay';
    var hour = date.hour;
    var minute = date.minute;
    var amPm = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : hour;
    var newHour = hour < 10 ? '0$hour' : '$hour';
    var newMinute = minute < 10 ? '0$minute' : '$minute';
    var newTime = '$newHour:$newMinute $amPm';

    var newDateTime = '$newDate, $newTime';
    return newDateTime;
  }

  filterCasesById(var specialityId) {
    if (specialityId == 0) {
      filteredCasesList.clear();
      casesList.clear();
      fetchCases();
    } else {
      filteredCasesList.clear();
      for (var item in casesList) {
        if (item['specialityID'] == specialityId) {
          setState(() {
            filteredCasesList.add(item);
          });
        }
      }
      setState(() {
        caseCount = filteredCasesList.length;
      });
    }
  }

  @override
  void initState() {
    fetchSpeciality();
    fetchCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 5.0,
      backgroundColor: kBaseColor,
      centerTitle: true,
      toolbarHeight: 50,
      leading: IconButton(
        color: kTitleColor,
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back),
      ),
      title: Text('Case Exchange',
          style:
              TextStyle(fontFamily: 'Segoe', fontSize: 18, color: kTitleColor)),
      actions: <Widget>[
        SizedBox(
          width: 10,
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: PopupMenuButton(
            padding: EdgeInsets.only(left: 0.0, right: 10.0),
            child: Container(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.more_vert_rounded,
                color: kTitleColor,
              ),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'SavedCase',
                  height: 30,
                  child: Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text('Saved Case'),
                  ),
                ),
              ];
            },
            onSelected: (dynamic result) {
              if (result == 'SavedCase') {
                Navigator.of(context).pushNamed(SavedCase.tag);
              }
            },
          ),
        ),
      ],
    );
    final writeNewCase = Container(
      height: 60,
      width: 410,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateCase.tag);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
        color: kBaseColor,
        child: Text('Write Your Case Here!',
            style: TextStyle(
                fontFamily: "Segoe",
                letterSpacing: 0.5,
                fontSize: 15,
                color: kTitleColor,
                fontWeight: FontWeight.w700)),
      ),
    );
    final categoryTotalLabel = Container(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 330,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  isExpanded: true,
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                    for (var item in caseTypeList) {
                      if (item.specialityName == newValue) {
                        setState(() {
                          selectedSpecialityId = item.specialityId!;
                        });
                        filterCasesById(item.specialityId);
                      }
                    }
                  },
                  items: caseTypeList.map((DoctorSpecialityModel data) {
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
          // Container(
          //   width: 200,
          //   height: 35,
          //   padding: EdgeInsets.only(left: 5),
          //   child: DropdownButtonFormField(
          //     decoration: new InputDecoration(
          //       hintText: "All",
          //       contentPadding: EdgeInsets.fromLTRB(15.0, 2.0, 5.0, 0.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //     items: <DropdownMenuItem>[
          //       DropdownMenuItem<int>(
          //         value: 1,
          //         child: Text("All"),
          //       ),
          //       DropdownMenuItem<int>(
          //         value: 2,
          //         child: Text("Pediatrician"),
          //       ),
          //     ],
          //     onChanged: (dynamic val) => print(val),
          //     onSaved: (dynamic val) => print(val),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 5),
            child: Text(
              '( $caseCount ) case found',
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 15,
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
    final verticalDivider = Container(
      child: const Divider(
        color: Colors.black,
        height: 0.0,
        thickness: 0.5,
        indent: 0.0,
        endIndent: 0.0,
      ),
    );

    final caseCardsList = Expanded(
      child: Container(
        child: filteredCasesList.length > 0
            ? ListView.builder(
                itemCount: filteredCasesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding:
                        EdgeInsets.only(left: 8, top: 2, right: 8, bottom: 2),
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
                              height: 80,
                              color: kCardTitleColor,
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  top: 2,
                                                  right: 10,
                                                  bottom: 4),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 10),
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.blue),
                                                  image: DecorationImage(
                                                    image: (filteredCasesList
                                                                .length >
                                                            0
                                                        ? (filteredCasesList[index]['profilePicture'] ==
                                                                    null ||
                                                                filteredCasesList[index][
                                                                        'profilePicture'] ==
                                                                    'null' ||
                                                                filteredCasesList[index][
                                                                        'profilePicture'] ==
                                                                    ''
                                                            ? AssetImage(
                                                                patientNoImagePath)
                                                            : NetworkImage(
                                                                filteredCasesList[index]
                                                                    [
                                                                    'profilePicture']))
                                                        : AssetImage(
                                                            patientNoImagePath)) as ImageProvider<
                                                        Object>,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Text(
                                                      filteredCasesList[index]
                                                          ['doctorName'],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Segoe',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kBaseColor),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      filteredCasesList[index][
                                                                      'eduQualificationID'] ==
                                                                  null ||
                                                              filteredCasesList[
                                                                          index]
                                                                      [
                                                                      'eduQualificationID'] ==
                                                                  'null' ||
                                                              filteredCasesList[
                                                                          index]
                                                                      [
                                                                      'eduQualificationID'] ==
                                                                  ''
                                                          ? ''
                                                          : filteredCasesList[
                                                                  index][
                                                              'eduQualificationID'],
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Segoe',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 135),
                                        Container(
                                          width: 25,
                                          height: 60,
                                          padding: EdgeInsets.only(
                                              top: 15, right: 10),
                                          child: PopupMenuButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(
                                              Icons.more_vert_rounded,
                                              size: 28,
                                            ),
                                            itemBuilder:
                                                (BuildContext context) {
                                              return [
                                                PopupMenuItem<String>(
                                                  value: 'Save',
                                                  height: 25,
                                                  mouseCursor:
                                                      MouseCursor.defer,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text('Save'),
                                                  ),
                                                ),
                                              ];
                                            },
                                            onSelected: (dynamic result) {
                                              if (result == 'Save') {
                                                Navigator.of(context)
                                                    .pushNamed('');
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    padding: EdgeInsets.only(bottom: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 12),
                                              width: 15,
                                              height: 25,
                                              child: Image.asset(
                                                'assets/icons/doctor/category.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 4),
                                              child: Text(
                                                filteredCasesList[index]
                                                                ['caseType'] ==
                                                            null ||
                                                        filteredCasesList[index]
                                                                ['caseType'] ==
                                                            '' ||
                                                        filteredCasesList[index]
                                                                ['caseType'] ==
                                                            'null'
                                                    ? ''
                                                    : filteredCasesList[index]
                                                        ['caseType'],
                                                style: TextStyle(
                                                  fontFamily: 'Segoe',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 8, right: 15),
                                          child: Row(
                                            children: [
                                              Icon(Icons.access_time,
                                                  size: 16,
                                                  color: kBodyTextColor),
                                              SizedBox(
                                                width: 2.0,
                                              ),
                                              Text(
                                                filteredCasesList[index]
                                                                ['dateTime'] ==
                                                            null ||
                                                        filteredCasesList[index]
                                                                ['dateTime'] ==
                                                            'null' ||
                                                        filteredCasesList[index]
                                                                ['dateTime'] ==
                                                            ''
                                                    ? ''
                                                    : filteredCasesList[index]
                                                        ['dateTime'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: kBodyTextColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, top: 4, right: 2, bottom: 4),
                              child: Row(
                                children: [
                                  Container(
                                    height: 28,
                                    child: VerticalDivider(
                                      color: Colors.black54,
                                      thickness: 1.8,
                                    ),
                                  ),
                                  Container(
                                    child: Expanded(
                                      child: Text(
                                        filteredCasesList[index]['heading'] ==
                                                    null ||
                                                filteredCasesList[index]
                                                        ['heading'] ==
                                                    'null' ||
                                                filteredCasesList[index]
                                                        ['heading'] ==
                                                    ''
                                            ? ''
                                            : filteredCasesList[index]
                                                ['heading'],
                                        style: TextStyle(
                                          fontFamily: 'Nunita',
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: kButtonColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 55,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      filteredCasesList[index]['description'] ==
                                                  null ||
                                              filteredCasesList[index]
                                                      ['description'] ==
                                                  'null' ||
                                              filteredCasesList[index]
                                                      ['description'] ==
                                                  ''
                                          ? ''
                                          : filteredCasesList[index]
                                              ['description'],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'Segoe',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, top: 0.0, right: 10, bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: 168,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/doctor/covid19.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    width: 168,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/doctor/covid19.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              height: 0.0,
                              thickness: 1,
                              indent: 0.0,
                              endIndent: 0.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20, top: 5, right: 10, bottom: 2),
                              child: Row(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
                                          child: FloatingActionButton(
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                            heroTag: 'heroLike$index',
                                            child: Icon(
                                              filteredCasesList[index]
                                                      ['self_liked']
                                                  ? Icons.favorite
                                                  : Icons.favorite_outline,
                                              color: Colors.pink,
                                            ),
                                            onPressed: () async {
                                              ApiResponse apiResponse =
                                                  ApiResponse();

                                              apiResponse =
                                                  await apiServices.likeUnlike(
                                                      filteredCasesList[index]
                                                          ['caseExchangeId'],
                                                      memberId);
                                              if (apiResponse.error == null) {
                                                fetchCases();
                                              }
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${filteredCasesList[index]['likes_count']}',
                                            // '3.5k',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed(CaseDetails.tag);
                                            },
                                            backgroundColor: Colors.white,
                                            heroTag: 'heroComment$index',
                                            elevation: 0,
                                            child: Icon(
                                                Icons.mode_comment_outlined),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${filteredCasesList[index]['comment_count']}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    child: FloatingActionButton(
                                      onPressed: () {},
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      heroTag: 'heroShare$index',
                                      child: Icon(Icons.share_rounded),
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
                },
              )
            : Center(
                child: Text(
                  'No Cases found right now',
                  style: TextStyle(fontSize: 16, color: kBodyTextColor),
                ),
              ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          writeNewCase,
          categoryTotalLabel,
          verticalDivider,
          caseCardsList,
        ],
      ),
    );
  }
}

class CaseTypeModel {
  late String specialityID;
  late String specialityName;

  CaseTypeModel({required this.specialityID, required this.specialityName});

  CaseTypeModel.fromJson(Map<String, dynamic> json) {
    specialityID = json['specialityID'];
    specialityName = json['specialityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specialityID'] = this.specialityID;
    data['specialityName'] = this.specialityName;
    return data;
  }
}
