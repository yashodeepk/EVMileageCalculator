import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:mileagecalculator/Database/datamodel.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  Future<List<DataModel>>? data;
  List<DataModel> datas = [];
  DB? db;
  bool? fetching = true;
  @override
  void initState() {
    super.initState();
    db = DB();
    getdata();
  }

  void getdata() async {
    data = db!.getData();
    datas = await db!.getData();
    datas = datas.reversed.toList();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22262B),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Color(0xFF22262B),
        title: Text(
          "Database",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Title",
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 18,
                        color: Color(0xFF03ADC6),
                      ),
                    ),
                    Text(
                      "Distance",
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 18,
                        color: Color(0xFF03ADC6),
                      ),
                    ),
                    Text(
                      "Charge",
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 18,
                        color: Color(0xFF03ADC6),
                      ),
                    ),
                  ],
                ),
              ])),
          Container(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 0),
              child: FutureBuilder<List<DataModel>>(
                  future: data,
                  builder: (context, snapshot) {
                    return ListView(
                      children: datas.map((trip) {
                        return Container(
                          key: Key(trip.id.toString()),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      trip.title ?? "",
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    //SizedBox(width: 40),
                                    Text(
                                      trip.distance.toString() +
                                          " " +
                                          distanceUnit,
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    //SizedBox(width: 40),
                                    Text(
                                      trip.savecharging.toString() + "% used",
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Date Time - " +
                                          trip.dateTimeadd.toString(),
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                      ),
                                    ),
                                    //SizedBox(width: 40),
                                    // SizedBox(
                                    //   height: 30,
                                    // ),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        color: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            db!.delete(trip.id ?? 0);
                                            getdata();
                                          });
                                        }),
                                    //SizedBox(width: 1),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }))
        ],
      ),
    );
  }
}
