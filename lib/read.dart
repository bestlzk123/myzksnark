import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/entity/post_notes.dart';
import 'package:myapp/utils/global_value.dart';
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
    print(widget.id);
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    DbUtil.noteDbHelper.getNoteById(widget.id).then((notes) {
      setState(() {
        note = notes!.content;
        noteEntity = notes;
        pN = PostNotes(noteEntity);
        title = notes.title;
      });
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
                  return WritePage(id: widget.id);
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
                  child: MaterialButton(
                      child: Text(
                        '点此处或者右上角输入您的回复~',
                        textAlign: TextAlign.right,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WritePage(id: widget.id);
                        }));
                      })),
            ),
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
    required this.id,
  });
  final int id;
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
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return mockLoadReply();
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
                    hintText: "点此输入你的回复……",
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

  Widget mockLoadReply() {
    return Scaffold(
      body : new Container(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
            child: CustomScrollView(
              shrinkWrap: false,
              primary: false,
              // 回弹效果
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return InkWell(
                            child: Text(
                                '发布回复',
                              textAlign: TextAlign.right,),
                              );}
                        ),
                  ),
              ],
            ),
        ),
      ),);
}

// Widget _buildReply() {
//   return new Padding(
//     padding: const EdgeInsets.only(left: 35.0, bottom: 12.0),
//     child: new Container(
//       alignment: Alignment.topLeft,
//       child: new Text.rich(
//         new TextSpan(
//             text: '??????????',
//             style: new TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w400),
//             children: [
//               new TextSpan(
//                   text: '?????????',
//                   style: new TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w400,
//                   ))
//             ]),
//       ),
//     ),
//   );
// }


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