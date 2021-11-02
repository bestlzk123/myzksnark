import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadPage extends StatefulWidget {
  // const ReadPage({
  //   Key key,
  //   @required this.noteDbHelpter,
  //   @required this.id,
  // }) : super(key: key);

  // final NoteDbHelper noteDbHelpter;
  // final int id;

  @override
  State<StatefulWidget> createState() {
    return ReadPageState();
  }
}

class ReadPageState extends State<ReadPage> with WidgetsBindingObserver {
  // String note = "";
  // Note noteEntity;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    // widget.noteDbHelpter.getNoteById(widget.id).then((notes) {
    //   setState(() {
    //     note = notes.content;
    //     noteEntity = notes;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        title: Text('日记详情'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WritePage(

                  );
                }));
              })
        ],
      ),
      body: Container(
        child: CustomScrollView(
          shrinkWrap: false,
          primary: false,
          // 回弹效果
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(50, 5, 10, 5),
                      child: Icon(
                        Icons.wb_sunny,
                        size: 50,
                        color: Color.fromRGBO(252, 205, 24, 1),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '这是标题？？',
                          style: TextStyle(
                              color: Color.fromRGBO(149, 149, 148, 1),
                              fontSize: 18),
                        ),
                        Text(
                          '这是什么？副标题？',
                          style: TextStyle(
                              color: Color.fromRGBO(149, 149, 148, 1),
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  '这个才是正文',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // //当移除渲染树的时候调用
  // @override
  // void deactivate() {
  //   super.deactivate();
  //   var bool = ModalRoute.of(context).isCurrent;
  //   if (bool) {
  //     widget.noteDbHelpter.getNoteById(widget.id).then((notes) {
  //       setState(() {
  //         note = notes.content;
  //       });
  //     });
  //     // 发送事件、数据
  //     eventBus.fire(NoteEvent(widget.id));
  //   }
  // }
  //
  // //APP生命周期监听
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     //恢复可见
  //     widget.noteDbHelpter.getNoteById(widget.id).then((notes) {
  //       setState(() {
  //         note = notes.content;
  //       });
  //     });
  //   } else if (state == AppLifecycleState.paused) {
  //     //处在并不活动状态，无法处理用户响应
  //     //例如来电，画中画，弹框
  //   } else if (state == AppLifecycleState.inactive) {
  //     //不可见，后台运行，无法处理用户响应
  //   }
  //   super.didChangeAppLifecycleState(state);
  // }

  //组件即将销毁时调用
  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance.removeObserver(this);
  }
}

class WritePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WritePageState();
  }

}

class WritePageState extends State<WritePage> {
  String notes = "";

  @override
  void initState() {
    super.initState();
    // if (widget.id != -1) {
    //   widget.noteDbHelpter.getNoteById(widget.id).then((note) {
    //     setState(() {
    //       notes = note.content;
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(244, 244, 244, 1),
          title: Text("书写日记"),
          actions: <Widget>[
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                    child: TextField(
                      controller: TextEditingController.fromValue(TextEditingValue(
                        // 设置内容
                          text: notes,
                          // 保持光标在最后
                          selection: TextSelection.fromPosition(TextPosition(
                              affinity: TextAffinity.downstream,
                              offset: notes.length)))),
                      onChanged: (text) {
                        setState(() {
                          notes = text;
                        });
                      },
                      maxLines: null,
                      style: TextStyle(),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration.collapsed(
                        hintText: "点此输入你的内容",
                      ),
                    ),
                  )),
              Row(
                children: <Widget>[
                  Container(
                    child: IconButton(
                        icon: Icon(
                          Icons.wb_sunny,
                          color: Colors.grey,
                        ),
                        onPressed: () {}),
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(
                          Icons.star_border,
                          color: Colors.grey,
                        ),
                        onPressed: () {}),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}