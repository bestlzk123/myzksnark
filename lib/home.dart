import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/syllabus_home.dart';
import 'package:myapp/utils/global_value.dart';

import 'forum_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String title = 'FutureBuilder使用';
  var _futureBuilderFuture;
  int _currentIndex = 0;
  Future<String> _gerData() async {
    await SpUtil.getInstance();
    await DbUtil.getInstance();
    return "ok";
  }
  @override
  void initState() {
    // TODO: implement initState
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
              children: [ListPage(), SyllabusHome()]),
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
