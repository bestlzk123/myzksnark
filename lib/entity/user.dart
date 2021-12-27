const String columnUserId2 = "user_id"; //属性名
const String columnUserName2 = "user_name" ; //属性名

class User {
  String userName = "";
  int userId = 0;
  User();
  User.fromMap(Map<String, dynamic> map) {

    userId = map[columnUserId2]?? 0;
    userName = map[columnUserName2] ?? "";
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUserName2:userName,
      columnUserId2:userId,
    };
    //map[columnId] = id;
    return map;
  }
}