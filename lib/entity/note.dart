const String tableName = 'postNotes'; // 表名
const String columnId = '_id'; // 属性名
const String columnTitle = 'theme'; // 属性名 theme
const String columnContent = 'text'; // 属性名 text
const String columnTime = "time"; //属性名 edit_time
const String columnReply = "num"; //属性名 num
const String columnPostId = "post_id"; //属性名 id
const String columnReplyId = "reply_id";//属性名
const String columnUserId = "user_id"; //属性名
const String columnUserName = "user_name";
// 实体类
class Note {
  int id = 0; //本地使用id
  String title = "";
  String content = "";
  String time = DateTime(1970).toString();
  int reply = 0;
  int replyId = 0; // 帖子作为回帖的id，当为主题帖时，replyid = 1
  int postId = 0; // 帖子的父节点id
  int userId = 0 ;// 发帖人id
  String userName = "";
  // 将实体对象类转为数据集合
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnContent: content,
      columnTime: time,
      columnReply: reply,
      columnReplyId:replyId,
      columnPostId:postId,
      columnUserId:userId,
      columnUserName:userName
    };
    //map[columnId] = id;
    return map;
  }
  // 构造方法/实例化方法
  Note();
  // 通过数据集合返回一个实体对象
  Note.fromMap(Map<String, dynamic> map) {
    id = map[columnId] ?? 0;
    title = map[columnTitle] ?? "";
    content = map[columnContent];
    time = map[columnTime] ?? DateTime(1970).toString();
    reply = map[columnReply] ?? 0;
    replyId = map[columnReplyId]?? 0;
    postId = map[columnPostId] ?? 0;
    userId = map[columnUserId]?? 0;
    userName = map[columnUserName] ?? "";
  }
}
