import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Preference.Initit();
  runApp(MaterialApp(home: mainPage(),debugShowCheckedModeBanner: false,));
}

class Preference{
  static SharedPreferences? prefs;
  static Initit() async {
    prefs=await SharedPreferences.getInstance();
    print("pre");
  }
  static setLevelWin(int levelIndex,int logoindex){
    prefs?.setString('WinLevel$levelIndex,$logoindex', "Win");
  }
  static getLevelWin(int levelIndex,int logoindex)
  {
    return prefs?.getString("WinLevel$levelIndex,$logoindex")??"Pending";
  }
  static setlogoComplete(int levelIndex,int number)
  {
    prefs?.setInt('TotalLevel_$levelIndex', number);
  }
  static getlogComplete(int levelIndex){
    return prefs?.getInt('TotalLevel_$levelIndex')??0;
  }
}
