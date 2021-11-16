import 'package:myapp/utils/course_db_helper.dart';
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
  static late CourseDbHelper courseDbHelper;
  static Future<bool> getInstance() async{
    noteDbHelper = NoteDbHelper();
    await getDatabasesPath().then((string) async {
      String path = join(string, 'notesDb.db');
      await noteDbHelper.open(path);
    });
    courseDbHelper = CourseDbHelper();
    courseDbHelper.db = noteDbHelper.db;
    await courseDbHelper.open();
    return true;
  }
}
