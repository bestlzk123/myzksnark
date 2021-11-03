import 'package:flutter/material.dart';
import 'PageState.dart';
import 'PersistentStorage.dart';
import 'forum_list.dart';
import 'login.dart';
bool debugFlag = true;
void main() {
  realRunApp();
}

void realRunApp() async {
  runApp(MyApp());
  SpUtil.getInstance();
}
// void main() => requestNetwork();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.computer),
        onPressed: (){
          if (debugFlag) {
            print("debug");
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPage())
            );
          } else if (SpUtil.preferences.getString('timeInfo') != null && !debugFlag){
            print("skip");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SyllabusPage())
            );
          } else {
            print("nskip");
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login())
          );}
        },
      ),

    );
  }
}
