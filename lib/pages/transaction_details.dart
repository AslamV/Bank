import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class TransactionDetails extends StatefulWidget {
  final bool isDone;
  final double amount;
  final String toName, ttime, ddate, fromName;
  final int toAcNo;
  const TransactionDetails(
      {Key key,
      this.isDone,
      this.amount,
      this.toName,
      this.toAcNo,
      this.fromName,
      this.ttime,
      this.ddate})
      : super(key: key);
  @override
  TransactionDetailsState createState() => TransactionDetailsState();
}

class TransactionDetailsState extends State<TransactionDetails> {
  @override
  void initState() {
    super.initState();
    print(widget.isDone);
  }

  Widget icon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 40,
              child: widget.isDone
                  ? Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 60,
                    )
                  : Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    )),
        ),
      ],
    );
  }

  Widget statusText() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: widget.isDone
            ? Text(
                'Success',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.russoOne(fontSize: 40.0, color: Colors.green),
              )
            : Text(
                'Failed',
                textAlign: TextAlign.center,
                style: GoogleFonts.russoOne(fontSize: 40.0, color: Colors.red),
              ));
  }

  Widget buildDoneBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: 160,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.pop(context),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: HexColor('#457B9D'),
        child: Text(
          'Done',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#A8DADC'),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor('#457B9D'),
        //backgroundColor: Colors.white,
        //elevation: 0.0,
        title: Text(
          "Payment",
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              icon(),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                height: 450.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: HexColor('#F1FAEE'),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 99.0),
                        child: statusText(),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TIME',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(widget.ttime,
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'DATE',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(widget.ddate,
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recipient',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 17.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.toName,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Ac-/${widget.toAcNo}',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 17.0,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: HexColor('#A8DADC'),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'AMOUNT',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Text(
                        '${widget.amount} £',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      buildDoneBtn()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
