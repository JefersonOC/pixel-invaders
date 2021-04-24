import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static saveHighScoreKey(int distance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('high_score_key', distance);
  }

  static Future<int> getHighScoreKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('high_score_key');
  }
}
