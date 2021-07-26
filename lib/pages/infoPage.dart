import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:currency_picker/currency_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int flagOffset = 0x1F1E6;
  int asciiOffset = 0x41;

  final codeToCountryEmoji = (code) {
    final char1 = code.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final char2 = code.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(char1) + String.fromCharCode(char2);
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF22262B),
        title: Text('Info Page'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Color(0xFF22262B),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.circle,
                              color: Color(0xFF03adc6),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "How MileageCalculator Works😕?",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            child: RichText(
                              maxLines: 3, textScaleFactor: 1.3,
                              overflow: TextOverflow.ellipsis,
                              // textDirection: TextDirection.rtl,
                              // textAlign: TextAlign.justify,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "This Application uses Gps Location ",
                                  ),
                                  WidgetSpan(
                                      child: Icon(
                                    LineIcons.mapMarker,
                                    size: 16,
                                    color: Color(0xFF03adc6),
                                    // color: Colors.blue,
                                  )),
                                  TextSpan(
                                    text:
                                        " to Find Distance and Accelerometer ",
                                  ),
                                  WidgetSpan(
                                    child: Icon(LineIcons.microchip,
                                        size: 16, color: Colors.green),
                                  ),
                                  TextSpan(
                                    text: " to find speed of vehicle",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          //   child: Text(
                          //     "Application uses Gps Location \u{1F4CD} to Find Distance and Accelerometer to find speed of vehical",
                          //     style: TextStyle(
                          //         fontSize: 18, fontWeight: FontWeight.w600),
                          //     textAlign: TextAlign.left,
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: RichText(
                              maxLines: 3, textScaleFactor: 1.3,
                              overflow: TextOverflow.ellipsis,
                              // textDirection: TextDirection.rtl,
                              // textAlign: TextAlign.justify,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "Then Using Distance we calculate Battery persentage and Traveling costs ",
                                  ),
                                  // WidgetSpan(
                                  //   child: Icon(LineIcons.mapMarker, size: 14),
                                  // ),
                                  // TextSpan(
                                  //   text:
                                  //       " to Find Distance and Accelerometer ",
                                  // ),
                                  // WidgetSpan(
                                  //   child: Icon(LineIcons.compass, size: 14),
                                  // ),
                                  // TextSpan(
                                  //   text: " to find speed of vehicle",
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          //   child: Text(
                          //     "Application uses Gps Location \u{1F4CD} to Find Distance and Accelerometer to find speed of vehical",
                          //     style: TextStyle(
                          //         fontSize: 18, fontWeight: FontWeight.w600),
                          //     textAlign: TextAlign.left,
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.circle,
                        color: Color(0xFF03adc6),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Accuracy",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: RichText(
                        maxLines: 3, textScaleFactor: 1.3,
                        overflow: TextOverflow.ellipsis,
                        // textDirection: TextDirection.rtl,
                        // textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Depending on Phone Hardware Application can give False reding 😟",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text(
                        "Devloped By -",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    width: MediaQuery.of(context).size.width - 30,
                    // height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.grey[800],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                          // offset:
                          //     Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xff03adc6),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/y.jpg'),
                            radius: 50,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Yashodeep Kacholiya",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: _linkedinyashodeep,
                                      icon: Icon(
                                        LineIcons.linkedinIn,
                                        size: 32,
                                        color: Colors.blue,
                                      )),
                                  IconButton(
                                      onPressed: _githubyashodeep,
                                      icon: Icon(
                                        LineIcons.github,
                                        color: Colors.white,
                                        size: 32,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    width: MediaQuery.of(context).size.width - 30,
                    // height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.grey[800],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                          // offset:
                          //     Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xff03adc6),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/p.jpg'),
                            radius: 50,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Pranav Maid",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: _linkedinpranav,
                                      icon: Icon(
                                        LineIcons.linkedinIn,
                                        size: 32,
                                        color: Colors.blue,
                                      )),
                                  IconButton(
                                      onPressed: _githubpranav,
                                      icon: Icon(
                                        LineIcons.github,
                                        color: Colors.white,
                                        size: 32,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    // maxLines: 3, textScaleFactor: 1.3,
                    // overflow: TextOverflow.ellipsis,
                    // textDirection: TextDirection.rtl,
                    // textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Made In INDIA 🇮🇳",
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        // WidgetSpan(
                        //   child: Text(codeToCountryEmoji("IN")),
                        // ),
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

  void _linkedinpranav() async =>
      await canLaunch('https://www.linkedin.com/in/pranav-maid-99705717a/')
          ? await launch('https://www.linkedin.com/in/pranav-maid-99705717a/')
          : throw 'Faild to launch';
  void _githubpranav() async => await canLaunch('https://github.com/Pranavmaid')
      ? await launch('https://github.com/Pranavmaid')
      : throw 'Faild to launch';

  void _linkedinyashodeep() async => await canLaunch(
          'https://www.linkedin.com/in/yashodeep-kacholiya-84904911b/')
      ? await launch(
          'https://www.linkedin.com/in/yashodeep-kacholiya-84904911b/')
      : throw 'Faild to launch';
  void _githubyashodeep() async =>
      await canLaunch('https://github.com/yashodeepk')
          ? await launch('https://github.com/yashodeepk')
          : throw 'Faild to launch';
}
