import 'package:myapp/entity/note.dart';
import 'package:sqflite/sqflite.dart';

// 数据库操作工具类
class NoteDbHelper {
  Database? db ;

  Future open(String path) async {
    // 打开/创建数据库
    db = await openDatabase(path, version: 4,
        onCreate: (Database db, int version) async {
          await db.execute(
              "create table notes (_id INTEGER primary key autoincrement,theme TEXT not null,text TEXT not null,time INTEGER not null,num INTEGER not null,reply_id INTEGER not null,post_id INTEGER not null,user_id INTEGER not null)");
          print("Table is created");
        });
  }
  Future<Database> getDatabase() async {
    Database database = db!;
    return database;
  }

  // 增加一条数据
  Future<Note> insert(Note note) async {
    note.id = await db!.insert("notes", note.toMap());
    print(note.id);
    return note;
  }

  // 通过ID查询一条数据
  Future<Note?> getNoteById(int id) async {
    List<Map<String,dynamic>> maps = await db!.query('notes',
        columns: [
          columnId,
          columnTitle,
          columnContent,
          columnTime,
          columnReply,
          columnPostId,
          columnReplyId,
        ],
        where: '_id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    }
    return null;
  }

  // 通过关键字查询数据
  Future<List<Note>?> getNoteByContent(String text) async {
    List<Note> _noteList = List.empty(growable: true);
    List<Map<String,dynamic>> maps = await db!.query('notes',
        columns: [
          columnId,
          columnTitle,
          columnContent,
          columnTime,
          columnReply,
          columnPostId,
          columnReplyId,
        ],
        where: 'content like ? ORDER BY time ASC',
        whereArgs: ["%" + text + "%"]);
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        _noteList.add(Note.fromMap(maps.elementAt(i)));
      }
      return _noteList;
    }
    return null;
  }

  // 通过ID删除一条数据
  Future<int> deleteById(int id) async {
    return await db!.delete('notes', where: '_id = ?', whereArgs: [id]);
  }

  // 更新数据
  Future<int> update(Note note) async {
    return await db!
        .update('notes', note.toMap(), where: '_id = ?', whereArgs: [note.id]);
  }
  // 清除表格
  Future<int> delete() async {
    return await db!.delete('notes');
  }
  // 关闭数据库
  Future close() async => db!.close();
}