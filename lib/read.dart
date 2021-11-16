import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/entity/post_notes.dart';
import 'package:myapp/utils/global_value.dart';
import 'package:myapp/utils/note_transporter.dart';
import 'entity/note.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({
    required this.id,
  });
  final int id;

  @override
  State<StatefulWidget> createState() {
    return ReadPageState();
  }
}

class ReadPageState extends State<ReadPage> with WidgetsBindingObserver {
  String note = "";
  String title = "";
  late Note noteEntity;
  late PostNotes pN;

  @override
  void initState() {
    print('widget.id:' + widget.id.toString());
    super.initState();
    pN = PostNotes();
    //WidgetsBinding.instance.addObserver(this);
    DbUtil.noteDbHelper.getNoteById(widget.id).then((notes) {
      pN.postNote = notes!;
      pN.inital().then((k){setState(() {
        note = notes.content;
        noteEntity = notes;
        title = notes.title;
      }
      );});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        title: Text('内容详情',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WritePage(id: widget.id,post_id:noteEntity.postId);
                }));
              })
        ],
      ),
      body: Container(
        width: double.infinity,
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
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(fontSize: 25),
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
                  note,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  // color: Colors.lightBlueAccent,
                  child: MaterialButton(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '点此处或者右上角输入您的回复~',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent,
                            ),
                          ),
                        ]),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WritePage(id: widget.id,post_id: noteEntity.postId,);
                        }));
                      })),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return InkWell(

                        child: Column(

                          children: <Widget>[

                            Text(
                                pN.replyNotes[index].content,
                                textAlign: TextAlign.left,
                            ),
                            Divider(height:10.0,indent:0.0,color: Colors.black,),
                          ]
                        ),
                      );},
                    childCount: pN.replyNotes.length)),
            // Row(
            //   children: <Widget>[
            //     Container(
            //       child: IconButton(
            //           icon: Icon(
            //             Icons.wb_sunny,
            //             color: Colors.grey,
            //           ),
            //           onPressed: () {}),
            //     ),
            //     Container(
            //       child: IconButton(
            //           icon: Icon(
            //             Icons.star_border,
            //             color: Colors.grey,
            //           ),
            //           onPressed: () {}),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  //组件即将销毁时调用
  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance.removeObserver(this);
  }
}

class WritePage extends StatefulWidget {
  const WritePage({
    required this.post_id,
    required this.id,
  });
  final int id;
  final int post_id;
  State<StatefulWidget> createState() {
    return WritePageState();
  }
}

class WritePageState extends State<WritePage> {
  String notes = "";
  int replyId = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.grey,
          ),
          backgroundColor: Color.fromRGBO(244, 244, 244, 1.0),
          title: Text("回复帖子",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              )),
          actions: <Widget>[
            MaterialButton(
                child: Text(
                  '发布回复',
                  textAlign: TextAlign.right,
                ),
                onPressed: () async {
                  print("notes是什么？： "+ notes);
                  Note reply = Note.fromMap({
                    columnTitle:"youshouldnotseeit",
                    columnContent:notes,
                    columnTime:DateTime.now().toString(),
                    columnReply:0,//should not use
                    columnReplyId:10,
                    columnPostId:widget.post_id,
                  });
                  await NoteTransporter.noteUpload(reply);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ReadPage(id:widget.id);
                  }));
                })
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
                        hintText: "请输入您的回复……",
                      ),
                ),
              )),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      //await NoteTransporter.postNoteReload();
      print('refresh');
      DbUtil.noteDbHelper.getDatabase().then((database) {
        database
            .query('notes', orderBy: 'time DESC')
            .then((List<Map<String, dynamic>> records) {});
      });
    });
  }
}