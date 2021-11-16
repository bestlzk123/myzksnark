import 'package:myapp/entity/course.dart';
import 'package:myapp/entity/note.dart';
import 'package:sqflite/sqflite.dart';

// 数据库操作工具类
class CourseDbHelper {
  Database? db ;

  Future open() async {
    // 打开/创建数据库
    await db!.execute("create table courses (_id INTEGER primary key autoincrement,teacher_id TEXT not null,teacher_name TEXT not null,course_id TEXT not null,cindex INTEGER not null,course_name TEXT not null,room_id TEXT not null,room_name TEXT not null)");
  }
  Future<Database> getDatabase() async {
    Database database = db!;
    return database;
  }

  // 增加一条数据
  Future<Course> insert(Course note) async {

    print(await db!.insert("courses", note.toMap()));
    return note;
  }

  // 通过ID查询一条数据
  Future<Course?> getNoteByIndex(int index) async {
    List<Map<String,dynamic>> maps = await db!.query('courses',
        columns: [
          columnTeacherId,
          columnTeacherName,
          columnCourseId,
          columnIndex,
          columnCourseName,
          columnRoomId,
          columnRoomName,
        ],
        where: 'cindex = ?',
        whereArgs: [index]);
    if (maps.isNotEmpty) {
      return Course.fromMap(maps.first);
    }
    return null;
  }
  // 关闭数据库
  Future close() async => db!.close();
}