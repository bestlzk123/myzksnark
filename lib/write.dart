import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/entity/note.dart';
import '/utils/note_transporter.dart';
import 'utils/global_value.dart';

class WritePage extends StatefulWidget {
  /*
  const WritePage({
    Key key,
    //@required this.noteDbHelpter,
    @required this.id,
  }) : super(key: key);
*/
  //final NoteDbHelper noteDbHelpter;
  final int id = 1;

  @override
  State<StatefulWidget> createState() {
    return WritePageState();
  }
}

class WritePageState extends State<WritePage> {
  //String notes = "123";
  String titles = "";
  String contents = "";

  @override
  void initState() {
    super.initState();
    if (widget.id != -1) {
      /*widget.noteDbHelpter.getNoteById(widget.id).then((note) {
        setState(() {
          notes = note.content;
        });
      });*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(65, 105, 225, 1),
          title: new Text(
            "新帖发布",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "发布",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                save(context);
              },
              splashColor: Colors.white,
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                color: Colors.grey[100],
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                    child: TextField(
                  controller: TextEditingController.fromValue(TextEditingValue(
                      // 设置内容
                      text: titles,
                      // 保持光标在最后
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: titles.length)))),
                  onChanged: (text) {
                    setState(() {
                      titles = text;
                    });
                  },
                  maxLines: null,
                  style: TextStyle(),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration.collapsed(
                    hintText: "这个帖子距离火就差这个标题了",
                  ),
                ),
              )),
              Expanded(
                  flex: 7,
                  child: Container(
                color: Colors.grey[200],
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                child: TextField(
                  controller: TextEditingController.fromValue(TextEditingValue(
                      // 设置内容
                      text: contents,
                      // 保持光标在最后
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: contents.length)))),
                  onChanged: (text) {
                    setState(() {
                      contents = text;
                    });
                  },
                  maxLines: null,
                  style: TextStyle(),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration.collapsed(
                    hintText: "来吧，尽情发挥吧",
                  ),
                ),
              )),
              /*Row(
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
              )*/
            ],
          ),
        ));
  }

  void save(BuildContext context) async {
    if (titles.trim().length == 0) {
      //Toast.show("不能为空");
      return;
    }
    //Toast.show("已经保存");
    Note note = Note();
    note.title = titles;
    note.content = contents;
    note.userId = int.parse(SpUtil.preferences.getString("userId")!); // 发帖人id
    note.reply = 0;
    note.replyId = 1; // 帖子作为回帖的id，当为主题帖时，replyid = 1

      //note.id = widget.id;
      //widget.noteDbHelpter.update(note);
    print("ssssss");
    await NoteTransporter.noteUpload(note);

    //Navigator.pop(context);
    titles = "";
    contents = "";
    await showDialog(context: context, builder: (ctx) {return const SimpleDialog(
      title: Text("/*经验+3*/"),
      titlePadding: EdgeInsets.all(10),
    );}
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
