import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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
                              "How MileageCalculator Works🤔?",
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
                                    text: "This Application uses GPS Location ",
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
                                    text: " to find speed of vehicle.",
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
                                        "Then Using Distance we calculate Battery percentage and traveling cost.",
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
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 43,
                      child: RichText(
                        maxLines: 3, textScaleFactor: 1.3,
                        overflow: TextOverflow.ellipsis,
                        // textDirection: TextDirection.rtl,
                        // textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Depending on Phone Hardware Application can give False reading 😕.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 43,
                      child: RichText(
                        maxLines: 3, textScaleFactor: 1.3,
                        overflow: TextOverflow.ellipsis,
                        // textDirection: TextDirection.rtl,
                        // textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Values provided by application are just for reference purposes.",
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
                                  IconButton(
                                      onPressed: _instagramyashodeep,
                                      icon: Icon(
                                        LineIcons.instagram,
                                        color: Colors.purpleAccent,
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
                                  IconButton(
                                      onPressed: _instagrampranav,
                                      icon: Icon(
                                        LineIcons.instagram,
                                        color: Colors.purpleAccent,
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
  void _instagrampranav() async =>
      await canLaunch('https://www.instagram.com/pranav_222000/?hl=en')
          ? await launch('https://www.instagram.com/pranav_222000/?hl=en')
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
  void _instagramyashodeep() async =>
      await canLaunch('https://www.instagram.com/yashodeep_kacholiya/?hl=en')
          ? await launch('https://www.instagram.com/yashodeep_kacholiya/?hl=en')
          : throw 'Faild to launch';
}
