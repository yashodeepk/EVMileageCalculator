import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mileagecalculator/adMobHelper.dart';
import 'package:mileagecalculator/pages/Homepage.dart';
import 'package:mileagecalculator/pages/Savings.dart';
import 'package:mileagecalculator/pages/WelcomePage.dart';
import 'package:mileagecalculator/pages/analaticsPage.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mileagecalculator/Database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AdMobHelper.initialization();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  trip_name = prefs.getString('trip_name');
  start_km = prefs.getString('start_km');
  start_charge_percentage = prefs.getString('start_charge_percentage');

  batteryCap = prefs.getString('batteryCap');
  batteryCapacity = prefs.getString('battery_Capacity');
  electricityPrice = prefs.getString('electricity_Price');
  petrolPrize = prefs.getString('petrol_Prize');
  petrolVehicalMileage = prefs.getString('petrol_Vehical_Mileage');
  selectcurrency = prefs.getString('select_currency');
  distanceUnit = prefs.getString('distanceUnit');
  usedYears = prefs.getString('usedYears');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EV Mileage Calculator',
      theme: ThemeData.dark(),
      //home: MyHomePage(),
      home: SplashScreen.navigate(
        backgroundColor: Color(0xFF000000),
        name: 'assets/animation.riv',
        next: (context) => petrolPrize == null
            ? WelcomePageWidget(
                fromMainPage: true,
              )
            : MyHomePage(),
        startAnimation: 'ok',
        isLoading: false,
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

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: new Text(
              'Are you sure?',
            ),
            content: new Text(
              'Do you want to exit this App',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                ),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: new Text(
                  'Yes',
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  final _pageOptions = [
    HomePageWidget(),
    CompareWidget(),
    Analatics(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: _pageOptions[selectedPage],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
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
              icon: Icon(Icons.analytics),
              label: 'Analytics',
            ),
          ],
          currentIndex: selectedPage,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}
