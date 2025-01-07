import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

// Colors

final kSwatchColor = Color(0xff0C4CA3);
const kBaseColor = Color(0xFF01619B);
const kButtonColor = Color(0xFF0069AA);
const kBackgroundColor = Color(0xFFECECEE);
//const kBackgroundColor = Color(0xFFEDEDED);
const kConsultationColor = Color(0xFFD4D4D7);
const kDCardColor = Color(0xFFD9DADC);
const kOnlineColor = Color(0xFF6ECEC0);
const kCardTitleColor = Color(0xFFCECFD1);
const kDashBoxColor = Color(0xFFFAFAFA);
const kResendBtnColor = Color(0xFF1888B8);
const kTitleColor = Color(0xffd3d3d3);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);
final kFaceBookColor = Color(0xFF102397);
final kGoogleColor = Color(0xFFff4f38);
final kWhiteShadow = Color(0xFFF5F5F5);
final kWhiteShade = Color(0xFFF4F4F4);
// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kFontHeading = TextStyle(fontFamily: '');

// error strings
const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

const selectMobileBank = "Select Mobile bank";
const bkash = "bKash";
const nagad = "Nagad";
const rocket = "Rocket";

String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}
