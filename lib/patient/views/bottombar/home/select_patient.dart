// ignore_for_file: deprecated_member_use, unused_local_variable, unused_field, unnecessary_null_comparison

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/models/payment_method.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/widgets/CustomAlert.dart';
import 'package:pro_health/patient/models/patient_relatives.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
import 'package:pro_health/patient/service/dashboard/profile_service.dart';
import 'package:pro_health/patient/views/bottombar/appointment/payment_page.dart';
import 'package:pro_health/patient/views/bottombar/home/request_approval.dart';
import 'package:uuid/uuid.dart';

class SelectPatient extends StatefulWidget {
  SelectPatient({Key? key, this.title, required this.doctorInfo})
      : super(key: key);
  final String? title;
  static String tag = 'SelectPatient';
  final Map<String, dynamic> doctorInfo;

  @override
  SelectPatientState createState() =>
      new SelectPatientState(doctorInfo: this.doctorInfo);
}

class SelectPatientState extends State<SelectPatient> {
  SelectPatientState({required this.doctorInfo});
  PatientProfileService patientProfileService = PatientProfileService();
  List<PatientRelativesModel> relatives = [];

  final Map<String, dynamic> doctorInfo;

  bool isSelf = true;
  bool isLoading = false;
  bool savingAppointment = false;

  ApiServices apiServices = ApiServices();
  PatientApiService patientApiService = PatientApiService();

  final picker = ImagePicker();
  final _createAppointmentkey = GlobalKey<FormState>();

  bool _isUploading = false;

  int selectedIndex = -1;

  String name = '';
  String relationship = '';
  String age = '';
  String weight = '';
  String gender = '';
  String problem = '';

  bool newPatient = false;

  TextEditingController relativeNameController = TextEditingController();
  TextEditingController relativeAgeController = TextEditingController();
  TextEditingController relativeWeightController = TextEditingController();
  TextEditingController relativeProblemController = TextEditingController();

  // addImage() {
  //   Navigator.of().push(
  //     MaterialPageRoute(
  //       builder: (_) => AddImagePage(),
  //     ),
  //   );
  // }

