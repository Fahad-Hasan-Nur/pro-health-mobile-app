import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityStatus extends StatefulWidget {
  final memberId;
  final phone;
  ActivityStatus({Key? key, this.title, this.memberId, this.phone})
      : super(key: key);
  final String? title;
  static String tag = 'ActivityStatus';
  @override
  ActivityStatusState createState() =>
      new ActivityStatusState(memberId: this.memberId, phone: this.phone);
}

class ActivityStatusState extends State<ActivityStatus> {
  final memberId;
  final phone;
  ActivityStatusState({
    this.memberId,
    this.phone,
  });

  ApiServices apiServices = ApiServices();

  bool active = true;
  bool inActive = false;
  bool automatic = false;
  String networkImage = '';
  bool isOnline = true;

  late bool automaticActivity;

  fetchDoctorInfo() async {
    var doctorInfo = await apiServices.fetchDoctorInfo(phone);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    automaticActivity = prefs.getBool('doctorActivityAutomatic') ?? false;
    if (doctorInfo.length > 0) {
      if (automaticActivity) {
        setState(() {
          automatic = true;
          active = false;

          inActive = false;
        });
      } else {
        if (doctorInfo[0]!['isOnline']) {
          setState(() {
            active = true;
            isOnline = true;
            inActive = false;
          });
        } else {
          setState(() {
            isOnline = false;
            active = false;
            inActive = true;
          });
        }
      }
      getDoctorProfilePic(doctorInfo[0]!['profilePicture'] ?? '');
    }
  }

  getDoctorProfilePic(String? imgString) {
    if (imgString == null || imgString == '' || imgString == 'null') {
      return null;
    } else {
      var newzero = imgString.substring(0, imgString.indexOf('files'));
      var newfirst = imgString.substring(imgString.indexOf('files') + 6);
      var newsecond = newfirst.substring(0, newfirst.indexOf('-media'));
      var newthird = newfirst.substring(newfirst.indexOf('token'));

      var newfullString =
          newzero + 'files%2F' + newsecond + '?alt=media&' + newthird;

      setState(() {
        networkImage = newfullString;
      });
    }
  }

  setDoctorActiveStatus(var status) async {
    await apiServices.setDoctorActiveStatus(status, memberId);
  }

  @override
  void initState() {
    fetchDoctorInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activityStatusLogo = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                image: DecorationImage(
                  image: networkImage.isEmpty
                      ? AssetImage(noImagePath)
                      : NetworkImage(networkImage) as ImageProvider<Object>,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 2,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline ? Color(0xff6ECEC0) : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    final activeStatusTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Active Status',
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

    final activeStatusButton = Padding(
      padding: EdgeInsets.only(left: 15.0, top: 35.0, right: 10.0, bottom: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  "Active",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: FlutterSwitch(
                  width: 50.0,
                  height: 25.0,
                  valueFontSize: 12.0,
                  toggleSize: 18.0,
                  activeColor: kBaseColor,
                  value: active,
                  onToggle: (val) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      active = val;
                      isOnline = val;
                      inActive = !val;
                    });
                    setDoctorActiveStatus(val);
                    if (val) {
                      setState(() {
                        automatic = false;
                      });
                      prefs.setBool('doctorActivityAutomatic', false);
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
    final inActiveStatusButton = Padding(
      padding: EdgeInsets.only(left: 15.0, top: 2.0, right: 10.0, bottom: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerRight,
                child: Text("Inactive", style: TextStyle(fontSize: 16)),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: FlutterSwitch(
                  width: 50.0,
                  height: 25.0,
                  valueFontSize: 12.0,
                  toggleSize: 18.0,
                  activeColor: kBaseColor,
                  value: inActive,
                  onToggle: (val) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      inActive = val;
                      isOnline = !val;
                      active = !val;
                    });
                    setDoctorActiveStatus(!val);
                    if (val) {
                      setState(() {
                        automatic = false;
                      });
                      prefs.setBool('doctorActivityAutomatic', false);
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
    final automaticButton = Padding(
      padding: EdgeInsets.only(left: 15.0, top: 2.0, right: 10.0, bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerRight,
                child: Text("Automatic", style: TextStyle(fontSize: 16)),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: FlutterSwitch(
                  width: 50.0,
                  height: 25.0,
                  valueFontSize: 12.0,
                  toggleSize: 18.0,
                  activeColor: kBaseColor,
                  value: automatic,
                  onToggle: (val) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    setState(() {
                      automatic = val;
                    });
                    if (val) {
                      prefs.setBool('doctorActivityAutomatic', true);
                      setState(() {
                        active = !val;
                        isOnline = val;
                        inActive = !val;
                      });
                      setDoctorActiveStatus(true);
                    } else {
                      prefs.setBool('doctorActivityAutomatic', false);
                      fetchDoctorInfo();
                    }
                  },
                ),
              )
            ],
          ),
        ],
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
        title: Text('User Status',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            activityStatusLogo,
            activeStatusTitle,
            verticalDivider,
            activeStatusButton,
            inActiveStatusButton,
            automaticButton,
          ],
        ),
      ),
    );
  }
}
