import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mileagecalculator/Database/datamodel.dart';
import 'package:mileagecalculator/pages/responsive.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

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
  late Future<List<DataModel>> data;
  List<DataModel> datas = [];
  bool fetching = true;
  bool bottomdialoag = true;
  late int distance;
  double? distancefind = 0.00;
  late int charging;
  late int statrtdistance;
  late int enddistance;
  late int statrtCharging;
  late int endCharging;
  late LocationPermission permission;
  late bool serviceEnabled;
  bool start = false;
  late DB db;
  bool icon = false;
  late double startlatitude;
  late double startlongitude;

  StreamSubscription<Position>? _positionStreamSubscription;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<void> _toggleListening() async {
    print("In Function");
    if (_positionStreamSubscription == null) {
      print("In Function if");
      //final positionStream = _geolocatorPlatform.getPositionStream();
      // Position? start = await Geolocator.getLastKnownPosition();

      _positionStreamSubscription = Geolocator.getPositionStream(
              forceAndroidLocationManager: true,
              desiredAccuracy: LocationAccuracy.high)
          .listen((Position position) async {
        //Position start = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        print("Speed is " + position.speed.toString());
        if (position.speed > 1.3) {
          if (start) {
            start = false;
            print("Start");
            startlatitude = position.latitude;
            startlongitude = position.longitude;
          } else {
            distancefind = distancefind! +
                Geolocator.distanceBetween(startlatitude, startlongitude,
                    position.latitude, position.longitude);
            startlatitude = position.latitude;
            startlongitude = position.longitude;
          }
        }

        print("Distance is " + distancefind.toString());
        print("Start " +
            // start.latitude.toString() +
            // ", " +
            // start.longitude.toString() +
            "end " +
            position.latitude.toString() +
            ', ok ' +
            position.longitude.toString());
      });
    }

    if (_positionStreamSubscription == null) {
      return;
    }

    setState(() {
      if (_positionStreamSubscription!.isPaused) {
        icon = true;
        _positionStreamSubscription!.resume();
      } else {
        icon = false;
        _positionStreamSubscription!.pause();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<Position> _determinePosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //Alert Box
      //On Location
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //Alert Box
        //Give Access
        await Geolocator.openAppSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //Alert Box
      //Give Access
      await Geolocator.openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setDatatoSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('trip_name', titleController.text);
    prefs.setString('start_km', startkmController.text);
    prefs.setString('start_charge_percentage', startchargingController.text);
  }

  void removeDatatoSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('trip_name');
    await prefs.remove('start_km');
    await prefs.remove('start_charge_percentage');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF22262B),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "MileageCalculator",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: icon ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        onPressed: () {
          print("Pressed");
          start = true;
          _toggleListening();
        },
      ),
      backgroundColor: Color(0xFF22262B),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "13.0",
                          style: TextStyle(fontSize: 72),
                        ),
                        Text(
                          "KM",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Walking",
                          style: TextStyle(
                              fontSize: 24, fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
