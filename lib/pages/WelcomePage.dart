import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:mileagecalculator/pages/infoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class WelcomePageWidget extends StatefulWidget {
  dynamic fromMainPage;
  dynamic reload;
  WelcomePageWidget({this.fromMainPage, this.reload});
  @override
  _WelcomePageWidgetState createState() => _WelcomePageWidgetState();
}

class _WelcomePageWidgetState extends State<WelcomePageWidget> {
  TextEditingController batteryCapacityController = TextEditingController();
  TextEditingController batteryCapController = TextEditingController();
  TextEditingController electricityPriceController = TextEditingController();
  TextEditingController petrolPrizeController = TextEditingController();
  TextEditingController petrolVehicalMileageController =
      TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String select = "Select";
  String date = "";
  var logo;
  DB db = new DB();
  DateTime selectedDate = DateTime.now();
  String dropdownValue = "Km";
  final _form = GlobalKey<FormState>();
  void getSPData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    batteryCap = prefs.getString('batteryCap');
    batteryCapacity = prefs.getString('battery_Capacity');
    electricityPrice = prefs.getString('electricity_Price');
    petrolPrize = prefs.getString('petrol_Prize');
    petrolVehicalMileage = prefs.getString('petrol_Vehical_Mileage');
    selectcurrency = prefs.getString('select_currency');
    distanceUnit = prefs.getString('distanceUnit');
    usedYears = prefs.getString('usedYears');
    if (batteryCapacity != null) {
      setState(() {
        batteryCapacityController.text = batteryCapacity;
      });
    }
    if (electricityPrice != null) {
      setState(() {
        electricityPriceController.text = electricityPrice;
      });
    }
    if (petrolPrize != null) {
      setState(() {
        petrolPrizeController.text = petrolPrize;
      });
    }
    if (petrolVehicalMileage != null) {
      setState(() {
        petrolVehicalMileageController.text = petrolVehicalMileage;
      });
    }
    if (distanceUnit != null) {
      setState(() {
        dropdownValue = distanceUnit;
      });
    }

    if (batteryCap != null) {
      setState(() {
        batteryCapController.text = batteryCap;
      });
    }

    if (usedYears != null) {
      print("Used Years are " + usedYears);
      date = usedYears.split(' ')[0];
      print("Date is " + date);
      setState(() {
        selectedDate = DateTime(int.parse(date.split('-')[0]),
            int.parse(date.split('-')[1]), int.parse(date.split('-')[2]));
      });
    }

