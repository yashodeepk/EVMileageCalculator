import 'package:flutter/material.dart';
import 'package:mileagecalculator/Database/datamodel.dart';
import 'package:mileagecalculator/pages/responsive.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:intl/intl.dart';

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
    db = DB();
    getdata();
  }

  void getdata() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFF22262B),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -1),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: Text(
                            'Logo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment(-0.6, 0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextFormField(
                          controller: titleController,
                          maxLength: 10,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Trip Name',
                            hintStyle: TextStyle(
                              color: Color(0xFFAAAAAA),
                              fontSize: 25,
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
                            color: Color(0xFFAAAAAA),
                            fontSize: 25,
                          ),
                        ),
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
                                    hintStyle: TextStyle(
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
                                  hintStyle: TextStyle(
                                    color: Color(0xFFD7D6D5),
                                    fontSize: 18,
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
                                  controller: endkmController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Km',
                                    hintStyle: TextStyle(
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
                                  hintStyle: TextStyle(
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
                    Align(
                      alignment: Alignment(0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment(0.8, 0),
                              child: IconButton(
                                onPressed: () {
                                  statrtdistance =
                                      int.parse(startkmController.text);
                                  enddistance = int.parse(endkmController.text);
                                  distance = enddistance - statrtdistance;
                                  statrtCharging =
                                      int.parse(startchargingController.text);
                                  endCharging =
                                      int.parse(endchargingController.text);
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
                                  print('IconButton pressed ...');
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Color(0xFF8CEED2),
                                  size: 50,
                                ),
                                iconSize: 50,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Container(
            //   padding: EdgeInsets.fromLTRB(0, 345, 0, 0),
            //   child: SingleChildScrollView(
            //     child: DataTable(
            //       columns: [
            //         DataColumn(
            //             label: Text(
            //           "Title",
            //           style: TextStyle(color: Colors.teal),
            //         )),
            //         DataColumn(
            //             label: Text(
            //           "Distance",
            //           style: TextStyle(color: Colors.teal),
            //         )),
            //         DataColumn(
            //             label: Text(
            //           "Charge",
            //           style: TextStyle(color: Colors.teal),
            //         )),
            //       ],
            //       rows: datas
            //           .map<DataRow>((element) => DataRow(cells: [
            //                 DataCell(Text(element.title.toString())),
            //                 DataCell(Text(element.distance.toString())),
            //                 DataCell(Text(element.savecharging.toString())),
            //               ]))
            //           .toList(),
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 370, 0, 0),
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
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 30),
                                    Text(
                                      trip.title ?? "",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                    Text(
                                      trip.distance.toString() + " KM",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                    Text(
                                      trip.savecharging.toString() + "% used",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(width: 0),
                              Text(
                                  "Date Time - " + trip.dateTimeadd.toString()),
                              SizedBox(width: 50),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.white,
                                  onPressed: () {}),
                              SizedBox(width: 1),
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
    );
  }
}
