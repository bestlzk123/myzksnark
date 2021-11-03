import 'package:myapp/entity/note.dart';

class NoteTransporter {
  static Future<void> NoteUpload(Note note) async {
      if (note.replyid == -1) await PostNoteUpload(note);
      else await PostNoteUpload(note);
  }
  static Future<void> PostNoteUpload(Note note) async {

  }
  static Future<void> ReplyNoteUpload(Note note) async {

  }
}