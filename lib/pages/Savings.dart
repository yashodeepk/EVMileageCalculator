import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:mileagecalculator/Database/datamodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mileagecalculator/adMobHelper.dart';
import 'package:mileagecalculator/pages/WelcomePage.dart';
import 'package:mileagecalculator/pages/infoPage.dart';

class CompareWidget extends StatefulWidget {
  @override
  _CompareWidgetState createState() => _CompareWidgetState();
}

class _CompareWidgetState extends State<CompareWidget> {
  TextEditingController electricity = TextEditingController();
  TextEditingController petrol = TextEditingController();
  List<DataModel> datas = [];
  bool fetching = true;
  late DB db;
  var savings = 0.00;

  AdMobHelper adhelper = new AdMobHelper();

  @override
  void initState() {
    super.initState();
    db = DB();
    getdata();
    adhelper.createInterAd();
  }

  void reload() {
    setState(() {});
  }

  void getdata() async {
    datas = await db.getData();
    datas = datas.reversed.toList();

    setState(() {
      savings = 0.00;
      for (int tripIndex = 0; tripIndex < datas.length; tripIndex++) {
        print("Petrol is " +
            double.parse(datas[tripIndex].petrol.toString()).toString());
        print("Electricity is " +
            double.parse(datas[tripIndex].electricity.toString()).toString());
        savings = savings +
            (double.parse(datas[tripIndex].petrol.toString()) -
                double.parse(datas[tripIndex].electricity.toString()));
      }
      fetching = false;
      print("Savings is " + savings.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: Icon(Icons.hourglass_empty),
          //   color: Color(0xFF22262B),
          //   onPressed: () {},
          // ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF22262B),
          title: Text(
            "Savings",
            style: TextStyle(fontSize: 24),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InfoPage()));
                },
                icon: Icon(LineIcons.infoCircle))
          ]),
      backgroundColor: Color(0xFF22262B),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -1),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                          height: 50,
                          child: AdWidget(
                              ad: AdMobHelper.getBannerAd()..load(),
                              key: UniqueKey())),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF03ADC6),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                      Currency.from(
                                                  json: jsonDecode(
                                                      selectcurrency))
                                              .symbol +
                                          ' ' +
                                          savings.toStringAsFixed(3),
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 24,
                                        color: Color(0xFF22262B),
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                                height: 120,
                                width: double.infinity,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 200, 20, 10),
                child: ListView(
                  children: datas.map((trip) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 2),
                        ),
                      ),
                      //color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                AutoSizeText(
                                  "Name: " + trip.title.toString(),
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                ),
                                //SizedBox(width: 30),
                                AutoSizeText(
                                  "EV  " +
                                      Currency.from(
                                              json: jsonDecode(selectcurrency))
                                          .symbol +
                                      double.parse(trip.electricity.toString())
                                          .toStringAsFixed(2),
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                ),
                                //SizedBox(width: 30),
                                AutoSizeText(
                                  "Petrol  " +
                                      Currency.from(
                                              json: jsonDecode(selectcurrency))
                                          .symbol +
                                      double.parse(trip.petrol.toString())
                                          .toStringAsFixed(2),
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Date Time - " + trip.dateTimeadd.toString(),
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                  ),
                                ),
                                // SizedBox(
                                //   height: 30,
                                // )
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        db.delete(trip.id ?? 0);
                                        getdata();
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Edit",
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          adhelper.showInterAd();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WelcomePageWidget(
                      fromMainPage: false,
                      reload: reload,
                    )),
          );
        },
        backgroundColor: Color(0xFF03ADC6),
        icon: Icon(Icons.mode_edit),
      ),
    );
  }
}
