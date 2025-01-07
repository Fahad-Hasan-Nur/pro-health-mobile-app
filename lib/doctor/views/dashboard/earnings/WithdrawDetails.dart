import 'package:flutter/material.dart';
import 'package:pro_health/base/utils/constants.dart';

class WithdrawDetails extends StatefulWidget {
  static String tag = 'WithdrawDetails';
  @override
  WithdrawDetailsState createState() => new WithdrawDetailsState();
}

class WithdrawDetailsState extends State<WithdrawDetails> {
  @override
  Widget build(BuildContext context) {
    final withdrawLogo = Padding(
      padding: EdgeInsets.only(top: 2),
      child: Container(
        width: 80.00,
        height: 80.00,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: ExactAssetImage('assets/icons/doctor/withdrawdetails.png'),
          fit: BoxFit.fitHeight,
        )),
      ),
    );
    final withdrawTitle = Container(
      width: 250.00,
      height: 30,
      child: Text(
        'Withdraw Details',
        style: TextStyle(
            fontFamily: 'Segoe',
            color: kTextLightColor,
            letterSpacing: 0.5,
            fontSize: 20,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );

    final appliedData = ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        padding: EdgeInsets.only(left: 2, right: 2),
        child: DataTable(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey),
          dataRowHeight: 30,
          headingRowHeight: 40,
          showBottomBorder: true,
          columnSpacing: 20.0,
          columns: [
            DataColumn(
                label: Text(
              "#SL",
              style: TextStyle(
                  fontSize: 15.0,
                  color: kWhiteShade,
                  fontWeight: FontWeight.w900),
            )),
            DataColumn(
                label: Text(
              "W/D Amount",
              style: TextStyle(
                  fontSize: 15.0,
                  color: kWhiteShade,
                  fontWeight: FontWeight.w900),
            )),
            DataColumn(
                label: Text(
              "Date",
              style: TextStyle(
                  fontSize: 15.0,
                  color: kWhiteShade,
                  fontWeight: FontWeight.w900),
            )),
            DataColumn(
                label: Text(
              "Status",
              style: TextStyle(
                  fontSize: 15.0,
                  color: kWhiteShade,
                  fontWeight: FontWeight.w900),
            )),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Text("1"),
              ),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("2")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("3")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("4")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("5")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("6")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("7")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("8")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("9")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("10")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("11")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("12")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("13")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("14")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("15")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("16")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("17")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("18")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("19")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("20")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(cells: [
              DataCell(Text("21")),
              DataCell(Text("2000")),
              DataCell(Text("21-01-2021")),
              DataCell(Text("Received")),
            ]),
            DataRow(selected: true, cells: [
              DataCell(Text("22")),
              DataCell(Text("3244")),
              DataCell(Text("23-01-2021")),
              DataCell(Text("Received")),
            ]),
          ],
        ),
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
        title: Text('Withdraw Details',
            style: TextStyle(fontFamily: 'Segoe', color: kTitleColor)),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 2),
            withdrawLogo,
            withdrawTitle,
            SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.black,
              height: 0.0,
              thickness: 0.5,
              indent: 0.0,
              endIndent: 0.0,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    appliedData,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
