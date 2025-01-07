import 'package:get/get.dart';
import 'package:pro_health/base/helper_functions.dart';
import 'package:pro_health/doctor/services/api_service/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentController extends GetxController {
  ApiServices apiServices = ApiServices();
  var memberId = 0.obs;

  var _timer;

  var appointmentDateTime = ''.obs;

  var chats = [].obs;
  var appoinments = [].obs;
  var queueAppointments = [].obs;

  var isLoading = false.obs;

  getTime(String time) {
    DateTime dbDate = DateTime.parse(time);
    final currDate = DateTime.now();

    var difference = currDate.difference(dbDate).inMinutes;

    if (difference < 1) {
      return "Just Now";
    } else if (difference < 60) {
      return "$difference min ago";
    } else if (difference < 1440) {
      return "${(difference / 60).toStringAsFixed(0)} hr ago";
    } else if (difference < 43200) {
      return "${(difference / 1440).toStringAsFixed(0)} days ago";
    } else if (difference < 518400) {
      return "${(difference / 43200).toStringAsFixed(0)} days ago";
    }
  }

  getQueueAppointments() {
    for (var i = 0; i < appoinments.length; i++) {
      if (i > 0) {
        queueAppointments.add(appoinments[i]);
      }
    }
  }

  addConsultation(var appointments) async {
    Map onlineConsultations = Map();
    onlineConsultations['appointmentID'] = appointments['appoitmentID'];
    onlineConsultations['memberID'] = appointments['memberID'];
    onlineConsultations['doctorID'] = appointments['doctorID'];
    onlineConsultations['patiantID'] = appointments['patiantID'];
    onlineConsultations['prescriptionID'] = appointments['prescriptionID'];
    onlineConsultations['patientName'] = appointments['patientName'];
    onlineConsultations['createdOn'] = DateTime.now().toIso8601String();
    await apiServices.addConsultionsToDb(onlineConsultations);
  }

  fetchDoctorAppoinments() async {
    // print('appointment function calling');
    int memberId = await getDoctorMemberId();
    var response = await apiServices.fetchDoctorAppoinment(memberId);
    // print(response);
    if (response.length > 0) {
      for (var item in response) {
        Map<String, dynamic> appointment = {};
        appointment['doctorID'] = item['doctorID'];
        appointment['memberID'] = item['memberID'];
        appointment['problem'] = item['problem'];
        appointment['stutas'] = item['stutas'];
        appointment['patientName'] = item['patientName'];
        appointment['appoitmentID'] = item['appoitmentID'];
        appointment['createdOn'] = getDataAndTime(item['createdOn']);
        appointment['patiantID'] = item['patiantID'];
        appointment['profilePic'] = getDoctorProfilePic(item['profilePic']);
        appointment['paymentMethod'] = item['paymentMethod'];
        appointment['paymentPhone'] = item['paymentPhone'];

        // print('payment phone ${item['paymentPhone']}');
        appointment['mobile'] = item['mobile'];
        appointment['trxID'] = item['trxID'];
        appointment['paidToPhone'] = item['paidToPhone'];

        appoinments.add(appointment);
      }
      getQueueAppointments();
    }
  }

  getDataAndTime(String dateTime) {
    // var dateTime = '2021-08-08T13:05:00';
    var date = DateTime.parse(dateTime);
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

  @override
  void onInit() {
    fetchDoctorAppoinments();
    // print('controller caling');
    super.onInit();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
