import 'dart:convert';
import 'dart:io';

import 'package:myapp/entity/user.dart';

class UserTransporter {
  static String backgroundUrl = '192.168.0.113:8080';
  //static String backgroundUrl = '192.168.0.108:8080';
  static Future<User> userLoad(int id) async{
    final httpClient = HttpClient();
    // 2.构建请求的uri
    var uri = Uri.http(
        backgroundUrl, "/user/get");
    // 3.构建请求
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set("content-type", "application/json");
    Map jsonMap = {"user_id":id};
    request.add(utf8.encode(json.encode(jsonMap)));
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String responseString = await response.transform(utf8.decoder).join();
      Map<String, dynamic> map = json.decode(responseString);
      return User.fromMap(map);
      }
    else {
      return User();
    }
  }
  static Future<User> mockUserLoad(int id) async{
    User user = User();
    user.userName = "用户"+id.toString();
    user.userId = id;
    return user;
  }
}