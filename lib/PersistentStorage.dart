import 'package:shared_preferences/shared_preferences.dart';

/// 封装SharedPreferences为单例模式
class SpUtil{
  static late SharedPreferences preferences;
  static Future<bool> getInstance() async{
      preferences = await SharedPreferences.getInstance();
    return true;
  }
}

