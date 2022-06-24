import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<List<String>?> read(String str) async {
    //List , Adv
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList(str) == null) {
      return [];
    } else {
      return prefs.getStringList(str);
    }
  }

  Future<int?> readInt(String str) async {
    //deviceModeId,TotalWorkoutSessions,TotalDays
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (str == 'deviceModeId') {
      if (prefs.getInt(str) == null) {
        return 1;
      }
    } else {
      return prefs.getInt(str);
    }
  }

  Future<String?> readString(String str) async {
    //Voice,LastWorkout,TotalWorkoutHours,ReleaseDateOfDatabase
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(str);
  }

  Future<bool?> readBool(String str) async {
    //isVoice
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(str) == null) {
      if (str == 'isDark' || str == 'isContrast')
        return false;
      else
        return true;
    } else {
      return prefs.getBool(str);
    }
  }

  reset(String key, List value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, []);
    // prefs.setString(key, json.encode(value));
  }

  save(String str, List value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(str, value as List<String>);
    // prefs.setString(key, json.encode(value));
  }

  saveInt(String prefName, int val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefName, val);
  }

  saveString(String prefName, String val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefName, val);
  }

  saveBool(String prefName, bool val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefName, val);
  }

  remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
