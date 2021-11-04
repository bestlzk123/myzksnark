import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/utils/global_value.dart';
import 'login.dart';
import 'main.dart';

class SyllabusHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if (SpUtil.preferences.getString('timeInfo') != null || debugFlag) {
      return SyllabusPage();
    } else {
      return Login();
    }
    // return Scaffold(
    //   floatingActionButton: FloatingActionButton(
    //     child: const Icon(Icons.computer),
    //     onPressed: (){
    //       if (debugFlag) {
    //         print("debug");
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => )
    //         );
    //       } else if (){
    //         print("skip");
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => SyllabusPage())
    //         );
    //       } else {
    //         print("nskip");
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => )
    //         );}
    //     },
    //   ),
    //
    // );
  }
}