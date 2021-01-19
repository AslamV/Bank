import 'package:bank/pages/transfer_money.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomerView extends StatefulWidget {
  final int acno, phone;
  final String name, addr;
  final double bal;

  const CustomerView(
      {Key key, this.acno, this.phone, this.name, this.addr, this.bal});
  @override
  CustomerViewState createState() => CustomerViewState();
}

class CustomerViewState extends State<CustomerView> {
  @override
  void initState() {
    super.initState();
    //print(widget.acno.toString() + widget.name + widget.bal.toString());
  }

  message(String msg) {
    Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor('#A8DADC'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
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
                  width: 120.0,
                ),
                Text(
                  'Dashboard',
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
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.nunitoSans(
                      color: HexColor('#1D3557'),
                      fontSize: 25.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: HexColor('#F1FAEE'),
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              height: 130.0,
              width: 400.0,
              decoration: BoxDecoration(
                  color: HexColor('#F1FAEE'),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Your Balance',
                          style: GoogleFonts.nunitoSans(
                              decoration: TextDecoration.none,
                              color: Colors.grey,
                              fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('*****4343',
                            style: GoogleFonts.nunitoSans(
                                decoration: TextDecoration.none,
                                color: Colors.grey,
                                fontSize: 13.0))
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.bal.toString(),
                          style: GoogleFonts.nunitoSans(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontSize: 32.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('Rs',
                            style: GoogleFonts.nunitoSans(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 22.0))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text('Personal Details',
                style: GoogleFonts.nunitoSans(
                    color: HexColor('#1D3557'),
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 270.0,
            width: 400,
            decoration: BoxDecoration(
                color: HexColor('#F1FAEE'),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  InputWidget(
                    name: 'Account Number',
                    value: widget.acno.toString(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InputWidget(
                    name: 'Address',
                    value: widget.addr,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InputWidget(
                    name: 'Account Type',
                    value: 'Savings Acc',
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InputWidget(
                    name: 'Mobile Number',
                    value: widget.phone.toString(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => TransferMoney(
                                accno: widget.acno,
                                name: widget.name,
                                bal: widget.bal.toString())));
                      },
                      child: Text(
                        'Transfer money',
                        style: GoogleFonts.nunitoSans(
                            color: HexColor('#E63946'),
                            fontWeight: FontWeight.w700,
                            fontSize: 25.0),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  final String name;
  final String value;
  const InputWidget({
    Key key,
    this.name,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: GoogleFonts.nunitoSans(
              decoration: TextDecoration.none,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
        Text(value,
            style: GoogleFonts.nunitoSans(
                decoration: TextDecoration.none,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: HexColor('#1D3557')))
      ],
    );
  }
}
