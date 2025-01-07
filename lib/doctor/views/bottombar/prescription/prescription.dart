import 'package:pro_health/doctor/views/bottombar/prescription/classes/Advice.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Chamber.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Doctor.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Investigation.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Medicine.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/NextPlan.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/OE.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/Patient.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/chiefCompliant.dart';
import 'package:pro_health/doctor/views/bottombar/prescription/classes/qrcode.dart';

class Prescription {
  final Doctor doctor;
  final Patient patient;
  final Chamber chamber;
  final Advice advice;
  final ChiefCompliant cc;
  final OE oe;
  final Investigation investigation;
  final NextPlan nextPlan;
  final Medicine medicine;
  final QrCode qrCode;

  Prescription({
    required this.doctor,
    required this.patient,
    required this.chamber,
    required this.advice,
    required this.cc,
    required this.oe,
    required this.investigation,
    required this.nextPlan,
    required this.medicine,
    required this.qrCode,
  });
}
