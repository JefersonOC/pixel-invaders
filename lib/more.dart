import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:pixel_invaders/developer.dart';
import 'package:pixel_invaders/preferences.dart';
import 'package:pixel_invaders/util.dart';
import 'package:share/share.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";
  int score = 0;

  var myGoogleFont = GoogleFonts.orbitron(
      textStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30));

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  void _loadPackageInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appName = packageInfo.appName;
        packageName = packageInfo.packageName;
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });

    AppPreferences.getHighScoreKey().then((value) {
      setState(() {
        score = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          'Menu',
          style: myGoogleFont,
        ),
      ),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _buildListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: <Widget>[
          _buildListItem(("VERSION\n" + version).toUpperCase(), "VERSION",
              Colors.black, FontAwesomeIcons.mobileAlt),
          SizedBox(
            height: 1,
          ),
          _buildListItem(("HIGH SCORE\n" + score.toString()).toUpperCase(),
              "SCORE", Colors.black, FontAwesomeIcons.flagCheckered),
          SizedBox(
            height: 1,
          ),
          _buildListItem("INVITE FRIENDS".toUpperCase(), "SHARE", Colors.black,
              FontAwesomeIcons.shareAlt),
          SizedBox(
            height: 1,
          ),
          _buildListItem("RATE US".toUpperCase(), "RATING", Colors.black,
              FontAwesomeIcons.solidStar),
          SizedBox(
            height: 1,
          ),
          _buildListItem("DEVELOPER".toUpperCase(), "DEV", Colors.black,
              FontAwesomeIcons.code),
          SizedBox(
            height: 1,
          ),
          _buildListItem("BACK".toUpperCase(), "EXIT", Colors.black,
              FontAwesomeIcons.arrowLeft),
        ],
      ),
    );
  }

  Widget _buildListItem(
      String category, String filter, Color color, IconData icon) {
    return Material(
      color: color,
      child: InkWell(
        onTap: () {
          switch (filter) {
            case "VERSION":
              break;
            case "RATING":
              Util.launchURL("link");
              Fluttertoast.showToast(
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  gravity: ToastGravity.CENTER,
                  msg: "Esta gostando do game? " +
                      "Que tal fazer uma avaliação na Play Store? " +
                      "É rápido e ajuda o game a crescer!",
                  toastLength: Toast.LENGTH_LONG);
              break;
            case "DEV":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeveloperPage(
                    title: "Dev",
                  ),
                ),
              );
              break;
            case "SHARE":
              Share.share("Olha esse game que encontrei: (link)");
              break;
            case "EXIT":
              Navigator.pop(context);
              break;
            default:
              break;
          }
        },
        child: Container(
          height: 150,
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
                size: 32.0,
              ),
              SizedBox(width: 24),
              Flexible(
                child: Text(
                  category,
                  overflow: TextOverflow.ellipsis,
                  style: myGoogleFont.copyWith(fontSize: 24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
