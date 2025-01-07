import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pro_health/base/utils/constants.dart';

class CaseDetails extends StatefulWidget {
  static String tag = 'CaseDetails';
  @override
  CaseDetailsState createState() => new CaseDetailsState();
}

class CaseDetailsState extends State<CaseDetails> {
  bool hasBeenPressed = false;
  File? myImage;
  Future openCamera() async {
    // ignore: deprecated_member_use
    var cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      myImage = File(cameraImage!.path);
    });
  }

  List<Asset> images = <Asset>[];
  @override
  void initState() {
    super.initState();
  }

  Future<void> addPhotos() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
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
        'Case Details',
        style: TextStyle(fontFamily: 'Segoe', fontSize: 18, color: kTitleColor),
      ),
    );
    final caseDetailsCard = Container(
      padding: EdgeInsets.only(left: 8, top: 2, right: 8, bottom: 2),
      child: Card(
        margin: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        color: kBackgroundColor,
        elevation: 0.0,
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
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, right: 10, bottom: 4),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: kBaseColor,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15.0,
                                child: Image.asset('assets/doctorimg.png'),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Prof. Mohammed Hanif',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Segoe',
                                        fontWeight: FontWeight.bold,
                                        color: kBaseColor),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'MBBS, FCPS, FRCP (Edin)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Segoe',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 135),
                          Container(
                            width: 30,
                            height: 60,
                            padding: EdgeInsets.only(top: 15),
                            child: PopupMenuButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.more_vert_rounded,
                                size: 28,
                              ),
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'Remove',
                                    height: 30,
                                    mouseCursor: MouseCursor.defer,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('Remove'),
                                    ),
                                  ),
                                ];
                              },
                              onSelected: (dynamic result) {
                                if (result == 'Remove') {
                                  Navigator.of(context).pushNamed('');
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
                        children: [
                          Container(
                            width: 140,
                            padding: EdgeInsets.only(left: 30),
                            child: Row(
                              children: [
                                Container(
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
                                    'Pediatrician',
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
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 70.0, top: 8),
                            child: Row(
                              children: [
                                Icon(Icons.access_time,
                                    size: 16, color: kBodyTextColor),
                                SizedBox(
                                  width: 2.0,
                                ),
                                Text(
                                  '21 Feb 2021, 6:00 PM',
                                  style: TextStyle(
                                      fontSize: 12, color: kBodyTextColor),
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
                padding: EdgeInsets.only(left: 0, top: 4, right: 2, bottom: 4),
                child: Row(
                  children: [
                    Container(
                      height: 28,
                      child: VerticalDivider(
                        color: Colors.black54,
                        thickness: 2.0,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Corona virus (Covid-19) Guide for parents',
                        style: TextStyle(
                          fontFamily: 'Nunita',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kButtonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 10, top: 2, right: 10, bottom: 5),
                child: Expanded(
                  child: Text(
                    'As a parent, you want to do everything you can to protect your '
                    'child. The coronavirus disease (COVID-19) pandemic has brought'
                    ' with it new challenges for families across the globe. UNICEF '
                    'Parenting is here to be your partner in navigating this health '
                    'crisis by providing you with accurate, reliable information on '
                    'the best ways to keep your family safe...',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                          image: AssetImage('assets/icons/doctor/covid19.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                          image: AssetImage('assets/icons/doctor/covid19.png'),
                          fit: BoxFit.cover)),
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
                padding:
                    EdgeInsets.only(left: 20, top: 5, right: 10, bottom: 2),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            child: FloatingActionButton(
                              backgroundColor: kBackgroundColor,
                              elevation: 0,
                              child: Icon(
                                hasBeenPressed
                                    ? Icons.favorite_border_rounded
                                    : Icons.favorite,
                                color: hasBeenPressed ? null : Colors.pink,
                              ),
                              onPressed: () {
                                setState(() {
                                  hasBeenPressed = !hasBeenPressed;
                                });
                              },
                            ),
                          ),
                          Container(
                            child: Text(
                              '3.5k',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
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
                              onPressed: () {},
                              backgroundColor: kBackgroundColor,
                              elevation: 0,
                              child: Icon(Icons.mode_comment_outlined),
                            ),
                          ),
                          Container(
                            child: Text(
                              '2.5k',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
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
                        backgroundColor: kBackgroundColor,
                        elevation: 0,
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
    final commentBar = Container(
      height: 60,
      padding: EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 8),
      width: double.infinity,
      color: kTitleColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Type your comment here...",
                hintStyle: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                suffixIcon: Container(
                  height: 30,
                  width: 30,
                  padding: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    onPressed: () {
                      addPhotos();
                    },
                    child: Icon(
                      Icons.attach_file_rounded,
                      color: Colors.grey[800],
                      size: 25,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 50,
            padding: EdgeInsets.all(3),
            child: FloatingActionButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                openCamera();
              },
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.grey[800],
                size: 25,
              ),
              backgroundColor: kTitleColor,
              elevation: 0,
            ),
          ),
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(1),
            child: Center(
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.send,
                  color: Colors.grey[800],
                  size: 25,
                ),
                backgroundColor: kTitleColor,
                elevation: 1,
              ),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: caseDetailsCard,
              ),
            ),
            commentBar,
          ],
        ),
      ),
    );
  }
}
