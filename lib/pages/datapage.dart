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
  late Future<List<DataModel>> data;
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
    data = db.getData();
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22262B),
      appBar: AppBar(
        backgroundColor: Color(0xFF22262B),
        title: Center(child: Text("Database")),
      ),
      body: Container(
        //color: Color(0xFFD7D6D5),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
          rows: datas
              .map<DataRow>((element) => DataRow(cells: [
                    DataCell(Text(element.title.toString())),
                    DataCell(Text(element.distance.toString())),
                    DataCell(Text(element.savecharging.toString())),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
