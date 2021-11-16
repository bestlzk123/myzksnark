
import '../main.dart';
import 'note.dart';
import 'package:myapp/utils/note_transporter.dart';

class PostNotes {
  late Note postNote;
  List<Note> replyNotes = List.empty();
  PostNotes();
  Future<int> inital() async{
    if (debugFlag) {
      mockLoadReply(postNote);
    } else {
      await loadReply(postNote);
    }
    return 0;
  }
  Future<int> loadReply(note) async {
    //replyNotes = List.empty(growable: true);
    replyNotes = await NoteTransporter.replyNoteLoad(note);
    return 0;
  }
  void mockLoadReply(note) {
    replyNotes = List.empty(growable: true);
    Note reply1 = Note.fromMap({
      columnTitle:"youshouldnotseeit",
      columnContent:"1:5	神称光为昼、称暗为夜．有晚上、有早晨、这是头一日。1:6	神说、诸水之间要有空气、将水分为上下。1:7	神就造出空气、将空气以下的水、空气以上的水分开了．事就这样成了。1:8	神称空气为天．有晚上、有早晨、是第二日。 ",
      columnTime:DateTime.now().toString(),
      columnReply:0,//should not use
      columnReplyId:2,
      columnPostId:1,
    });
    print("I created reply1");
    print("postid:"+reply1.postId.toString());
    print(reply1.content.toString());
    replyNotes.add(reply1);
    Note reply2 = Note.fromMap({
      columnTitle:"youshouldnotseeit",
      columnContent:"1:9	神说、天下的水要聚在一处、使旱地露出来．事就这样成了。1:10	神称旱地为地、称水的聚处为海．　神看着是好的。1:11	神说、地要发生青草、和结种子的菜蔬、并结果子的树木、各从其类、果子都包着核．事就这样成了。1:12	于是地发生了青草、和结种子的菜蔬、各从其类、并结果子的树木、各从其类、果子都包着核。　神看着是好的．1:13	有晚上、有早晨、是第三日。  ",
      columnTime:DateTime.now().toString(),
      columnReply:0,//should not use
      columnReplyId:3,
      columnPostId:1});
    replyNotes.add(reply2);
    print("I created reply2");
  }
}