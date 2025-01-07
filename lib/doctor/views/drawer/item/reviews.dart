import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/doctor/models/doctorReviewModel.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

class Reviews extends StatefulWidget {
  Reviews({Key? key, this.title, this.memberId}) : super(key: key);
  final String? title;
  final memberId;
  static String tag = 'Reviews';
  @override
  ReviewsState createState() => new ReviewsState(memberId: this.memberId);
}

class ReviewsState extends State<Reviews> {
  ReviewsState({this.memberId});

  ApiServices apiServices = ApiServices();
  var rating = 5.0;

  final memberId;

  List<DoctorReviewModel> reviews = [];
  List newReviews = [];

  double averageRating = 0.0;

  getAverageRatings() {
    List<double> ratingsList = reviews.map((r) => r.rating!).toList();
    double sum = ratingsList.fold(0, (p, c) => p + c);
    if (sum > 0) {
      setState(() {
        averageRating =
            double.parse((sum / ratingsList.length).toStringAsFixed(2));
      });
    }
  }

  getDataAndTime(DateTime date) {
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

  fetchDoctorReviews() async {
    var response = await apiServices.fetchDoctorReview(memberId);
    if (response.length > 0) {
      setState(() {
        reviews.addAll(response);
      });
    }
    getAverageRatings();
    createNewReviewList();
  }

  createNewReviewList() {
    for (var item in reviews) {
      Map reviewMap = Map();
      setState(() {
        reviewMap['doctorID'] = item.doctorId;
        reviewMap['memberID'] = item.memberId;
        reviewMap['comments'] = item.comments;
        reviewMap['rating'] = item.rating;
        reviewMap['reviewDate'] = getDataAndTime(item.reviewDate!);
        reviewMap['patientName'] = item.patientName;
        reviewMap['profilePic'] = item.profilePic;
      });
      newReviews.add(reviewMap);
    }
  }

  @override
  void initState() {
    fetchDoctorReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newAccountPasswordLogo = Container(
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Image.asset('assets/icons/doctor/reviewspage.png'),
        ),
      ),
    );

    final forgotPasswordTitle = Container(
      //height: 35,
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Reviews',
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

    final totalReviewsAndRatings = Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 30.0, top: 30.0, right: 20.0, bottom: 10.0),
            child: Text(
              'Reviews (${reviews.length})',
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 16,
                  letterSpacing: 0.5,
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 110,
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20.0, top: 30.0, right: 20.0, bottom: 10.0),
            child: Text(
              'Ratings ($averageRating/5.0)',
              style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 16,
                  letterSpacing: 0.5,
                  color: kTextLightColor,
                  fontWeight: FontWeight.w600),
            ),
          )
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
        title: Text('Reviews',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            newAccountPasswordLogo,
            forgotPasswordTitle,
            verticalDivider,
            totalReviewsAndRatings,
            Expanded(
              child: newReviews.length > 0
                  ? ListView.builder(
                      itemCount: newReviews.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  width: 1, color: Colors.blue),
                                              image: DecorationImage(
                                                image: (newReviews[index][
                                                                'profilePic'] ==
                                                            null ||
                                                        newReviews[index][
                                                                'profilePic'] ==
                                                            'null' ||
                                                        newReviews[index][
                                                                'profilePic'] ==
                                                            ''
                                                    ? AssetImage(
                                                        patientNoImagePath)
                                                    : NetworkImage(newReviews[
                                                            index][
                                                        'profilePic'])) as ImageProvider<
                                                    Object>,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newReviews[index]
                                                    ['patientName'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                newReviews[index]['reviewDate'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: kBodyTextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${newReviews[index]['rating']}',
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Container(
                                            child: RatingStars(
                                              value: newReviews[index]
                                                  ['rating'],
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
                                              animationDuration:
                                                  Duration(milliseconds: 1000),
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
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Container(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          newReviews[index]['comments'],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                    ],
                                  )),
                                ),
                                Container(),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No Review found yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: kBodyTextColor,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
