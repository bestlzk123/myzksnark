import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PageState.dart';
import 'PersistentStorage.dart';

class httpRequest {
  static Future<void> requestNetwork(String stdNumber,String password) async {
    // 1.创建HttpClient对象
    final httpClient = HttpClient();
    const backgroundUrl = '192.168.0.108:8080';
    // 2.构建请求的uri
    var uri = Uri.http(
      backgroundUrl, '/timeTable',);
    // 3.构建请求
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.set("content-type", "application/json");
    Map jsonMap = {'stdNumber': stdNumber, 'password': password};
    //Map jsonMap = {'stdNumber': '17307110054', 'password': 'Baby9926'};
    //Map jsonMap = {'stdNumber': '18307130141', 'password': 'liu5ze2kai8?fudan'};
    //Map jsonMap = {'stdNumber': '17307110088', 'password': 'xzyxzy2018.'};
    request.add(utf8.encode(json.encode(jsonMap)));
    // 4.发送请求，必须
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      // print(await response.transform(utf8.decoder).join());
      String responseString = await response.transform(utf8.decoder).join();
      //print(responseString);
      Map<String, dynamic> map = json.decode(responseString);
      print('看这里maptimeInfo: ${map['timeInfo']}');
      print('看这里courseList: ${map['courseList']}');
      List classindex = [];
      for(var i in map['courseList']){
        var s = Map<String, dynamic>.from(i);
        print(s);
        Pattern r;
        classindex.add("\""+s["coursename"].replaceAll(RegExp('\\(.*\\)'), '') + "@" + s["roomname"]+"\"");
        print("????快来"+s["coursename"].replaceAll(RegExp('\\(.*\\)'), ''));
      }
      SpUtil.preferences.setString('timeInfo',map['timeInfo'].toString());
      print("hhhhhhhhhhhhh"+SpUtil.preferences.getString('timeInfo').toString());
      SpUtil.preferences.setString('classindex',classindex.toString());
    } else {
      print(response.statusCode);
    }
  }
}

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class CustomWidgetPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("组件封装"),
      centerTitle: true,),body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyRaisedButton(new SyllabusPage(), "课程表View")
      ],
    ),);
  }
}

class SyllabusPage extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    print(SpUtil.preferences.getString('timeInfo'));
    print(SpUtil.preferences.getString('classindex'));
    return PageState(SpUtil.preferences.getString('timeInfo'),SpUtil.preferences.getString('classindex'));
  }
}

class MyRaisedButton extends StatelessWidget {
  var _shapeBorder = new RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)));
  var _textStyle = new TextStyle(color: Colors.white, fontSize: 16.0);
  var _btnTitle;
  var _pageNavigator;

  MyRaisedButton(this._pageNavigator, this._btnTitle);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        //第一种写法
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => _pageNavigator));
        //第二张路由写法
//        Navigator.of(context)
//            .push(new MaterialPageRoute(builder: (context) => _pageNavigator));
      },
      child: Text(
        _btnTitle,
        style: _textStyle,
      ),
      color: Colors.lightGreen,
      highlightColor: Colors.green,
      shape: _shapeBorder,
    );
  }
}


class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  late String userName;
  late String password;
  bool isShowPassWord = false;

  Future<void> login() async {
    //读取当前的Form状态
    SpUtil.getInstance();
    var loginForm = loginKey.currentState;
    //验证Form表单
    if(loginForm!.validate()){
      loginForm.save();
      print('userName: ' + userName + ' password: ' + password);
      await httpRequest.requestNetwork(userName,password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SyllabusPage()));
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Form表单示例',
      home: new Scaffold(
        body: new Column(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
                child: new Text(
                  'FKD',
                  style: TextStyle(
                      color: Color.fromARGB(255, 53, 53, 53),
                      fontSize: 50.0
                  ),
                )
            ),
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new Form(
                key: loginKey,
                autovalidate: true,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0
                              )
                          )
                      ),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: '请输入您的复旦大学学号',
                          labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          // suffixIcon: new IconButton(
                          //   icon: new Icon(
                          //     Icons.close,
                          //     color: Color.fromARGB(255, 126, 126, 126),
                          //   ),
                          //   onPressed: () {

                          //   },
                          // ),
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          userName = value!;
                        },
                        validator: (phone) {
                          // if(phone.length == 0){
                          //   return '请输入手机号';
                          // }
                        },
                        onFieldSubmitted: (value) {

                        },
                      ),
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0
                              )
                          )
                      ),
                      child: new TextFormField(
                        decoration:  new InputDecoration(
                            labelText: '请输入密码',
                            labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                            border: InputBorder.none,
                            suffixIcon: new IconButton(
                              icon: new Icon(
                                isShowPassWord ? Icons.visibility : Icons.visibility_off,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                              onPressed: showPassWord,
                            )
                        ),
                        obscureText: !isShowPassWord,
                        onSaved: (value) {
                          password = value!;
                        },
                      ),
                    ),
                    new Container(
                      height: 43.0,
                      margin: EdgeInsets.only(top: 38.0),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          onPressed: login,
                          color: Color.fromARGB(255, 61, 25, 128),
                          child: new Text(
                            '登录',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 255, 255, 255)
                            ),
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(45.0)),
                        ),
                      ),
                    ),
                    // new Container(
                    //   margin: EdgeInsets.only(top: 30.0),
                    //   padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    //   child: new Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       new Container(
                    //         child:  Text(
                    //           '注册账号',
                    //           style: TextStyle(
                    //               fontSize: 13.0,
                    //               color: Color.fromARGB(255, 53, 53, 53)
                    //           ),
                    //         ),
                    //
                    //       ),
                    //
                    //       Text(
                    //         '忘记密码？',
                    //         style: TextStyle(
                    //             fontSize: 13.0,
                    //             color: Color.fromARGB(255, 53, 53, 53)
                    //         ),
                    //       ),
                    //     ],
                    //   ) ,
                    // ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
