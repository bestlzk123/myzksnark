import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/syllabus_home.dart';
import 'package:myapp/utils/global_value.dart';
import 'package:myapp/write.dart';

import 'entity/note.dart';
import 'forum_list.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String title = 'FutureBuilder使用';
  var _futureBuilderFuture;
  int _currentIndex = 0;
  void debugMode() async{
    // try {
    //   DbUtil.noteDbHelper.deleteById(0);
    // } catch(Exeception){};
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
        return Scaffold(
          body: IndexedStack(
              index: _currentIndex,
              children: [ListPage(), SyllabusHome(), WritePage()]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            }, items: const [
              BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.home),
            title: Text("1"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.message),
              title: Text("2"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.control_point),
              title: Text("3"),
            ),]
          ),
        );
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
