import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:pro_health/doctor/views/bottombar/pharma_updates/NewBrand.dart';
import 'package:pro_health/doctor/views/bottombar/pharma_updates/PharmaNews.dart';
import 'package:pro_health/doctor/views/drawer/custom_drawer_doctor.dart';

class PharmaUpdates extends StatefulWidget {
  static String tag = 'PharmaUpdates';
  @override
  PharmaUpdatesState createState() => new PharmaUpdatesState();
}

class PharmaUpdatesState extends State<PharmaUpdates> {
  ApiServices apiServices = ApiServices();
  List pharmaNews = [];

  @override
  Widget build(BuildContext context) {
    final pharmaUpdateLogo = Container(
      padding: EdgeInsets.only(top: 2),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 35.0,
          child: Image.asset('assets/icons/doctor/pharmaupdate.png'),
        ),
      ),
    );

    final pharmaUpdatesTitle = Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Pharma Updates',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kTextLightColor,
            letterSpacing: 0.5,
            fontSize: 18,
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

    return Material(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: CustomDrawerDoctor(),
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: kBaseColor,
            iconTheme: IconThemeData(color: kTitleColor),
            centerTitle: true,
            toolbarHeight: 50,
            title: Text('Pharma Updates',
                style: TextStyle(
                    fontFamily: 'Segoe', fontSize: 18, color: kTitleColor)),
          ),
          backgroundColor: kBackgroundColor,
          body: Center(
            child: Column(
              children: [
                pharmaUpdateLogo,
                pharmaUpdatesTitle,
                verticalDivider,
                SizedBox(
                  height: 10,
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: Container(
                    height: 35,
                    child: TabBar(
                      unselectedLabelColor: kBaseColor,
                      labelColor: kTitleColor,
                      indicatorColor: kBaseColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          gradient:
                              LinearGradient(colors: [kBaseColor, kBaseColor]),
                          borderRadius: BorderRadius.circular(30),
                          color: kBaseColor),
                      tabs: [
                        Tab(
                          child: Container(
                            width: 205,
                            height: 34,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: kBaseColor, width: 1.0)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Pharma News",
                                style: TextStyle(
                                    fontFamily: 'Segoe', fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: 205,
                            height: 34,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: kBaseColor, width: 1.0)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "New Brand",
                                style: TextStyle(
                                    fontFamily: 'Segoe', fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: [
                      PharmaNews(),
                      NewBrand(),

                      // Container(
                      //   color: kBackgroundColor,
                      //   child: ListView(
                      //     children: [
                      //       pharmaNewsImageTitle1,
                      //       verticalTitleDivider,
                      //       pharmaNewsImage1,
                      //       pharmaNewsImageTitle2,
                      //       verticalTitleDivider,
                      //       pharmaNewsImage2,
                      //       pharmaNewsImageTitle2,
                      //       verticalTitleDivider,
                      //       pharmaNewsImage2,
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   color: kBackgroundColor,
                      //   child: ListView(
                      //     children: [
                      //       newBrandImageTitle1,
                      //       verticalTitleDivider,
                      //       newBrandImage1,
                      //       newBrandImageTitle2,
                      //       verticalTitleDivider,
                      //       newBrandImage2,
                      //       newBrandImageTitle2,
                      //       verticalTitleDivider,
                      //       newBrandImage2,
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
