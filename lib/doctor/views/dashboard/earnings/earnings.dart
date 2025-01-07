import 'dart:ui';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:pro_health/doctor/views/dashboard/earnings/withdraw.dart';
import 'package:pro_health/doctor/views/dashboard/earnings/WithdrawDetails.dart';
import 'package:pro_health/base/utils/constants.dart';

class Earnings extends StatefulWidget {
  static String tag = 'Earnings';

  @override
  EarningsState createState() => new EarningsState();
}

class EarningsState extends State<Earnings> {
  final List<List<double>> charts = [
    [0.0, 21.2, 2.35, 7.6, 2.8, 7.9, 14.4],
    [0.0, 1.7, 10.9, 3.6, 8.6, 7.7, 12.4],
    [0.0, 13.2, 7.35, 14.9, 9.5, 18.7, 21.4]
  ];

  static final List<String?> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String? actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

  @override
  Widget build(BuildContext context) {
    final earningsPageLogo = Center(
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 35.0,
          child: Image.asset('assets/icons/doctor/earningspage.png'),
        ),
      ),
    );
    final earningsPageSubTitle = Container(
      width: 250.00,
      height: 30,
      child: Text(
        'Earnings',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kTextLightColor,
            letterSpacing: 0.5,
            fontSize: 18,
            fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
    );

    final withdrawButton = Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 5),
            color: kBaseColor,
            child: Text('Withdraw',
                style: TextStyle(
                    fontFamily: "Segoe",
                    letterSpacing: 0.5,
                    color: kTitleColor)),
            onPressed: () {
              Navigator.of(context).pushNamed(Withdraw.tag);
            },
          ),
        )),
        SizedBox(
          width: 40,
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(WithdrawDetails.tag);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
              color: kBaseColor,
              child: Text('Withdraw History',
                  style: TextStyle(
                      fontFamily: "Segoe",
                      letterSpacing: 0.5,
                      color: kTitleColor)),
            ),
          ),
        ),
      ],
    );

    final earningChart = Container(
      child: Material(
          color: kBackgroundColor,
          child: InkWell(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 15.0, bottom: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Revenue Trend',
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    letterSpacing: 0.5,
                                    fontSize: 18,
                                    color: kTextLightColor,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        DropdownButton(
                            isDense: true,
                            value: actualDropdown,
                            onChanged: (String? value) => setState(() {
                                  actualDropdown = value;
                                  actualChart = chartDropdownItems
                                      .indexOf(value); // Refresh the chart
                                }),
                            items: chartDropdownItems.map((String? title) {
                              return DropdownMenuItem(
                                value: title,
                                child: Text(title!,
                                    style: TextStyle(
                                        color: kBaseColor,
                                        fontWeight: FontWeight.w400)),
                              );
                            }).toList())
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 4.0)),
                    Sparkline(
                      data: charts[actualChart],
                      fallbackWidth: 50,
                      lineColor: kTextLightColor,
                      lineWidth: 0.8,
                      //fillMode: FillMode.below,
                      //fillColor: kBackgroundColor,
                      sharpCorners: true,
                      pointsMode: PointsMode.all,
                      pointSize: 12.0,
                      pointColor: kBaseColor,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 5.0)),
                  ],
                )),
          )),
    );

    final todayMonthlyTotalEarnings = Container(
      child: Material(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.white70, width: 1),
          side: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 128,
              height: 110,
              padding: EdgeInsets.all(0.0),
              color: kBackgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      'Today',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kTextLightColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 23.0,
                      child: Image.asset('assets/icons/doctor/today.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'BDT. 500',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kBaseColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              child: VerticalDivider(
                color: Colors.white,
                thickness: 0.8,
              ),
            ),
            Container(
              width: 134,
              height: 110,
              padding: EdgeInsets.all(0.0),
              color: kBackgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      'This Month',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kTextLightColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 23.0,
                      child: Image.asset('assets/icons/doctor/thismonth.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'BDT. 3500',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kBaseColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              child: VerticalDivider(
                color: Colors.white,
                thickness: 0.8,
              ),
            ),
            Container(
              width: 128,
              height: 110,
              padding: EdgeInsets.all(0.0),
              color: kBackgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      'Total',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kTextLightColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 23.0,
                      child: Image.asset('assets/icons/doctor/total.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'BDT. 5000',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kBaseColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final averageReceivedPendingEarnings = Container(
      child: Material(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.white70, width: 1),
          side: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 128,
              height: 110,
              padding: EdgeInsets.all(0.0),
              color: kBackgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      'Average',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kTextLightColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 23.0,
                      child: Image.asset('assets/icons/doctor/average.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'BDT. 500',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kBaseColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              child: VerticalDivider(
                color: Colors.white,
                thickness: 0.8,
              ),
            ),
            Container(
              width: 134,
              height: 110,
              padding: EdgeInsets.all(0.0),
              color: kBackgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      'Total Received',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kTextLightColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 23.0,
                      child:
                          Image.asset('assets/icons/doctor/totalreceived.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'BDT. 4500',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kBaseColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              color: kBackgroundColor,
              child: VerticalDivider(
                color: Colors.white,
                thickness: 0.8,
              ),
            ),
            Container(
              width: 128,
              height: 110,
              padding: EdgeInsets.all(0.0),
              color: kBackgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      'Pending',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kTextLightColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 23.0,
                      child: Image.asset('assets/icons/doctor/pending.png'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'BDT. 2500',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 16.0,
                          color: kBaseColor,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: kBaseColor,
        centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(
          color: kTitleColor,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Earnings',
            style: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 18,
                color: kTitleColor,
                letterSpacing: 0.5)),
      ),
      backgroundColor: kBackgroundColor,
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 5,
            ),
            earningsPageLogo,
            earningsPageSubTitle,
            SizedBox(
              height: 5,
            ),
            Divider(
              color: kBaseColor,
              height: 0.0,
              thickness: 0.8,
              indent: 0.0,
              endIndent: 0.0,
            ),
            SizedBox(
              height: 10,
            ),
            withdrawButton,
            earningChart,
            Container(
              padding: EdgeInsets.only(bottom: 30),
              color: Color(0xFFDDE0E1),
            ),
            todayMonthlyTotalEarnings,
            Container(
              padding: EdgeInsets.only(bottom: 10),
              color: Color(0xFFDDE0E1),
            ),
            averageReceivedPendingEarnings,
            Container(
              padding: EdgeInsets.only(bottom: 17),
              color: Color(0xFFDDE0E1),
            ),
          ],
        ),
      ),
    );
  }
}
