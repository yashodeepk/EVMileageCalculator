import 'package:flutter/material.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:mileagecalculator/Database/datamodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mileagecalculator/pages/WelcomePage.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF22262B),
        title: Center(
          child: Text(
            "Savings",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
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
                                  child: Text(selectcurrency.symbol + '40,000',
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
                padding: EdgeInsets.fromLTRB(20, 150, 20, 10),
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
                                  trip.title.toString(),
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
                                      selectcurrency.symbol +
                                      trip.electricity.toString(),
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
                                      selectcurrency.symbol +
                                      trip.petrol.toString(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WelcomePageWidget(
                      fromMainPage: false,
                    )),
          );
        },
        backgroundColor: Color(0xFF03ADC6),
        child: Icon(Icons.mode_edit),
      ),
    );
  }
}
