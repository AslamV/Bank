import 'package:bank/models/customer_data.dart';
import 'package:bank/pages/transaction_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../db_helper.dart';

class TransferMoney extends StatefulWidget {
  const TransferMoney({Key key, this.accno, this.name, this.bal})
      : super(key: key);

  final int accno;
  final String name;
  final String bal;
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  ScrollController _scroll;
  FocusNode _focuss = new FocusNode();
  CustomerData data;
  DatabaseHelper helper;
  bool loading;
  TextEditingController _accnoTEC;
  TextEditingController _amountTEC;
  TextEditingController _nameTEC;

  @override
  void initState() {
    super.initState();
    loading = true;
    _nameTEC = TextEditingController();
    _accnoTEC = TextEditingController();
    _amountTEC = TextEditingController();
    helper = DatabaseHelper();
    getData();
    _scroll = new ScrollController();
    _focuss.addListener(() {
      _scroll.jumpTo(-1.0);
    });
  }

  getData() async {
    try {
      data = await helper.getClient(widget.accno);
      setState(() {
        loading = false;
      });
    } catch (e) {
      message("Error while fetching data....");
    }
  }

  Widget _buildTransferBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => transfer(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: HexColor('#E63946'),
        child: Text(
          'Transfer',
          style: GoogleFonts.openSans(
            color: Colors.white,
            letterSpacing: 1.2,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  transfer() async {
    CustomerData toData;
    int tempToAccno;
    int amtToTransfer;
    int res1 = 0;
    int res2 = 0;
    var parsed = DateTime.parse(DateTime.now().toString());
    var ttime = "${parsed.hour.toString()}:${parsed.minute.toString()}";
    var ddate =
        "${parsed.day.toString()}/${parsed.month.toString()}/${parsed.year.toString()}";
    var dateTime = parsed.day.toString() +
        "/" +
        parsed.month.toString() +
        "/" +
        parsed.year.toString() +
        " " +
        parsed.hour.toString() +
        ":" +
        parsed.minute.toString();

    if (_accnoTEC != null || _amountTEC != null || _nameTEC != null) {
      try {
        tempToAccno = int.parse(_accnoTEC.text);
        amtToTransfer = int.parse(_amountTEC.text);
        loading = true;
        toData = await helper.getClient(tempToAccno);
      } on Exception catch (e) {
        message("Please enter valid fields");
      }
    } else {
      message("Please enter above fields..");
      return;
    }

    if ((toData.accountNo == tempToAccno) &&
        (toData.custName == _nameTEC.text)) {
      if (data.bal > amtToTransfer) {
        data.bal = data.bal - amtToTransfer; // Debit amount
        toData.bal = toData.bal + amtToTransfer; // Credit amount

        //Update database
        try {
          res1 = await helper.updateCustomer(data);
          res2 = await helper.updateCustomer(toData);
          message("Redirecting...Don't press back button...");
          if (res1 == 1 && res2 == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => TransactionDetails(
                    isDone: true,
                    amount: double.parse(_amountTEC.text),
                    fromName: data.custName,
                    toName: toData.custName,
                    ttime: ttime,
                    ddate: ddate,
                    toAcNo: toData.accountNo,
                  ),
                ));
          }
        } catch (e) {
          message("Redirecting...Don't press back button...");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => TransactionDetails(
                        isDone: false,
                        amount: double.parse(_amountTEC.text),
                        fromName: data.custName,
                        toName: toData.custName,
                        ttime: ttime,
                        ddate: ddate,
                        toAcNo: toData.accountNo,
                      )));
        }
      } else {
        message("Redirecting...Don't press back button...");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TransactionDetails(
                isDone: false,
                amount: double.parse(_amountTEC.text),
                fromName: data.custName,
                toName: toData.custName,
                ttime: ttime,
                ddate: ddate,
                toAcNo: toData.accountNo,
              ),
            ));
      }
    } else {
      message("Redirecting...Don't press back button...");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TransactionDetails(
              isDone: false,
              amount: double.parse(_amountTEC.text),
              fromName: data.custName,
              toName: toData.custName,
              ttime: ttime,
              ddate: ddate,
              toAcNo: toData.accountNo,
            ),
          ));
    }
  }

  message(String msg) {
    Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Material(
          child: Stack(
            children: [
              Container(
                color: HexColor('#A8DADC'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.0, top: 20.0),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Material(
                              color: HexColor('#F1FAEE'), // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(Icons.arrow_back_ios_rounded)),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 110.0,
                          ),
                          Text(
                            'Send money',
                            style: GoogleFonts.nunitoSans(
                                decoration: TextDecoration.none,
                                color: HexColor('#1D3557'),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 55.0, right: 30.0),
                      height: 120.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                HexColor('#E63946'),
                                HexColor('#457B9D'),
                                HexColor('#1D3557')
                              ]),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Credit',
                                    style: GoogleFonts.nunitoSans(
                                        decoration: TextDecoration.none,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text('£ ${widget.bal}',
                                    style: GoogleFonts.nunitoSans(
                                        decoration: TextDecoration.none,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      height: 443.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: HexColor('#F1FAEE'),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                      ),
                      child: ListView(
                        controller: _scroll,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Enter Recipient Details',
                                  style: GoogleFonts.nunitoSans(
                                      color: HexColor('#1D3557'),
                                      fontSize: 23.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold)),
                              InputFld(
                                amountTEC: _nameTEC,
                                name: 'Enter Name',
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              InputFld(
                                amountTEC: _accnoTEC,
                                name: 'Enter Account Number',
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              InputFld(
                                amountTEC: _amountTEC,
                                name: 'Enter Amount',
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildTransferBtn()
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputFld extends StatelessWidget {
  final String name;
  const InputFld({
    Key key,
    @required TextEditingController amountTEC,
    this.name,
  })  : _amountTEC = amountTEC,
        super(key: key);

  final TextEditingController _amountTEC;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
              controller: _amountTEC,
              decoration: InputDecoration(
                fillColor: HexColor('#A8DADC'),
                filled: true,
                hintText: name,
                hintStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('#457B9D')),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('#E63946')),
                ),
              ),
              onChanged: (value) {
                //debugPrint('Something changed in Title Text Field');
              })
        ],
      ),
    );
  }
}
