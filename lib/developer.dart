import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_invaders/util.dart';

class DeveloperPage extends StatefulWidget {
  final String title;

  DeveloperPage({Key key, this.title}) : super(key: key);

  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  var myGoogleFont = GoogleFonts.orbitron(
      textStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: myGoogleFont,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.globeAmericas),
            onPressed: () {
              Util.launchURL("http://blackfishlabs.com.br");
            },
          ),
        ],
      ),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: myGoogleFont.copyWith(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'BLACKFISH LABS\n',
            ),
            TextSpan(
              text: "blackfishlabs.com.br",
              style: myGoogleFont.copyWith(color: Colors.black, fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
