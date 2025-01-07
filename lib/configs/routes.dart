import 'package:flutter/material.dart';
import 'package:pro_health/doctor/views/dashboard/dashboard_doctor.dart';
import 'package:pro_health/app/app_view.dart';
import 'package:pro_health/doctor/views/auth/signin/signin_doctor.dart';
import 'package:pro_health/doctor/views/bottombar/appointment/appointment_doctor.dart';
import 'package:pro_health/doctor/views/bottombar/home/home_doctor.dart';
import 'package:pro_health/doctor/views/bottombar/pharma_updates/pharma_updates.dart';
import 'package:pro_health/doctor/views/dashboard/consultation_history/consultation_history.dart';
import 'package:pro_health/doctor/views/dashboard/earnings/earnings.dart';
import 'package:pro_health/doctor/views/dashboard/online_consultancy/online_consultancy.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/case_exchange.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/create_case.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/case_details.dart';
import 'package:pro_health/doctor/views/dashboard/case_exchange/saved_case.dart';
import 'package:pro_health/doctor/views/drawer/item/about_us.dart';
import 'package:pro_health/doctor/views/drawer/item/activity_status.dart';
import 'package:pro_health/doctor/views/drawer/item/contact_us.dart';
import 'package:pro_health/doctor/views/drawer/item/privacy_policy.dart';
import 'package:pro_health/doctor/views/drawer/item/reviews.dart';
import 'package:pro_health/doctor/views/drawer/item/settings.dart';
import 'package:pro_health/doctor/views/drawer/item/terms_conditions.dart';
import 'package:pro_health/doctor/views/auth/signup/create_account_doctor.dart';
import 'package:pro_health/doctor/views/auth/forgot_pass/ForgotPassword.dart';

import 'package:pro_health/doctor/views/dashboard/earnings/withdraw.dart';
import 'package:pro_health/doctor/views/dashboard/earnings/WithdrawDetails.dart';
import 'package:pro_health/patient/views/auth/forgot_pass/account_verify_patient.dart';
import 'package:pro_health/patient/views/auth/forgot_pass/forgot_password_patient.dart';
import 'package:pro_health/patient/views/auth/forgot_pass/update_password_patient.dart';
import 'package:pro_health/patient/views/auth/signin/signin_patient.dart';
import 'package:pro_health/patient/views/auth/signup/account_password_patient.dart';
import 'package:pro_health/patient/views/auth/signup/create_account_patient.dart';
import 'package:pro_health/patient/views/auth/signup/naccount_verify_patient.dart';
import 'package:pro_health/patient/views/auth/signup/terms_conditions_patient.dart';
import 'package:pro_health/patient/views/bottombar/appointment/appointment_patient.dart';
import 'package:pro_health/patient/views/bottombar/drug_info/drug_index_patient.dart';
import 'package:pro_health/patient/views/bottombar/message/message_patient.dart';
import 'package:pro_health/patient/views/dashboard/dashboard_patient.dart';
import 'package:pro_health/patient/views/drawer/item/complaint_patient.dart';
import 'package:pro_health/patient/views/drawer/item/consultation_history_patient.dart';
import 'package:pro_health/patient/views/drawer/custom_drawer_patient.dart';
import 'package:pro_health/patient/views/drawer/item/recent_patient.dart';
import 'package:pro_health/patient/views/drawer/item/reviews_patient.dart';
import 'package:pro_health/patient/views/drawer/item/settings_patient.dart';
// import 'package:pro_health/patient/views/drawer/item/terms_conditions_patient.dart';
import 'package:pro_health/patient/views/bottombar/home/view_doctors.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  AppView.tag: (context) => AppView(),

  // Doctor
  SignInDoctor.tag: (context) => SignInDoctor(),
  DashboardDoctor.tag: (context) => DashboardDoctor(),
  Home.tag: (context) => Home(),
  Appointment.tag: (context) => Appointment(),
  PharmaUpdates.tag: (context) => PharmaUpdates(),
  // PrescriptionPage.tag: (context) => PrescriptionPage(),
  // ProfileDoctor.tag: (context) => ProfileDoctor(),
  ForgotPassword.tag: (context) => ForgotPassword(),
  // AccountVerify.tag: (context) => AccountVerify(
  //       mobileno: '',
  //     ),
  // UpdatePassword.tag: (context) => UpdatePassword(),
  CreateNewAccount.tag: (context) => CreateNewAccount(),
  // NewAccountVerify.tag: (context) => NewAccountVerify(
  //       mobileno: '',
  //     ),
  // NewAccountPassword.tag: (context) => NewAccountPassword(),
  // TermsAndConditions.tag: (context) => TermsAndConditions(),
  CaseExchange.tag: (context) => CaseExchange(),
  OnlineConsultancy.tag: (context) => OnlineConsultancy(),
  Earnings.tag: (context) => Earnings(),
  Withdraw.tag: (context) => Withdraw(),
  WithdrawDetails.tag: (context) => WithdrawDetails(),
  ConsultationHistory.tag: (context) => ConsultationHistory(),
  ActivityStatus.tag: (context) => ActivityStatus(),
  TermsConditions.tag: (context) => TermsConditions(),
  PrivacyPolicy.tag: (context) => PrivacyPolicy(),
  AboutUs.tag: (context) => AboutUs(),
  ContactUs.tag: (context) => ContactUs(),
  Settings.tag: (context) => Settings(),
  Reviews.tag: (context) => Reviews(),
  CreateCase.tag: (context) => CreateCase(),
  SavedCase.tag: (context) => SavedCase(),
  CaseDetails.tag: (context) => CaseDetails(),

  // Patient
  SignInPatient.tag: (context) => SignInPatient(),
  DashboardPatient.tag: (context) => DashboardPatient(),
  CustomDrawerPatient.tag: (context) => CustomDrawerPatient(),
  // HomePatient.tag: (context) => HomePatient(),
  ForgotPasswordPatient.tag: (context) => ForgotPasswordPatient(),
  AccountVerifyPatient.tag: (context) => AccountVerifyPatient(mobileno: ''),
  UpdatePasswordPatient.tag: (context) => UpdatePasswordPatient(),
  CreateAccountPatient.tag: (context) => CreateAccountPatient(),
  NewAccountVerifyPatient.tag: (context) => NewAccountVerifyPatient(
        mobileno: '',
      ),
  AccountPasswordPatient.tag: (context) => AccountPasswordPatient(),
  TermsAndConditionsPatient.tag: (context) => TermsAndConditionsPatient(),
  DrugIndexPatient.tag: (context) => DrugIndexPatient(),
  AppointmentPatient.tag: (context) => AppointmentPatient(),
  MessagePatient.tag: (context) => MessagePatient(),
  // ProfilePatient.tag: (context) => ProfilePatient(),
  // ProfileP.tag: (context) => ProfileP(),
  // TermsConditionsPatient.tag: (context) => TermsConditionsPatient(),
  // ContactUsPatient.tag: (context) => ContactUsPatient(),
  ComplaintPatient.tag: (context) => ComplaintPatient(),
  ReviewsPatient.tag: (context) => ReviewsPatient(),
  ConsultationHistoryPatient.tag: (context) => ConsultationHistoryPatient(),
  // FavoritePatient.tag: (context) => FavoritePatient(),
  RecentPatient.tag: (context) => RecentPatient(),
  SettingsPatient.tag: (context) => SettingsPatient(),
  ViewDoctors.tag: (context) => ViewDoctors(),
  // DoctorProfile.tag: (context) => DoctorProfile(),
  // SelectPatient.tag: (context) => SelectPatient(),
  // RequestApproval.tag: (context) => RequestApproval(),
};
