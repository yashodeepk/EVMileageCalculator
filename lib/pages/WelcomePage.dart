import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mileagecalculator/Database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePageWidget extends StatefulWidget {
  @override
  _WelcomePageWidgetState createState() => _WelcomePageWidgetState();
}

class _WelcomePageWidgetState extends State<WelcomePageWidget> {
  TextEditingController batteryCapacityController = TextEditingController();
  TextEditingController electricityPriceController = TextEditingController();
  TextEditingController petrolPrizeController = TextEditingController();
  TextEditingController petrolVehicalMileageController =
      TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String select = "Select";
  String logo = '';

  @override
  void initState() {
    super.initState();
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
    if (selectcurrency != null) {
      setState(() {
        logo = selectcurrency;
      });
    }
  }

  void setDatatoSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('battery_Capacity', batteryCapacityController.text);
    prefs.setString('electricity_Price', electricityPriceController.text);
    prefs.setString('petrol_Prize', petrolPrizeController.text);
    prefs.setString(
        'petrol_Vehical_Mileage', petrolVehicalMileageController.text);
    prefs.setString('select_currency', logo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF22262B),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Setup Page",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      key: scaffoldKey,
      backgroundColor: Color(0xFF22262B),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Center(
                            child: Text(
                              'Battery Capacity',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                            controller: batteryCapacityController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'kWh',
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
                            child: Text(
                              'Electricity Price',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                            controller: electricityPriceController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: '₹',
                              hintStyle: TextStyle(
                                color: Colors.white,
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
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                            controller: petrolPrizeController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: '₹',
                              hintStyle: TextStyle(
                                color: Colors.white,
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
                            child: AutoSizeText(
                              'Petrol Vehical Mileage',
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                            controller: petrolVehicalMileageController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Km/Ltr',
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
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                decoration: BoxDecoration(
                                    color: Color(0xff03adc6).withOpacity(0.7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24))),
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

                                          logo = currency.symbol;
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                          color: Color(0xff03adc6).withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: TextButton.icon(
                        onPressed: () {
                          setDatatoSP();
                          print("set prefrence");
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
