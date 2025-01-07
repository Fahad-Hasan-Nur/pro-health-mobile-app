import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';
import 'package:pro_health/base/utils/strings.dart';
import 'package:pro_health/patient/models/chatlist_patient.dart';
import 'package:pro_health/patient/service/dashboard/chat_service.dart';
import 'package:pro_health/patient/views/drawer/custom_drawer_patient.dart';
import 'chat_screen.dart';

class MessagePatient extends StatefulWidget {
  static String tag = 'MessagePatient';
  @override
  MessagePatientState createState() => new MessagePatientState();
}

class MessagePatientState extends State<MessagePatient> {
  ChatServicesPatient chatServicesPatient = ChatServicesPatient();

  TextEditingController searchController = TextEditingController();

  double radius = 32;
  double iconSize = 20;
  double distance = 2;
  var _timer;

  List<ChatList> chatList = [];
  List<ChatList> foundChatList = [];

  bool isSearching = false;

  void runFilter(String enteredKeyword) {
    List<ChatList> results = [];
    if (enteredKeyword.trim().isEmpty) {
      setState(() {
        isSearching = false;
        results = chatList;
      });
    } else {
      setState(() {
        isSearching = true;
      });

      results = chatList
          .where((doctor) => doctor.doctorName!
              .toLowerCase()
              .contains(enteredKeyword.trim().toLowerCase()))
          .toList();
    }
    setState(() {
      foundChatList = results;
    });
  }

  getChatList() async {
    var response = await chatServicesPatient.getChatList();
    if (response.isNotEmpty) {
      if (chatList.isNotEmpty) {
        chatList.clear();
        setState(() {
          chatList.addAll(response);
        });
      } else {
        setState(() {
          chatList.addAll(response);
        });
      }
    }
  }

  @override
  void initState() {
    getChatList();
    const oneSec = Duration(seconds: 3);
    _timer = Timer.periodic(oneSec, (Timer t) => getChatList());

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageLogo = Container(
      padding: EdgeInsets.only(top: 2),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 35.0,
          child: Image.asset('assets/icons/patient/messagepage.png'),
        ),
      ),
    );

    final messageTitle = Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        'Message',
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
    final searchMessage = Container(
      height: 60,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 30, top: 25, right: 30, bottom: 0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          controller: searchController,
          onChanged: (val) => runFilter(val),
          style:
              TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
          autocorrect: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: TextStyle(
                fontFamily: 'Segoe', fontSize: 20, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            prefixIcon: Container(
              child: Icon(
                Icons.search_rounded,
                size: 26,
              ),
            ),
          ),
        ),
      ),
    );
    final messageHome = Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: isSearching ? foundChatList.length : chatList.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16, bottom: 20),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ChatList? chat =
                    isSearching ? foundChatList[index] : chatList[index];

                // return Container(
                //   child: ChatWidget(
                //     chat: chatList[index],
                //   ),
                // );
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatScreen(
                        chatList: chat,
                      );
                    }));
                  },
                  child: Container(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Stack(
                                    alignment: Alignment.center,
                                    // ignore: deprecated_member_use
                                    overflow: Overflow.visible,
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.blue,
                                          image: DecorationImage(
                                            image: (chat.profilePicture == '' ||
                                                        chat.profilePicture ==
                                                            'null'
                                                    ? AssetImage(noImagePath)
                                                    : NetworkImage(
                                                        chat.profilePicture!))
                                                as ImageProvider<Object>,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -(radius - distance),
                                        right: -(radius +
                                            iconSize +
                                            distance -
                                            30),
                                        bottom: -iconSize - distance - 35,
                                        left: radius,
                                        child: Icon(
                                          Icons.circle,
                                          color: chat.isOnline!
                                              ? Color(0xff6ECEC0)
                                              : Colors.grey,
                                          size: iconSize - 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  chat.doctorName ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  chat.lastMessage ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade500),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                chat.timeAgo ?? '',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  chat.unseenMsgCount == 0
                                      ? SizedBox.shrink()
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.lightBlue[900],
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text(
                                              '${chat.unseenMsgCount ?? 0}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      drawer: CustomDrawerPatient(),
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: kBaseColor,
        shadowColor: Colors.teal,
        iconTheme: IconThemeData(color: kTitleColor),
        toolbarHeight: 50,
        title: Text(
          'Message',
          style:
              TextStyle(fontFamily: 'Segoe', fontSize: 18, color: kTitleColor),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: <Widget>[
            messageLogo,
            messageTitle,
            verticalDivider,
            searchMessage,
            Expanded(child: messageHome),
          ],
        ),
      ),
    );
  }
}
