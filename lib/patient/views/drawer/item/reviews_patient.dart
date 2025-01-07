import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/patient/models/review.dart';
import 'package:pro_health/patient/service/dashboard/api_patient.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewsPatient extends StatefulWidget {
  ReviewsPatient({Key? key, this.title, this.patientId}) : super(key: key);
  final String? title;
  final patientId;
  static String tag = 'ReviewsPatient';
  @override
  ReviewsPatientState createState() =>
      new ReviewsPatientState(patientId: this.patientId);
}

class ReviewsPatientState extends State<ReviewsPatient> {
  ReviewsPatientState({this.patientId});
  var rating = 5.0;
  final patientId;

  PatientApiService patientApiService = PatientApiService();

  List<PatientReviewModel> reviews = [];
  List newReviews = [];

  int patientInQueue = 0;
  double averageRating = 0.0;

  fetchDoctorReviews() async {
    var response = await patientApiService.fetchReviews(patientId);

    if (response.length > 0) {
      var reversedReviews = response.reversed.toList();
      setState(() {
        reviews.addAll(reversedReviews);
      });
    }

    createNewReviewList();
  }

  createNewReviewList() {
    for (var item in reviews) {
      Map reviewMap = Map();
      setState(() {
        reviewMap['reviewID'] = item.reviewID ?? 0;
        reviewMap['doctorID'] = item.doctorID ?? 0;
        reviewMap['patientID'] = item.patientID ?? 0;
        reviewMap['doctorName'] = item.doctorName ?? '';
        reviewMap['rating'] = item.rating ?? 0.0;
        reviewMap['reviewDate'] = getCustomDateLocal(item.reviewDate) ?? '';
        reviewMap['comments'] = item.comments ?? '';
        reviewMap['profilePicture'] =
            getDoctorProfilePic(item.profilePicture) ?? '';
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
          child: Image.asset('assets/icons/patient/reviewspage.png'),
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
          )
        ],
      ),
    );

    final reviewsList = newReviews.length > 0
        ? ListView.builder(
            itemCount: newReviews.length,
            itemBuilder: (BuildContext context, int index) {
              Map<dynamic, dynamic> review = newReviews[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        width: 1, color: Colors.blue),
                                    image: DecorationImage(
                                      image:
                                          (review['profilePicture'] == 'null' ||
                                                      review['profilePicture']
                                                          .isEmpty
                                                  ? AssetImage(noImagePath)
                                                  : NetworkImage(
                                                      review['profilePicture']))
                                              as ImageProvider<Object>,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review['doctorName'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      review['reviewDate'],
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
                                  '${review['rating']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: RatingStars(
                                    value: review['rating'],
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
                                    animationDuration:
                                        Duration(milliseconds: 1000),
                                    valueLabelPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 8),
                                    valueLabelMargin:
                                        const EdgeInsets.only(right: 8),
                                    starOffColor: const Color(0xffe7e8ea),
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
                                review['comments'],
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
          );

    // final reviewsList = Expanded(
    //   child: SingleChildScrollView(
    //     padding: EdgeInsets.only(left: 20, right: 20),
    //     child: ListBody(
    //       children: [
    //         singleReview,
    //         SizedBox(
    //           height: 10,
    //         ),
    //         singleReview,
    //         SizedBox(
    //           height: 10,
    //         ),
    //         singleReview,
    //         SizedBox(
    //           height: 10,
    //         ),
    //         singleReview,
    //         SizedBox(
    //           height: 10,
    //         ),
    //         singleReview,
    //         SizedBox(
    //           height: 10,
    //         ),
    //         singleReview,
    //         SizedBox(
    //           height: 10,
    //         ),
    //         singleReview,
    //         SizedBox(
    //           height: 10,
    //         ),
    //         singleReview,
    //         SizedBox(
    //           height: 10,
    //         ),
    //         singleReview,
    //         SizedBox(
    //           height: 30,
    //         ),
    //       ],
    //     ),
    //   ),
    // );

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
            Expanded(child: reviewsList),
          ],
        ),
      ),
    );
  }
}
