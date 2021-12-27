import 'package:flutter/material.dart';

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


  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
//设置 用户信息 用户名 头像
          UserAccountsDrawerHeader(
            accountName: new Text(widget.id.toString()),
            accountEmail: new Text("nigulasi@email.com"),
//当前头像
            currentAccountPicture: new CircleAvatar(
              backgroundImage: new  AssetImage("images/1.jpeg"),
            ),
            onDetailsPressed: (){},
//其他账号头像
            otherAccountsPictures: <Widget>[
              new Container(
                child: Image.asset("images/like.jpg"),
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
              child: new Icon(Icons.wifi),
            ),
            title: new Text("wifi"),
          )
        ],
      ),
    );


  }
}