import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_health/base/utils/constants.dart';

class Withdraw extends StatefulWidget {
  static String tag = 'Withdraw';
  @override
  WithdrawState createState() => new WithdrawState();
}

class WithdrawState extends State<Withdraw> {
  final withdrawLogo = Padding(
    padding: EdgeInsets.only(top: 2),
    child: Container(
      width: 80.00,
      height: 80.00,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: ExactAssetImage('assets/icons/doctor/withdraw.png'),
        fit: BoxFit.fitHeight,
      )),
    ),
  );
  final withdrawTitle = Container(
    width: 250.00,
    height: 30,
    child: Text(
      'Withdraw',
      style: TextStyle(
          fontFamily: 'Segoe',
          color: kTextLightColor,
          letterSpacing: 0.5,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
  );
  final amountTextField = Container(
    padding: EdgeInsets.only(left: 25, top: 30, right: 25, bottom: 20),
    child: TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11)
      ],
      keyboardType: TextInputType.number,
      autofocus: false,
      initialValue: '',
      style: TextStyle(fontFamily: "Segoe", fontSize: 18, color: Colors.black),
      autocorrect: true,
      decoration: InputDecoration(
        hintText: 'Enter withdraw amount',
        hintStyle: TextStyle(
            fontSize: 17, letterSpacing: 0.8, fontWeight: FontWeight.w300),
        contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Container(
          padding: EdgeInsets.only(
            left: 50,
            top: 10.0,
            right: 20,
            bottom: 6,
          ),
          child: Text(
            '৳',
            style: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 25,
                color: kTextLightColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
  final applyButton = Container(
    padding: EdgeInsets.symmetric(horizontal: 100),
    child: MaterialButton(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {},
      padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
      color: kButtonColor,
      child: Text('Apply',
          style: TextStyle(
              fontFamily: "Segoe",
              letterSpacing: 0.5,
              fontSize: 18,
              color: kWhiteShadow)),
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
            "Applied Amount",
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
            DataCell(Text("Pending")),
          ]),
          DataRow(selected: true, cells: [
            DataCell(Text("2")),
            DataCell(Text("3244")),
            DataCell(Text("23-01-2021")),
            DataCell(Text("Pending")),
          ]),
          DataRow(cells: [
            DataCell(Text("3")),
            DataCell(Text("2000")),
            DataCell(Text("21-01-2021")),
            DataCell(Text("Pending")),
          ]),
          DataRow(selected: true, cells: [
            DataCell(Text("4")),
            DataCell(Text("3244")),
            DataCell(Text("23-01-2021")),
            DataCell(Text("Pending")),
          ]),
          DataRow(cells: [
            DataCell(Text("5")),
            DataCell(Text("2000")),
            DataCell(Text("21-01-2021")),
            DataCell(Text("Pending")),
          ]),
          DataRow(selected: true, cells: [
            DataCell(Text("6")),
            DataCell(Text("3244")),
            DataCell(Text("23-01-2021")),
            DataCell(Text("Pending")),
          ]),
          DataRow(cells: [
            DataCell(Text("7")),
            DataCell(Text("2000")),
            DataCell(Text("21-01-2021")),
            DataCell(Text("Pending")),
          ]),
          DataRow(selected: true, cells: [
            DataCell(Text("8")),
            DataCell(Text("3244")),
            DataCell(Text("23-01-2021")),
            DataCell(Text("Pending")),
          ]),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
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
        title: Text('Withdraw',
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
            amountTextField,
            applyButton,
            SizedBox(
              height: 50,
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