    if (selectcurrency != null) {
      setState(() {
        logo = Currency.from(json: jsonDecode(selectcurrency));
        select = logo.name + " " + logo.symbol;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  AlertDialog prominantDisclosure(context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Center(
            child: Text(
          "Background Location Access",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        )),
        content: Container(
          height: 300,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/locationIcon.png'),
                radius: 75,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "EV Mileage Calculator collects location data in background to enable the calculation of real-time battery usage even when app is closed",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 15,
              ),
              TextButton(
                  child: Text("OK", style: TextStyle(color: Color(0xff03adc6))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ],
      );

  @override
  void initState() {
    super.initState();
    getSPData();
    Timer.run(() => prominantDis());
  }

  void prominantDis() async {
    if (widget.fromMainPage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return prominantDisclosure(context);
        },
      );
    }
  }

  Future<void> setDatatoSP() async {
    if (distanceUnit != null && logo != null) {
      if (distanceUnit.toString() != dropdownValue ||
          logo.name != Currency.from(json: jsonDecode(selectcurrency)).name) {
        print("Is not empty");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Possible loss of Stored data...",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 60.0),
          action: SnackBarAction(
            label: 'CLOSE',
            textColor: Colors.white,
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          ),
        ));
        await db.deleteAll();
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('battery_Capacity', batteryCapacityController.text);
    print("Battery is " + batteryCapacityController.text);
    batteryCapacity = batteryCapacityController.text;
    prefs.setString('electricity_Price', electricityPriceController.text);
    print("Electricity Price " + electricityPriceController.text);
    electricityPrice = electricityPriceController.text;
    prefs.setString('petrol_Prize', petrolPrizeController.text);
    print('Petrol Prize ' + petrolPrizeController.text);
    petrolPrize = petrolPrizeController.text;
    prefs.setString(
        'petrol_Vehical_Mileage', petrolVehicalMileageController.text);
    print('Pertrol Mileage' + petrolVehicalMileageController.text);
    petrolVehicalMileage = petrolVehicalMileageController.text;
    prefs.setString('distanceUnit', dropdownValue);
    print('Distance Unit is ' + dropdownValue);
    String user = jsonEncode(logo);
    prefs.setString('select_currency', user);
    print('Currency ' + user);
    distanceUnit = dropdownValue;
    prefs.setString('batteryCap', batteryCapController.text);
    batteryCap = batteryCapController.text;
    print('Battery Capacity is ' + batteryCap);
    prefs.setString('usedYears', selectedDate.toString());
    usedYears = selectedDate.toString();
    print('Battery installed date is ' + usedYears);
    selectcurrency = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InfoPage()));
              },
              icon: Icon(LineIcons.infoCircle))
        ],
        leading: !widget.fromMainPage
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (!widget.fromMainPage) {
                    Navigator.of(context).pop();
                  }
                },
              )
            : Container(),
        elevation: 0,
        backgroundColor: Color(0xFF22262B),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Setup Page",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
      key: scaffoldKey,
      backgroundColor: Color(0xFF22262B),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage('assets/1.png'),
                        fit: BoxFit.contain,
                        //width: 140,
                        //height: 140,
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4.2,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Tooltip(
                                message: 'What is your currency?',
                                showDuration: Duration(seconds: 3),
                                child: Text(
                                  'Select currency',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  decoration: BoxDecoration(
                                      color: Color(0xff03adc6).withOpacity(0.7),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24))),
                                  child: TextButton(
                                    onPressed: () {
                                      showCurrencyPicker(
                                        context: context,
                                        showFlag: true,
                                        showCurrencyName: true,
                                        showCurrencyCode: true,
                                        onSelect: (Currency currency) {
                                          setState(() {
                                            select = currency.name +
                                                " " +
                                                currency.symbol;

                                            logo = currency;
                                            petrolPrizeController.text = "";
                                            electricityPriceController.text =
                                                "";
                                          });
                                          print(
                                              'Select currency: ${currency.name}');
                                        },
                                        favorite: ['INR'],
                                      );
                                    },
                                    child: Center(
                                      child: AutoSizeText(
                                        select,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Tooltip(
                                message: 'What is the Distance unit you use?',
                                showDuration: Duration(seconds: 3),
                                child: AutoSizeText(
                                  ' Select Distance unit ',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  decoration: BoxDecoration(
                                      color: Color(0xff03adc6).withOpacity(0.7),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24))),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: const Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                          batteryCapacityController.text = "";
                                          petrolVehicalMileageController.text =
                                              "";
                                        });
                                      },
                                      items: <String>['Km', 'Miles']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Tooltip(
                                message:
                                    'Date on which latest battery was installed',
                                showDuration: Duration(seconds: 3),
                                child: Text(
                                  'Battery Installation date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  decoration: BoxDecoration(
                                      color: Color(0xff03adc6).withOpacity(0.7),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24))),
                                  child: TextButton(
                                    onPressed: () => _selectDate(context),
                                    child: Center(
                                      child: AutoSizeText(
                                        "${selectedDate.toLocal()}"
                                            .split(' ')[0],
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Tooltip(
                                message: 'Range of your EV on 100% charge',
                                showDuration: Duration(seconds: 3),
                                child: Text(
                                  'EV Full Range',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter your EVs Mileage";
                                }
                                final n = num.tryParse(value);
                                if (n == null) {
                                  return '"$value" is not a valid number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              controller: batteryCapacityController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: "100 " + dropdownValue.toString(),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
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
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Tooltip(
                                message: "Your EV's battery capacity in KWH",
                                showDuration: Duration(seconds: 3),
                                child: Text(
                                  'EV Battery Capacity',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter your EVs Mileage";
                                }
                                final n = num.tryParse(value);
                                if (n == null) {
                                  return '"$value" is not a valid number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              controller: batteryCapController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: '2.4 KWH',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
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
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Tooltip(
                                message:
                                    'Unit price of electicity in your area',
                                showDuration: Duration(seconds: 3),
                                child: AutoSizeText(
                                  ' Electricity Unit Price ',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter Electricity price";
                                }
                                final n = num.tryParse(value);
                                if (n == null) {
                                  return '"$value" is not a valid number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              controller: electricityPriceController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText:
                                    logo != null ? "5 " + logo.symbol : "₹ 5",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
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
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Tooltip(
                                message:
                                    'Per litre price of petrol in your area',
                                showDuration: Duration(seconds: 3),
                                child: Text(
                                  'Petrol Price',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter Petrol Price";
                                }
                                final n = num.tryParse(value);
                                if (n == null) {
                                  return '"$value" is not a valid number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              controller: petrolPrizeController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: logo != null
                                    ? "100 " + logo.symbol
                                    : "₹ 100",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
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
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Tooltip(
                                message:
                                    'Distance covered by the petrol vehicle in 1 litre of petrol',
                                showDuration: Duration(seconds: 3),
                                child: AutoSizeText(
                                  ' Petrol vehicle Mileage ',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter Petrol Vehical Mileage";
                                }
                                final n = num.tryParse(value);
                                if (n == null) {
                                  return '"$value" is not a valid number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              controller: petrolVehicalMileageController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText:
                                    '40 ' + dropdownValue.toString() + '/Ltr',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
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
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Long press on label to know more",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            color: Color(0xff03adc6).withOpacity(0.7),
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: TextButton.icon(
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              if (logo != null) {
                                await setDatatoSP();
                                print("set prefrence");
                                if (!widget.fromMainPage) {
                                  print('reload');
                                  widget.reload();
                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "Please select Curreny",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                  margin:
                                      EdgeInsets.fromLTRB(20.0, 0, 20.0, 60.0),
                                  action: SnackBarAction(
                                    label: 'CLOSE',
                                    textColor: Colors.white,
                                    onPressed: ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar,
                                  ),
                                ));
                              }
                            }
                          },
                          icon: Icon(
                            Icons.save_alt_rounded,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
