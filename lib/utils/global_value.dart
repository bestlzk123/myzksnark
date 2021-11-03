import 'package:myapp/utils/note_db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
/// 封装SharedPreferences为单例模式
class SpUtil{
  static late SharedPreferences preferences;
  static Future<bool> getInstance() async{
      preferences = await SharedPreferences.getInstance();
    return true;
  }
}

class DbUtil{
  static late NoteDbHelper noteDbHelper;
  static Future<bool> getInstance() async{
    noteDbHelper = NoteDbHelper();
    await getDatabasesPath().then((string) {
      String path = join(string, 'notesDb.db');
      noteDbHelper.open(path);
    });
    return true;
  }
}
