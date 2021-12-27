
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/utils/global_value.dart';

import 'entity/note.dart';
import 'login.dart';
import 'main.dart';

class InitialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitialPageState();
}

class InitialPageState extends State<InitialPage> {
  String title = 'FutureBuilder使用';
  var _futureBuilderFuture;
  void debugMode() async{
    print("debug");
    Note note = Note.fromMap({
      columnTitle:"testTitle",
      columnContent:"起初　神创造天地。1:2 地是空虚混沌．渊面黑暗．神的灵运行在水面上1:3 神说、要有光、就有了光。1:4 神看光是好的、就把光暗分开了。",
      columnTime:DateTime.now().toString(),
      columnReply:2,
      columnReplyId:0,
      columnPostId:0});
    await DbUtil.noteDbHelper.insert(note);
  }
  Future<String> _gerData() async {
    await SpUtil.getInstance();
    await DbUtil.getInstance();
    if (debugFlag) debugMode();
    return "ok";
  }
  @override
  void initState() {
    super.initState();
    ///用_futureBuilderFuture来保存_gerData()的结果，以避免不必要的ui重绘
    _futureBuilderFuture = _gerData();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:_futureBuilderFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return Login();
          }else{
            return Container(
              color: Colors.white,
              child: Center(
                child: Text("数据加载中……",style: TextStyle(fontSize: 20, color: Colors.orange)),
              ),
            );
          }
        });
  }
}
