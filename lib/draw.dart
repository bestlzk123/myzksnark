import 'package:flutter/material.dart';
import 'package:myapp/utils/global_value.dart';

class myDrawerState extends StatefulWidget {
  const myDrawerState({
    required this.id,
  });
  final int id;
  @override
  State<StatefulWidget> createState() {
    return myDrawer();
  }
}

class myDrawer extends State<myDrawerState> with WidgetsBindingObserver {
  int userid=1;
  String username="";
  String stdnumber="";
  @override
  void initState() {
    super.initState();
    setState(() {
      this.userid = SpUtil.preferences.getInt("userId")!;
      this.username = SpUtil.preferences.getString("userName")!;
      this.stdnumber = SpUtil.preferences.getString("stdNumber")!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
//设置 用户信息 用户名 头像
          UserAccountsDrawerHeader(
            accountName: new Text("ID号："+this.userid.toString()+"    学号："+this.stdnumber),
            accountEmail: new Text("昵称："+this.username,style: new TextStyle(
    fontSize: 16.0,),),
//当前头像
            currentAccountPicture: new CircleAvatar(
              backgroundImage: new  AssetImage("images/1.jpeg"),
            ),
            onDetailsPressed: (){},
//其他账号头像
            otherAccountsPictures: <Widget>[
              new Container(
                child: Image.asset("images/FKDicon.png"),
              )
            ],
          ),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.color_lens),
            ),
            title: Text("个性装扮"),
          ),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.photo),
            ),
            title: Text("我的相册"),
          ),
          ListTile(
            leading: new CircleAvatar(
              child: new Icon(Icons.account_circle),
            ),
            title: new Text("信息修改"),
          )
        ],
      ),
    );
    
  }
}
