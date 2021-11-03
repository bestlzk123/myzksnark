const String tableName = 'postNotes'; // 表名
const String columnId = '_id'; // 属性名
const String columnTitle = 'title'; // 属性名
const String columnContent = 'content'; // 属性名
const String columnTime = "time"; //属性名
const String columnReply = "reply"; //属性名
const String columnPostId = "post_id"; //属性名
const String columnReplyId = "reply_id";//属性名
// 实体类
class Note {
  int id = 0; //本地使用id
  String title = "";
  String content = "";
  int time = 0;
  int reply = 0;
  int replyid = 0; // 帖子作为回帖的id，当为主题帖时，replyid = postid
  int postid = 0; // 帖子的父节点id
  // 将实体对象类转为数据集合
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnContent: content,
      columnTime: time,
      columnReply: reply,
      columnReplyId:replyid,
      columnPostId:postid,
    };
    map[columnId] = id;
    return map;
  }
  // 构造方法/实例化方法
  Note();
  // 通过数据集合返回一个实体对象
  Note.fromMap(Map<String, dynamic> map) {
    //id = map[columnId];
    title = map[columnTitle];
    content = map[columnContent];
    time = map[columnTime];
    reply = map[columnReply];
    replyid = map[columnReplyId];
    postid = map[columnPostId];
  }
}
