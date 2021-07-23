import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mileagecalculator/Database/datamodel.dart';
import 'package:mileagecalculator/pages/infoPage.dart';
import 'package:mileagecalculator/pages/responsive.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  bool get isPlaying => _controller.isActive;

  bool button = false;
  final bikeRiveFileName = 'assets/bike.riv';
  Artboard? _bikeArtboard;
  late StateMachineController _controller;
  SMIInput<bool>? _pressInput;

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
  double? distancefind = 0.0;
  String speedCheck = "Still";
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
  bool speedcheck = false;
  late double startlatitude;
  late double startlongitude;
  double? batteryUsed = 0.00;
  StreamSubscription<Position>? _positionStreamSubscription;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<void> _toggleListening() async {
    distancefind = 0.0;
    print("In Function");
    if (_positionStreamSubscription == null) {
      print("In Function if");
      //final positionStream = _geolocatorPlatform.getPositionStream();
      // Position? start = await Geolocator.getLastKnownPosition();

      _positionStreamSubscription =
          Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high)
              .listen((Position position) async {
        //Position start = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        print("Speed is " + position.speed.toString());
        setState(() {
          if (position.speed > 1.4) {
            speedCheck = "Traveling";
            speedcheck = true;
            if (start) {
              start = false;
              print("Start");
              startlatitude = position.latitude;
              startlongitude = position.longitude;
            } else {
              print("in else");
              distancefind = distancefind! +
                  Geolocator.distanceBetween(startlatitude, startlongitude,
                          position.latitude, position.longitude) /
                      1000;
              batteryUsed = batteryUsed! +
                  (distancefind! / double.parse(batteryCapacity)) * 100;
              startlatitude = position.latitude;
              startlongitude = position.longitude;
            }
          } else if (position.speed > 0.3 && position.speed < 1.4) {
            speedcheck = false;
            speedCheck = "Walking";
          } else {
            speedCheck = "Standing";
          }
        });
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

    setState(() {
      if (_positionStreamSubscription == null) {
        //icon = true;
        print('inside _positionStreamSubscription == null');
        return;
      }
      if (_positionStreamSubscription!.isPaused || icon == false) {
        icon = true;
        print('inside _positionStreamSubscription.isPaused');
        _positionStreamSubscription!.resume();
      } else {
        // icon = false;
        print('inside _positionStreamSubscription.resume');
        _positionStreamSubscription!.pause();
      }
    });
  }

  void _bikeRiveFile() async {
    final bytes = await rootBundle.load(bikeRiveFileName);
    final file = RiveFile.import(bytes);

    final artboard = file.mainArtboard;
    var controller = StateMachineController.fromArtboard(artboard, 'press');
    if (controller != null) {
      artboard.addController(controller);
      _pressInput = controller.findInput('pressed');
    } else {
      return;
    }
    setState(() => _bikeArtboard = artboard);
  }

  @override
  void initState() {
    super.initState();
    _bikeRiveFile();
    _determinePosition();
  }

  Future<Position> _determinePosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      //Alert Box
      //On Location
      // await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        //Alert Box
        //Give Access
        // await Geolocator.openAppSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      //Alert Box
      //Give Access
      // await Geolocator.openAppSettings();
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

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    title: Center(
        child: Text(
      "Location Access Error",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      textAlign: TextAlign.center,
    )),
    content: Container(
      height: 30,
      child: Center(
        child: Text(
          "Please Give Location Access",
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              child: Text("Get Access"),
              onPressed: () async {
                await Geolocator.openAppSettings();
              }),
        ],
      ),
    ],
  );
  AlertDialog name = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    title: Center(
        child: Text(
      "Enter Trip Name",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      textAlign: TextAlign.center,
    )),
    content: Container(
      height: 50,
      child: Center(
        child: TextFormField(
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Please enter Trip Name";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(3),
          ],
          obscureText: false,
          decoration: InputDecoration(
            hintText: 'Trip 1',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 17,
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
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 15,
          ),
          TextButton(child: Text("Save"), onPressed: () {}),
          TextButton(child: Text("cancel"), onPressed: () {}),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        // leading: ,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF22262B),
        automaticallyImplyLeading: false,
        title: Text(
          "MileageCalculator",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InfoPage()));
              },
              icon: Icon(LineIcons.infoCircle))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 8,
          ),
          FloatingActionButton(
            backgroundColor: Color(0xFF03ADC6),
            child: (_positionStreamSubscription == null ||
                    _positionStreamSubscription!.isPaused)
                ? Icon(Icons.play_arrow)
                : Icon(Icons.pause),
            onPressed: () async {
              // print(serviceEnabled);
              permission = await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.denied) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                  return Future.error('Location permissions are denied');
                }
              } else if (permission == LocationPermission.deniedForever) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
                return Future.error(
                    'Location permissions are permanently denied, we cannot request permissions.');
              } else {
                print("Pressed");
                setState(() {
                  _pressInput?.value = true;

                  // icon = true;
                });
                start = true;
                _toggleListening();
              }
            },
          ),
          SizedBox(
            width: 8,
          ),
          icon
              ? FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.stop),
                  onPressed: () {
                    setState(() {
                      _pressInput?.value = false;
                      distancefind = 0.0;
                      icon = false;
                      _positionStreamSubscription!.pause();
                    });
                  },
                )
              : Container()
        ],
      ),
      backgroundColor: Color(0xFF22262B),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.all(Radius.circular(32)),
              // ),
              child: Center(
                child: Container(
                  width: 400,
                  height: 180,
                  child: _bikeArtboard == null
                      ? const SizedBox(
                          child: Center(
                            child: Text("Loading.."),
                          ),
                        )
                      : Rive(
                          fit: BoxFit.fitWidth,
                          artboard: _bikeArtboard!,
                        ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                  child: Container(
                    //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: MediaQuery.of(context).size.width / 2.25,
                    height: MediaQuery.of(context).size.width / 2.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.grey[800],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          distancefind!.toStringAsFixed(2),
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          distanceUnit,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   speedCheck,
                        //   style: TextStyle(
                        //       fontSize: 24, fontStyle: FontStyle.italic),
                        // )
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(speedcheck
                                ? LineIcons.biking
                                : LineIcons.shoePrints),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              speedCheck,
                              style: TextStyle(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 10, 0),
                  child: Container(
                    //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: MediaQuery.of(context).size.width / 2.25,
                    height: MediaQuery.of(context).size.width / 2.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.grey[800],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          batteryUsed!.toStringAsFixed(2),
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          "% Used",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   speedCheck,
                        //   style: TextStyle(
                        //       fontSize: 24, fontStyle: FontStyle.italic),
                        // )
                        Icon(LineIcons.batteryAlt2Full),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // child: Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         Container(
        //           padding: EdgeInsets.all(10),
        //           child: Center(
        //             child: Column(
        //               children: [
        //                 Text(
        //                   distancefind!.toStringAsFixed(2),
        //                   style: TextStyle(fontSize: 72),
        //                 ),
        //                 Text(
        //                   "KM",
        //                   style: TextStyle(fontSize: 20),
        //                 ),
        //                 SizedBox(
        //                   height: 10,
        //                 ),
        //                 Text(
        //                   speedCheck,
        //                   style: TextStyle(
        //                       fontSize: 24, fontStyle: FontStyle.italic),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
