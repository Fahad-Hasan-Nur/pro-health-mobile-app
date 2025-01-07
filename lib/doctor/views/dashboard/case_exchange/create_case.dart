// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'dart:io';

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/models/doctor_speciality_model.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/add_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreateCase extends StatefulWidget {
  static String tag = 'CreateCase';

  @override
  CreateCaseState createState() => new CreateCaseState();
}

class CreateCaseState extends State<CreateCase> {
  ApiServices apiServices = ApiServices();
  final picker = ImagePicker();
  final _createCaseKey = GlobalKey<FormState>();

  int memberId = 0;
  int doctorId = 0;
  var doctorPhone;
  var dropdownValue;
  var selectedSpecialityId;

  bool _isUploading = false;

  String heading = '';
  String description = '';

  List doctorInfo = [];
  List<DoctorSpecialityModel> doctorSpeciality = [];
  List<DoctorSpecialityModel> caseTypeList = [];

  getDoctorInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId = prefs.getInt('doctorMemberId')!;
    doctorPhone = prefs.getString('doctorPhone');

    var doctor = await apiServices.fetchDoctorInfo(doctorPhone);

    setState(() {
      doctorInfo.addAll(doctor);
    });
    if (doctorInfo.isNotEmpty) {
      setState(() {
        doctorId = doctorInfo[0]['doctorID'];
      });
    }
  }

  addImage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddImagePage(),
      ),
    );
  }

  fetchSpeciality() async {
    doctorSpeciality = await apiServices.fetchSpeciality();
    // caseTypeList.add(DoctorSpecialityModel.fromJson({
    //   "specialityID": 0,
    //   "specialityName": "Select",
    //   "specialityDetail": "initial value"
    // }));

    if (doctorSpeciality.length > 0) {
      setState(() {
        dropdownValue = doctorSpeciality[0].specialityName;
        selectedSpecialityId = doctorSpeciality[0].specialityId;
      });
      for (var item in doctorSpeciality) {
        setState(() {
          caseTypeList.add(item);
        });
      }
    }
  }

  File? myImage;
  Future openCamera() async {
    // ignore: deprecated_member_use
    var cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      myImage = File(cameraImage!.path);
    });
  }

  List<MultipartFile> multipart = [];

  List<Asset> images = <Asset>[];
  List<File> _imageDataList = [];
  List<File> _cameraImageList = [];

  @override
  void initState() {
    getDoctorInfo();
    fetchSpeciality();
    super.initState();
  }

  List<Asset> resultList = <Asset>[];

  // Future<void> addImageFromCamera() async {

  // }

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
      title: Text(
        'Create Case',
        style: TextStyle(fontFamily: 'Segoe', fontSize: 18, color: kTitleColor),
      ),
    );
    final categoryTotalLabel = Container(
      padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 5),
            child: Text(
              'Select Case Type:',
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 16,
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
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
                  }
                }
                print(selectedSpecialityId);
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
    final caseExchangeBody = Expanded(
      child: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
              child: TextFormField(
                validator:
                    RequiredValidator(errorText: 'This field is required'),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Segoe',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'Heading...',
                  hintStyle: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Segoe',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onChanged: (val) => heading = val,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 10),
              child: TextFormField(
                validator:
                    RequiredValidator(errorText: 'This field is required'),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Write Here...',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Segoe',
                    fontWeight: FontWeight.bold,
                    color: kTextLightColor,
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                maxLines: 18,
                onChanged: (val) => description = val,
              ),
            ),
          ],
        ),
      ),
    );

    final casePublishBar = Container(
      height: 70,
      padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 20),
      color: kTitleColor,
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            padding: EdgeInsets.all(2),
            child: FloatingActionButton(
              heroTag: "addPhoto",
              backgroundColor: kTitleColor,
              elevation: 0,
              child: Image.asset('assets/icons/patient/addphotos.png'),
              onPressed: () {
                // addImage();
                addPhotos();
              },
            ),
          ),
          SizedBox(width: 5),
          Container(
            height: 36,
            width: 36,
            padding: EdgeInsets.all(2),
            child: FloatingActionButton(
              heroTag: "addPhotoCamera",
              backgroundColor: kTitleColor,
              elevation: 0,
              child: Image.asset('assets/icons/patient/camera.png'),
              onPressed: () {
                addImageFromCamera();
              },
            ),
          ),
          SizedBox(width: 115),
          Container(
            height: 40,
            width: 150,
            child: MaterialButton(
              onPressed: () async {
                List _caseList = [];
                if (_createCaseKey.currentState!.validate()) {
                  var caseExchangeID = 0;
                  setState(() {
                    _isUploading = true;
                  });

                  Map caseBody = Map();
                  caseBody['doctorId'] = doctorId;
                  caseBody['memberID'] = memberId;
                  caseBody['specialityID'] = selectedSpecialityId;
                  caseBody['caseType'] = dropdownValue;
                  caseBody['dateTime'] = DateTime.now().toIso8601String();
                  caseBody['heading'] = heading;
                  caseBody['description'] = description;
                  caseBody['isSave'] = false;
                  caseBody['saveByMemberID'] = 0;

                  var response = await apiServices
                      .createCase(caseBody)
                      .then((value) async {
                    print(value);
                    var receivedResponse = await apiServices.getCases(memberId);

                    if (receivedResponse.error == null) {
                      _caseList = receivedResponse.data as List<dynamic>;
                    } else {
                      print(receivedResponse.error.toString());
                    }

                    var lastCase = _caseList.last;
                    print(lastCase.caseExchangeId);
                    caseExchangeID = lastCase.caseExchangeId;
                  });
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
              color: Colors.white,
              child: _isUploading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Uploading'),
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator(),
                      ],
                    )
                  : Text(
                      'Publish',
                      style: TextStyle(
                        fontFamily: "Segoe",
                        letterSpacing: 0.5,
                        fontSize: 15,
                        color: kBodyTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Form(
          key: _createCaseKey,
          child: Column(
            children: [
              categoryTotalLabel,
              verticalDivider,
              caseExchangeBody,
              _imageDataList.length > 0
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
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
                                      setState(() {
                                        resultList.removeAt(index);
                                        _imageDataList.removeAt(index);
                                      });
                                    },
                                    icon: Icon(Icons.delete)),
                                // child: PopupMenuButton(
                                //   padding: EdgeInsets.zero,
                                //   icon: Icon(
                                //     Icons.more_vert_rounded,
                                //     size: 28,
                                //     color: Colors.white,
                                //   ),
                                //   itemBuilder: (BuildContext context) {
                                //     return [
                                //       PopupMenuItem<String>(
                                //         value: 'Save',
                                //         height: 25,
                                //         mouseCursor: MouseCursor.defer,
                                //         child: Container(
                                //           padding: EdgeInsets.only(left: 20),
                                //           child: Text('Save'),
                                //         ),
                                //       ),
                                //     ];
                                //   },
                                //   onSelected: (dynamic result) {
                                //     if (result == 'Save') {
                                //       Navigator.of(context).pushNamed('');
                                //     }
                                //   },
                                // ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : Container(),
              casePublishBar,
            ],
          ),
        ),
      ),
    );
  }
}
