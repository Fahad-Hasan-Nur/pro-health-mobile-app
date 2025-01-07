import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/ApiList.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';

class PharmaNews extends StatefulWidget {
  const PharmaNews({Key? key}) : super(key: key);

  @override
  _PharmaNewsState createState() => _PharmaNewsState();
}

class _PharmaNewsState extends State<PharmaNews> {
  ApiServices apiServices = ApiServices();
  List pharmaNews = [];

  List pharmaNews2 = [];

  getPharmaNews() async {
    var response = await apiServices.fetchPharmaUpdates();
    if (response.length > 0) {
      for (var item in response) {
        if (item['photoType'] == 'PharmaNews') {
          setState(() {
            pharmaNews.add(item);
          });
        }
      }
    }

    for (var i = pharmaNews.length - 1; i >= 0; i--) {
      setState(() {
        pharmaNews2.add(pharmaNews[i]);
      });
    }
  }

  @override
  void initState() {
    getPharmaNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: pharmaNews2.length > 0
            ? ListView.builder(
                itemCount: pharmaNews2.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            color: kBackgroundColor,
                            padding: EdgeInsets.only(
                                left: 20.0,
                                top: 10.0,
                                bottom: 2.0,
                                right: 10.0),
                            child: Text(
                              pharmaNews2[index]['title'],
                              style: TextStyle(
                                  fontFamily: 'Nunito-Bold',
                                  color: kBaseColor,
                                  letterSpacing: 0.5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: Divider(
                              color: kBaseColor,
                              height: 2.0,
                              thickness: 1.0,
                              indent: 0.0,
                              endIndent: 0.0,
                            ),
                          ),
                          Container(
                            height: 200,

                            padding: EdgeInsets.only(
                                left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  imagePath + pharmaNews2[index]['photoURL'],
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            // child: DecoratedBox(
                            //   decoration: BoxDecoration(
                            //     color: kBackgroundColor,
                            //     image: DecorationImage(
                            //         image: NetworkImage(
                            //             'https://image.shutterstock.com/image-photo/beautiful-water-drop-on-dandelion-260nw-789676552.jpg'),
                            //         fit: BoxFit.fill),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
