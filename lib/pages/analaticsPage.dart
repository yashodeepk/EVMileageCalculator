import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:mileagecalculator/Database/datamodel.dart';
import 'package:mileagecalculator/pages/datapage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:currency_picker/currency_picker.dart';

class analatics extends StatefulWidget {
  @override
  _analaticsState createState() => _analaticsState();
}

class _analaticsState extends State<analatics> {
  Future<List<DataModel>>? data;
  List<DataModel> datas = [];
  DB? db;
  bool fetching = true;
  var logo;
  var avgDistance = 0.00;
  var avgCost = 0.00;
  var avgSavings = 0.00;
  var tripCount = 0;

  List<Color> gradientColors = [
    const Color(0xFF03ADC6),
    const Color(0xff02d39a),
  ];
  @override
  void initState() {
    super.initState();
    db = DB();
    getdata();

    if (selectcurrency != null) {
      setState(() {
        logo = Currency.from(json: jsonDecode(selectcurrency));
      });
    } else {
      logo.symbol = "Rs";
    }
  }

  List<FlSpot> convetDataModelToFlSpot() {
    if (!fetching) {
      List<FlSpot> arrSpots = [];
      avgDistance = 0.00;
      avgCost = 0.00;
      avgSavings = 0.00;
      tripCount = 0;

      var length;

      if (datas.length > 15)
        length = 15;
      else
        length = datas.length;

      print("Data Length is " + datas.length.toString());
      for (int dataIndex = 0; dataIndex < length; dataIndex++) {
        print(datas[dataIndex].electricity.toString());
        arrSpots.add(FlSpot(double.parse(dataIndex.toString()),
            double.parse(datas[dataIndex].distance.toString()) / 10));
        avgCost =
            avgCost + double.parse(datas[dataIndex].electricity.toString());
        avgSavings = avgSavings +
            (double.parse(datas[dataIndex].petrol.toString()) -
                double.parse(datas[dataIndex].electricity.toString()));
        avgDistance =
            avgDistance + double.parse(datas[dataIndex].distance.toString());
      }
      print("Arr Spots is " + arrSpots.toString());

      setState(() {
        tripCount = length;
        print("tripcount is " + tripCount.toString());
        avgCost = double.parse((avgCost / tripCount).toString());
        print("Avg Cost is " + avgCost.toString());
        avgSavings = double.parse((avgSavings / tripCount).toString());
        print("Avg Savings is " + avgSavings.toString());
        avgDistance = double.parse((avgDistance / tripCount).toString());
        print("Avg Savings is " + avgDistance.toString());
      });
      return arrSpots;
    } else {
      return [];
    }
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
        elevation: 0,
        backgroundColor: Color(0xFF22262B),
        title: Center(
            child: Text(
          "Analytics",
          style: TextStyle(fontSize: 24),
        )),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DataPage()),
                          );
                        },
                        icon: Icon(Icons.all_inbox),
                        label: Text("All Data"),
                      ),
                    ],
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.7,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Color(0xFF22262B)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, left: 12.0, top: 10, bottom: 12),
                      child: LineChart(
                        mainData(),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        avgDistance.toString(),
                        style: TextStyle(
                            fontSize: 52,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " km",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Average distance traveled in last ${tripCount.toString()} trips",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 30, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        avgCost.toString(),
                        style: TextStyle(
                            fontSize: 52, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " " + logo.symbol,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Average Cost in last ${tripCount.toString()} trips",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 30, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        avgSavings.toString(),
                        style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Text(
                        " " + logo.symbol,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Average Savings in last ${tripCount.toString()} trips",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              return LineTooltipItem(
                '${datas[flSpot.x.toInt()].title} \n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: (flSpot.y * 10).toString(),
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: ' km ',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'T2';
              case 4:
                return 'T5';
              case 7:
                return 'T8';
              case 10:
                return 'T11';
              case 13:
                return 'T14';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10';
              case 3:
                return '30';
              case 5:
                return '50';
              case 7:
                return '70';
              case 9:
                return '90';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 14,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: convetDataModelToFlSpot(),
          isCurved: false,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
