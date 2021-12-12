const String columnUserId = "user_id"; //属性名
const String columnUserName = "user_name"; //属性名

class User {
  String userName = "";
  int userId = 0;
  User();
  User.fromMap(Map<String, dynamic> map) {

    userId = map[columnUserId]?? 0;
    userName = map[columnUserName] ?? "";
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUserName:userName,
      columnUserId:userId,
    };
    //map[columnId] = id;
    return map;
  }
}