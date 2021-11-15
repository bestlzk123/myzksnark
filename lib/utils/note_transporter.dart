import 'dart:convert';
import 'dart:io';

import 'package:myapp/entity/note.dart';

import 'global_value.dart';

class NoteTransporter {
  static String backgroundUrl = '192.168.0.113:8080';
  //static String backgroundUrl = '192.168.0.108:8080';
  static Future<int> noteUpload(Note note) async {
    const postName = "/post/up";
    const replyName = "/reply/up";
      if (note.replyId == -1) {
        return await noteUploadWithName(note,postName);
      } else {
        return await noteUploadWithName(note,replyName);
      }
  }

  static Future<int> noteUploadWithName(Note note,String name) async {
    final httpClient = HttpClient();
    // 2.构建请求的uri
    var uri = Uri.http(
      backgroundUrl, name);
    // 3.构建请求
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set("content-type", "application/json");
    Map jsonMap = note.toMap();
    //jsonMap.addAll({}});
    request.add(utf8.encode(json.encode(jsonMap)));
    // 4.发送请求，必须
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      return 0;
    }
    else {
      return -1;
    }
  }
  static Future<int> postNoteReload() async {
    final httpClient = HttpClient();
    // 2.构建请求的uri
    var uri = Uri.http(
        backgroundUrl, "/post/getAllpost");
    // 3.构建请求
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set("content-type", "application/json");
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String responseString = await response.transform(utf8.decoder).join();
      Map<String, dynamic> map = json.decode(responseString);
      DbUtil.noteDbHelper.delete();
      for(var i in map['post_list']) {
        Note s = Note.fromMap(Map<String, dynamic>.from(i));
        DbUtil.noteDbHelper.insert(s);
      }
      return 0;
    }
    else {
      return -1;
    }
  }

  static Future<int> postNoteLoad() async {
    final httpClient = HttpClient();
    // 2.构建请求的uri
    var uri = Uri.http(
        backgroundUrl, "/post/load");
    // 3.构建请求
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set("content-type", "application/json");
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String responseString = await response.transform(utf8.decoder).join();
      Map<String, dynamic> map = json.decode(responseString);
      for(var i in map['post_note']) {
        Note s = Note.fromMap(Map<String, dynamic>.from(i));
        await DbUtil.noteDbHelper.insert(s);
      }

      return 0;
    }
    else {
      return -1;
    }
  }

  static Future<List<Note>> replyNoteLoad(Note note) async{
    List<Note> list= List.empty(growable: true);
    final httpClient = HttpClient();
    // 2.构建请求的uri
    var uri = Uri.http(
        backgroundUrl, "/reply/down");
    // 3.构建请求
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set("content-type", "application/json");
    Map jsonMap = {"post_id":note.postId};
    request.add(utf8.encode(json.encode(jsonMap)));
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String responseString = await response.transform(utf8.decoder).join();
      Map<String, dynamic> map = json.decode(responseString);
      for (var i in map['post_note']) {
        Note s = Note.fromMap(Map<String, dynamic>.from(i));
        list.add(s);
      }
    }
      return list;
  }
}