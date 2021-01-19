import 'package:bank/db_helper.dart';
import 'package:bank/models/customer_data.dart';
import 'package:bank/pages/customer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';

class CustomersDetails extends StatefulWidget {
  @override
  CustomersDetailsState createState() {
    return new CustomersDetailsState();
  }
}

class CustomersDetailsState extends State<CustomersDetails> {
  DatabaseHelper helper = DatabaseHelper();
  List<CustomerData> custData;
  var tempData;
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = true;
    message("Connecting to Database.");
  }

  _getList() {
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<CustomerData>> custListFuture =
          helper.getCustomerDataMapList();
      custListFuture.then((custData) {
        setState(() {
          this.custData = custData;
          loading = false;
        });
      });
    });
  }

  Widget bodyData() => ListView.builder(
        shrinkWrap: true,
        itemCount: custData.length,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Card(
              color: HexColor('#F1FAEE'),
              child: ListTile(
                trailing: Text(
                  this.custData[position].bal.toString(),
                  style: GoogleFonts.nunitoSans(
                      color: HexColor('#E63946'),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                leading: CircleAvatar(
                  backgroundColor: HexColor('#A8DADC'),
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  this.custData[position].custName,
                  style: GoogleFonts.nunitoSans(
                    color: HexColor('#457B9D'),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "A/c - " + this.custData[position].accountNo.toString(),
                  style: GoogleFonts.nunitoSans(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CustomerView(
                      acno: custData[position].accountNo,
                      name: custData[position].custName,
                      addr: custData[position].custAddr,
                      phone: custData[position].phoneNo,
                      bal: custData[position].bal,
                    ),
                  ));
                },
              ),
            ),
          );
        },
      );

  message(String msg) {
    Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  refreshDetails() {
    setState(() {
      loading = true;
    });
    message("Refreshing..");
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    if (custData == null) {
      custData = List<CustomerData>();
      _getList();
    }
    return Scaffold(
      backgroundColor: HexColor('#A8DADC'),
      appBar: AppBar(
        backgroundColor: HexColor('#457B9D'),
        title: Text(
          "easytransaction",
          style: GoogleFonts.nunitoSans(
              fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.2),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Icon(Icons.refresh),
            ),
            onTap: () => refreshDetails(),
          )
        ],
      ),
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : bodyData(),
    );
  }
}
