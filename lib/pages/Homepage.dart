import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mileagecalculator/Database/datamodel.dart';
import 'package:mileagecalculator/pages/responsive.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController startkmController = TextEditingController();
  TextEditingController endkmController = TextEditingController();
  TextEditingController startchargingController = TextEditingController();
  TextEditingController endchargingController = TextEditingController();
  String datetime = DateFormat('d/M/y hh:mm a').format(DateTime.now());
  late Future<List<DataModel>> data;
  List<DataModel> datas = [];
  bool fetching = true;
  late int distance;
  late int charging;
  late int statrtdistance;
  late int enddistance;
  late int statrtCharging;
  late int endCharging;
  late DB db;
  @override
  void initState() {
    super.initState();
    if(trip_name!= null)
    {
      setState(() {
        titleController.text = trip_name;
      });
    }
    if(start_km!= null)
    {
      setState(() {
        startkmController.text = start_km;
      });
    }
    if(start_charge_percentage!= null)
    {
      setState(() {
        startchargingController.text = start_charge_percentage;        
      });
    }
    db = DB();
    getdata();
  }

  void setDatatoSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('trip_name', titleController.text);
    prefs.setString('start_km', startkmController.text);
    prefs.setString('start_charge_percentage',startchargingController.text);
  }

  void getdata() async {
    data = db.getData();
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF22262B),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "MileageCalculator",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Color(0xFF22262B),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            primary: Color(0xFF03DAC6),
                          ),
                          onPressed: () {
                            setState(() {
                              titleController.text = "";
                              startchargingController.text = "";
                              startkmController.text = "";
                              endkmController.text = "";
                              endchargingController.text = "";
                            });
                          },
                          icon: Icon(Icons.clear_all),
                          label: Text("Clear All"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: titleController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            //maxLength: 10,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Trip Name',
                              hintStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: Color(0xFFD7D6D5),
                                fontSize: 20,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFF43464C),
                            ),
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Start',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: TextFormField(
                                controller: startkmController,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Km',
                                  hintStyle: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Color(0xFFD7D6D5),
                                    fontSize: 16,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF43464C),
                                ),
                                style: TextStyle(
                                  color: Color(0xFFD7D6D5),
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextFormField(
                              controller: startchargingController,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Charge %',
                                hintStyle: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFFD7D6D5),
                                  fontSize: 16,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                filled: true,
                                fillColor: Color(0xFF43464C),
                              ),
                              style: TextStyle(
                                color: Color(0xFFD7D6D5),
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Stop',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: TextFormField(
                                //cursorHeight: 10,
                                controller: endkmController,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Km',
                                  hintStyle: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Color(0xFFD7D6D5),
                                    fontSize: 16,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF43464C),
                                ),
                                style: TextStyle(
                                  color: Color(0xFFD7D6D5),
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextFormField(
                              controller: endchargingController,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Charge %',
                                hintStyle: GoogleFonts.getFont(
                                  'Poppins',
                                  color: Color(0xFFD7D6D5),
                                  fontSize: 16,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                filled: true,
                                fillColor: Color(0xFF43464C),
                              ),
                              style: TextStyle(
                                color: Color(0xFFD7D6D5),
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //mainAxisSize: MainAxisSize.,
                    children: [
                      // TextButton(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Color(0xFF8CEED2),
                      //       borderRadius: BorderRadius.only(
                      //         bottomLeft: Radius.circular(20),
                      //         bottomRight: Radius.circular(20),
                      //         topLeft: Radius.circular(20),
                      //         topRight: Radius.circular(20),
                      //       ),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         'Clear',
                      //         style: GoogleFonts.getFont(
                      //           'Poppins',
                      //           fontSize: 16,
                      //           color: Color(0xFF22262B),
                      //         ),
                      //       ),
                      //     ),
                      //     height: 45,
                      //     width: 80,
                      //   ),
                      //   onPressed: () {
                      //     // statrtdistance =
                      //     //     int.parse(startkmController.text);
                      //     // enddistance = int.parse(endkmController.text);
                      //     // distance = enddistance - statrtdistance;
                      //     // statrtCharging =
                      //     //     int.parse(startchargingController.text);
                      //     // endCharging =
                      //     //     int.parse(endchargingController.text);
                      //     // charging = statrtCharging - endCharging;
                      //     // var patrolcost = 32;
                      //     // var electricitycost = 7;
                      //     // print(distance);
                      //     // db.insertData(DataModel(
                      //     //     title: titleController.text,
                      //     //     distance: distance.toString(),
                      //     //     savecharging: charging.toString(),
                      //     //     dateTimeadd: datetime,
                      //     //     petrol: patrolcost.toString(),
                      //     //     electricity: electricitycost.toString()));
                      //     print('IconButton pressed ...');
                      //   },
                      // ),
                      TextButton(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF03ADC6).withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'End Trip',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          height: 45,
                          width: 120,
                        ),
                        onPressed: () {
                          statrtdistance = int.parse(startkmController.text);
                          enddistance = int.parse(endkmController.text);
                          distance = enddistance - statrtdistance;
                          statrtCharging =
                              int.parse(startchargingController.text);
                          endCharging = int.parse(endchargingController.text);
                          charging = statrtCharging - endCharging;
                          var patrolcost = 32;
                          var electricitycost = 7;
                          print(distance);
                          db.insertData(DataModel(
                              title: titleController.text,
                              distance: distance.toString(),
                              savecharging: charging.toString(),
                              dateTimeadd: datetime,
                              petrol: patrolcost.toString(),
                              electricity: electricitycost.toString()));
                          getdata();
                          print('IconButton pressed ...');
                        },
                      ),
                      TextButton(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF03ADC6),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Start Trip',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          height: 45,
                          width: 120,
                        ),
                        onPressed: () {
                          setDatatoSP();
                          print('IconButton pressed ...');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              //color: Color(0xFFD7D6D5),
              padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
              child: DataTable(
                columnSpacing: 45,
                columns: [
                  DataColumn(
                      label: Text(
                    "Title",
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 18,
                      color: Color(0xFF03ADC6),
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    "Distance",
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 18,
                      color: Color(0xFF03ADC6),
                    ),
                  )),
                  DataColumn(
                      label: Text(
                    "Charge",
                    //  TextStyle(
                    //
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w500),
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 18,
                      color: Color(0xFF03ADC6),
                    ),
                  )),
                ],
                rows: [],
                // rows: datas
                //     .map<DataRow>((element) => DataRow(cells: [
                //           DataCell(Text(element.title.toString())),
                //           DataCell(Text(element.distance.toString())),
                //           DataCell(Text(element.savecharging.toString())),
                //         ]))
                //     .toList(),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 355, 15, 0),
                child: FutureBuilder<List<DataModel>>(
                    future: data,
                    builder: (context, snapshot) {
                      return ListView(
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
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          verticalDirection:
                                              VerticalDirection.up,
                                          children: <Widget>[
                                            SizedBox(width: 5),
                                            Text(
                                              trip.title ?? "",
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Text(
                                              trip.distance.toString() + " KM",
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Text(
                                              trip.savecharging.toString() +
                                                  "% used",
                                              style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Date Time - " +
                                            trip.dateTimeadd.toString(),
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                        ),
                                      ),
                                      SizedBox(width: 40),
                                      IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.white,
                                          onPressed: () {
                                            db.delete(trip.id ?? 0);
                                          }),
                                      SizedBox(width: 1),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
