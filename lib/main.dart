import 'package:flutter/material.dart';
import 'package:mileagecalculator/pages/Homepage.dart';
import 'package:mileagecalculator/pages/Savings.dart';
import 'package:mileagecalculator/pages/datapage.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mileagecalculator/Database/database.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  trip_name = prefs.getString('trip_name');
  start_km = prefs.getString('start_km');
  start_charge_percentage = prefs.getString('start_charge_percentage');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      //home: MyHomePage(),
      home: SplashScreen.navigate(
        backgroundColor: Color(0xFF000000),
        name: 'assets/animation.riv',
        next: (context) => MyHomePage(),
        startAnimation: 'ok',
        isLoading: false,
        //alignment: Alignment.center,
        // width: 20,
        // height: 20,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;

  final _pageOptions = [HomePageWidget(), CompareWidget(), DataPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pageOptions[selectedPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF03ADC6),
        backgroundColor: Color(0xFF22262B),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.trip_origin_rounded),
            label: 'Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings_sharp),
            label: 'Savings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_saver_on_rounded),
            label: 'Database',
          ),
        ],
        currentIndex: selectedPage,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