  File? myImage;
  Future openCamera() async {
    var cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      myImage = File(cameraImage!.path);
    });
  }

  List<MultipartFile> multipart = [];

  List<Asset> images = <Asset>[];
  List<File> _imageDataList = [];
  List<File> _cameraImageList = [];

  List<Asset> resultList = <Asset>[];

  addImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _cameraImageList.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) return retrieveLostData();
    convertImage();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _cameraImageList.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future<void> addPhotos() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          statusBarColor: "#01619B",
          actionBarColor: "#01619B",
          actionBarTitle: "All Photos",
          allViewTitle: "Selected Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#01619B",
        ),
      );
    } on Exception {}
    if (!mounted) return;
    setState(() {
      images = resultList;
    });
    convertImage();
  }

  convertImage() async {
    final temp = await Directory.systemTemp.createTemp();
    if (_imageDataList.length > 0) {
      _imageDataList.clear();
    }
    for (var item in images) {
      var ext = item.name!.split('.').last;
      var time = DateTime.now().toIso8601String();
      var random = Random().nextInt(10000);
      var uuid = Uuid();
      var v1 = uuid.v1();
      var fileName = v1 + random.toString() + time;
      final data = await item.getByteData();

      var newFile = await File('${temp.path}/img-$fileName.$ext').writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );

      setState(() {
        _imageDataList.add(newFile);
      });
    }
    for (var item in _cameraImageList) {
      setState(() {
        _imageDataList.add(item);
      });
    }
  }

  getRelatives() async {
    var response = await patientApiService.fetchPatientRelatives();
    if (response.isNotEmpty) {
      if (relatives.isNotEmpty) {
        setState(() {
          relatives.clear();
          relatives.addAll(response);
        });
      } else {
        setState(() {
          relatives.addAll(response);
        });
      }
    }
  }

  void removeRemainingRelatives() {
    for (var item in relatives) {
      int index = relatives.indexOf(item);
      if (index != selectedIndex) {
        setState(() {
          relatives.removeAt(index);
          selectedIndex = 0;
        });
      }
    }
  }

  @override
  void initState() {
    getRelatives();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      accentColor: kBaseColor,
      dividerColor: Colors.transparent,
    );

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
                              image: (doctorInfo['doctorPic'] == 'null' ||
                                          doctorInfo['doctorPic'].isEmpty
                                      ? AssetImage(noImagePath)
                                      : NetworkImage(doctorInfo['doctorPic']))
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
                                      '${doctorInfo['doctorName']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${doctorInfo['qualification']}',
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
                        '${doctorInfo['rating']}',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        child: RatingStars(
                          value: doctorInfo['rating'],
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

    final selfPatient = MaterialButton(
      onPressed: () {
        setState(() {
          isSelf = !isSelf;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 28.0,
              color: isSelf ? kBaseColor : Colors.grey,
            ),
            SizedBox(width: 10),
            Text(
              'Self',
              style: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTitleTextColor,
              ),
            ),
          ],
        ),
      ),
    );

    final selfCard = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: TextFormField(
              onChanged: (val) => problem = val,
              validator: RequiredValidator(errorText: 'Problem is Required'),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Describe the problem',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              maxLines: 3,
              scrollPadding: const EdgeInsets.all(20),
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 0.8, color: kTextLightColor),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 4),
                  child: Text(
                    'Add photos',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    child: Text(
                  '(Max No. of photos: 10)',
                  style: TextStyle(
                    height: 2,
                    fontFamily: 'Segoe',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                SizedBox(
                  width: 80,
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: IconButton(
                    padding: new EdgeInsets.only(
                        left: 5, top: 5, right: 5, bottom: 5),
                    splashRadius: 20,
                    icon: Image.asset('assets/icons/patient/camera.png'),
                    onPressed: () {
                      addImageFromCamera();
                    },
                  ),
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: IconButton(
                    padding: new EdgeInsets.only(
                        left: 5, top: 5, right: 5, bottom: 5),
                    splashRadius: 20,
                    icon: Image.asset('assets/icons/patient/addphotos.png'),
                    onPressed: () {
                      addPhotos();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final othersPatient = MaterialButton(
      onPressed: () {
        setState(() {
          isSelf = !isSelf;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 28.0,
              color: isSelf ? Colors.grey : kBaseColor,
            ),
            SizedBox(width: 10),
            Text(
              'Others',
              style: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTitleTextColor,
              ),
            ),
          ],
        ),
      ),
    );

    final relativeList = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: relatives.length,
                itemBuilder: (BuildContext context, int index) {
                  bool lastPosition = (relatives.length - index) == 1;

                  PatientRelativesModel patientRelative = relatives[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            name = patientRelative.name ?? '';
                            relationship = patientRelative.relationship ?? '';
                            age = patientRelative.age ?? '';
                            gender = patientRelative.gender ?? '';
                            weight = patientRelative.weight ?? '';
                            relativeNameController.clear();
                            relativeAgeController.clear();
                            relativeWeightController.clear();
                            relativeProblemController.clear();
                          });
                        },
                        onDoubleTap: () {
                          setState(() {
                            selectedIndex = -1;
                          });
                          getRelatives();
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side: BorderSide(color: Colors.grey),
                          ),
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            // height: 110,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      // height: 110,
                                      height: 110,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: selectedIndex == index
                                              ? kBaseColor
                                              : Colors.grey,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Table(
                                        // border: TableBorder.all(color: Color(0xFFD2DBDB)),
                                        columnWidths: const {
                                          0: FractionColumnWidth(.25),
                                          1: FractionColumnWidth(.75),
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              Text(
                                                "Name: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF525252),
                                                ),
                                              ),
                                              Text(
                                                  '${patientRelative.name ?? ''}'),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Text(
                                                "Relation: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF525252),
                                                ),
                                              ),
                                              Text(
                                                  '${patientRelative.relationship ?? ''}'),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Text(
                                                "Sex: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF525252),
                                                ),
                                              ),
                                              Text(
                                                  '${patientRelative.gender ?? ''}'),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Text(
                                                "Age: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF525252),
                                                ),
                                              ),
                                              Text(
                                                  '${patientRelative.age ?? ''} Y'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                selectedIndex == index
                                    ? Divider(color: Colors.grey)
                                    : Container(),
                                selectedIndex == index
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.multiline,
                                                controller:
                                                    relativeProblemController,
                                                onChanged: (value) =>
                                                    problem = value,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Describe the problem',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                ),
                                                maxLines: 3,
                                                scrollPadding:
                                                    const EdgeInsets.all(20),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    width: 0.8,
                                                    color: kTextLightColor),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 4),
                                                    child: Text(
                                                      'Add photos',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      child: Text(
                                                    '(Max No. of photos: 10)',
                                                    style: TextStyle(
                                                      height: 2,
                                                      fontFamily: 'Segoe',
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )),
                                                  SizedBox(
                                                    width: 80,
                                                  ),
                                                  SizedBox(
                                                    height: 36,
                                                    width: 36,
                                                    child: IconButton(
                                                      padding:
                                                          new EdgeInsets.only(
                                                              left: 5,
                                                              top: 5,
                                                              right: 5,
                                                              bottom: 5),
                                                      splashRadius: 20,
                                                      icon: Image.asset(
                                                          'assets/icons/patient/camera.png'),
                                                      onPressed: () {
                                                        addImageFromCamera();
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 36,
                                                    width: 36,
                                                    child: IconButton(
                                                      padding:
                                                          new EdgeInsets.only(
                                                              left: 5,
                                                              top: 5,
                                                              right: 5,
                                                              bottom: 5),
                                                      splashRadius: 20,
                                                      icon: Image.asset(
                                                          'assets/icons/patient/addphotos.png'),
                                                      onPressed: () {
                                                        addPhotos();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      lastPosition
                          ? Card(
                              color: kBaseColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: IconButton(
                                // padding: EdgeInsets.zero,
                                padding: const EdgeInsets.all(3),
                                constraints: BoxConstraints(),
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    relatives.clear();
                                    newPatient = true;
                                  });
                                },
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    final othersCard = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 50,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: relativeNameController,
                onChanged: (val) => name = val,
                decoration: InputDecoration(
                  hintText: 'Name:',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: DropdownButtonFormField(
                decoration: new InputDecoration(
                  hintText: 'Relationship:',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                icon: Icon(Icons.arrow_drop_down_circle_outlined),
                isExpanded: true,
                items: <DropdownMenuItem>[
                  DropdownMenuItem<String>(
                    value: "Father",
                    child: Text("Father"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Mother",
                    child: Text("Mother"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Sister",
                    child: Text("Sister"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Brother",
                    child: Text("Brother"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Son",
                    child: Text("Son"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Daughter",
                    child: Text("Daughter"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Grandfather",
                    child: Text("Grandfather"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Grandmother",
                    child: Text("Grandmother"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Father-in-law",
                    child: Text("Father-in-law"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Mother-in-law",
                    child: Text("Mother-in-law"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Son-in-law",
                    child: Text("Son-in-law"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Daughter-in-law",
                    child: Text("Daughter-in-law"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Friends",
                    child: Text("Friends"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Others",
                    child: Text("Others"),
                  ),
                ],
                onChanged: (dynamic val) => relationship = val,
                onSaved: (dynamic val) => relationship = val,
              ),
            ),
          ),
          Container(
            height: 50,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: relativeAgeController,
                onChanged: (val) => age = val,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Age (Years):',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: relativeWeightController,
                onChanged: (val) => weight = val,
                decoration: InputDecoration(
                  hintText: 'Weight (kg):',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: DropdownButtonFormField(
                decoration: new InputDecoration(
                  hintText: 'Sex:',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                icon: Icon(Icons.arrow_drop_down_circle_outlined),
                isExpanded: true,
                isDense: true,
                elevation: 5,
                items: <DropdownMenuItem>[
                  DropdownMenuItem<String>(
                    value: "Male",
                    child: Text("Male"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Female",
                    child: Text("Female"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Others",
                    child: Text("Others"),
                  ),
                ],
                onChanged: (dynamic val) => gender = val,
                onSaved: (dynamic val) => gender = val,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              controller: relativeProblemController,
              onChanged: (val) => problem = val,
              decoration: InputDecoration(
                hintText: 'Describe the problem',
                hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              maxLines: 2,
              scrollPadding: const EdgeInsets.all(20),
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 0.8, color: kTextLightColor),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 4),
                  child: Text(
                    'Add photos',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '(Max No. of photos: 10)',
                    style: TextStyle(
                      height: 2,
                      fontFamily: 'Segoe',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: IconButton(
                    padding: new EdgeInsets.only(
                        left: 5, top: 5, right: 5, bottom: 5),
                    icon: Image.asset('assets/icons/patient/camera.png'),
                    onPressed: () {
                      // openCamera();
                      addImageFromCamera();
                    },
                  ),
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: IconButton(
                    padding: new EdgeInsets.only(
                        left: 5, top: 5, right: 5, bottom: 5),
                    icon: Image.asset('assets/icons/patient/addphotos.png'),
                    onPressed: () {
                      addPhotos();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Or',
                  style: TextStyle(color: kBaseColor, fontSize: 22),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              getRelatives();
              newPatient = false;
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 0.8, color: kTextLightColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Select from Existing Members',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.arrow_drop_down_circle_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final proceedButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 80),
      child: MaterialButton(
        onPressed: () async {
          if (_createAppointmentkey.currentState!.validate()) {
            _createAppointmentkey.currentState!.save();

            // setState(() {
            //   savingAppointment = true;
            // });
            int patientId = await getPatientId();
            var patientValue =
                await patientProfileService.getPatientProfileInfo(patientId);

            List<String> imageStringList = [];

            for (var item in _imageDataList) {
              String imageStr = getStringImage(item) ?? '';
              imageStringList.add(imageStr);
            }

            if (isSelf) {
              Map<String, dynamic> createAppointmentMap = {};

              createAppointmentMap['doctorId'] = widget.doctorInfo['doctorId'];
              createAppointmentMap['memberId'] = widget.doctorInfo['memberId'];
              createAppointmentMap['problem'] = problem;
              createAppointmentMap['name'] = patientValue.patientName ?? '';
              createAppointmentMap['status'] = 'pending';
              createAppointmentMap['selfOrOthers'] = 'self';

              await patientApiService
                  .fetchPaymentMethods(widget.doctorInfo['memberId'])
                  .then((value) {
                String bkashPhone = '';
                String nagadPhone = '';
                String rocketPhone = '';
                List<String> bkashPhones = [];
                List<String> nagadPhones = [];
                List<String> rocketPhones = [];
                for (var item in value) {
                  if (item.paymentMode == bkash) {
                    bkashPhones.add(item.paymentPhone!);
                  } else if (item.paymentMode == nagad) {
                    nagadPhones.add(item.paymentPhone!);
                  } else if (item.paymentMode == rocket) {
                    rocketPhones.add(item.paymentPhone!);
                  }
                }
                if (bkashPhones.length == 1) {
                  bkashPhone = bkashPhones[0];
                } else if (bkashPhones.length > 1) {
                  bkashPhone = bkashPhones
                      .reduce((value, element) => '$value, $element');
                }

                print('bkashPhone $bkashPhone');

                if (nagadPhones.length == 1) {
                  nagadPhone = nagadPhones[0];
                } else if (nagadPhones.length > 1) {
                  nagadPhone = nagadPhones
                      .reduce((value, element) => '$value, $element');
                }

                print('nagadPhone $nagadPhone');

                if (rocketPhones.length == 1) {
                  rocketPhone = rocketPhones[0];
                } else if (rocketPhones.length > 1) {
                  rocketPhone = rocketPhones
                      .reduce((value, element) => '$value, $element');
                }

                print('rocketPhone $rocketPhone');

                Map<String, dynamic> paymentMethodMap = {
                  "bKash": bkashPhone,
                  "nagad": nagadPhone,
                  "rocket": rocketPhone,
                };
                Get.to(
                  () => PaymentPage(
                    doctorInfo: doctorInfo,
                    appointmentMap: createAppointmentMap,
                    paymentMethods: value,
                    paymentMethodMap: paymentMethodMap,
                    isSelf: true,
                    isNewPatient: false,
                    base64imageList: imageStringList,
                  ),
                  transition: Transition.rightToLeft,
                );
              });
            } else {
              Map<String, dynamic> createAppointmentMap = {};

              createAppointmentMap['doctorId'] = widget.doctorInfo['doctorId'];
              createAppointmentMap['memberId'] = widget.doctorInfo['memberId'];
              createAppointmentMap['name'] = name;
              createAppointmentMap['relationship'] = relationship;
              createAppointmentMap['age'] = age;
              createAppointmentMap['weight'] = weight;
              createAppointmentMap['gender'] = gender;
              createAppointmentMap['problem'] = problem;
              createAppointmentMap['status'] = 'pending';
              createAppointmentMap['selfOrOthers'] = 'others';

              await patientApiService
                  .fetchPaymentMethods(widget.doctorInfo['memberId'])
                  .then((value) {
                String bkashPhone = '';
                String nagadPhone = '';
                String rocketPhone = '';
                List<String> bkashPhones = [];
                List<String> nagadPhones = [];
                List<String> rocketPhones = [];
                for (var item in value) {
                  if (item.paymentMode == bkash) {
                    bkashPhones.add(item.paymentPhone!);
                  } else if (item.paymentMode == nagad) {
                    nagadPhones.add(item.paymentPhone!);
                  } else if (item.paymentMode == rocket) {
                    rocketPhones.add(item.paymentPhone!);
                  }
                }
                if (bkashPhones.length == 1) {
                  bkashPhone = bkashPhones[0];
                } else if (bkashPhones.length > 1) {
                  bkashPhone = bkashPhones
                      .reduce((value, element) => '$value, $element');
                }

                print('bkashPhone $bkashPhone');

                if (nagadPhones.length == 1) {
                  nagadPhone = nagadPhones[0];
                } else if (nagadPhones.length > 1) {
                  nagadPhone = nagadPhones
                      .reduce((value, element) => '$value, $element');
                }

                print('nagadPhone $nagadPhone');

                if (rocketPhones.length == 1) {
                  rocketPhone = rocketPhones[0];
                } else if (rocketPhones.length > 1) {
                  rocketPhone = rocketPhones
                      .reduce((value, element) => '$value, $element');
                }

                print('rocketPhone $rocketPhone');

                Map<String, dynamic> paymentMethodMap = {
                  "bKash": bkashPhone,
                  "nagad": nagadPhone,
                  "rocket": rocketPhone,
                };
                Get.to(
                  () => PaymentPage(
                    doctorInfo: doctorInfo,
                    appointmentMap: createAppointmentMap,
                    paymentMethods: value,
                    paymentMethodMap: paymentMethodMap,
                    isSelf: false,
                    isNewPatient: newPatient,
                    base64imageList: imageStringList,
                  ),
                  transition: Transition.rightToLeft,
                );
              });
            }

            // Map<String, dynamic> createAppointmentMap = {};

            // createAppointmentMap['doctorId'] = widget.doctorInfo['doctorId'];
            // createAppointmentMap['memberId'] = widget.doctorInfo['memberId'];
            // createAppointmentMap['problem'] = problem;
            // createAppointmentMap['status'] = 'pending';
            // createAppointmentMap['selfOrOthers'] = isSelf ? 'self' : 'others';

            // Get.to(() => PaymentPage(
            //       doctorInfo: doctorInfo,
            //       appointmentMap: createAppointmentMap,
            //     ));

            // var created =
            //     await patientApiService.createAppointment(createAppointmentMap);

            // if (created) {
            //   setState(() {
            //     savingAppointment = false;
            //   });
            //   Get.to(
            //     () => RequestApproval(
            //       createAppointmentMap: createAppointmentMap,
            //       doctorInfo: doctorInfo,
            //     ),
            //   );
            // } else {
            //   setState(() {
            //     savingAppointment = false;
            //   });
            //   showMyDialog(
            //     context,
            //     'Opps!',
            //     'Something went wrong, please try again later',
            //   );
            // }
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
            'Next',
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
              selfPatient,
              isSelf ? selfCard : Container(),
              othersPatient,
              !isSelf
                  ? relatives.isEmpty
                      ? othersCard
                      : relativeList
                  : Container(),
              _imageDataList.length > 0
                  ? Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemCount: _imageDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(_imageDataList[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: IconButton(
                                  onPressed: () {
                                    int cameraListIndex =
                                        index - resultList.length;

                                    int galleryListIndex =
                                        resultList.length - 1;
                                    if (index <= galleryListIndex) {
                                      setState(() {
                                        resultList.removeAt(index);
                                      });
                                    }
                                    if (cameraListIndex >= 0) {
                                      setState(() {
                                        _cameraImageList
                                            .removeAt(cameraListIndex);
                                      });
                                    }
                                    setState(() {
                                      _imageDataList.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete,
                                      color: Colors.redAccent),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : Container(),
              proceedButton,
            ],
          ),
        ),
      ),
    );
  }
}
