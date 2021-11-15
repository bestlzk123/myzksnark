import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/read.dart';
import 'package:myapp/utils/global_value.dart';
import 'package:myapp/utils/note_transporter.dart';

import 'entity/note.dart';


class ListPage extends StatefulWidget {
  ListPage();
  @override
  State<StatefulWidget> createState() {
    // print("runrun");
    return ListPageState();
  }
}

class ListPageState extends State<ListPage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController =
  ScrollController(initialScrollOffset: 5, keepScrollOffset: true);
  int _size = 0;
  final List<Note> _noteList = List.empty(growable: true);
  //StreamSubscription subscription;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body : new Container(
      child: RefreshIndicator(
          child: CustomScrollView(
            shrinkWrap: false,
            primary: false,
            // 回弹效果
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: _scrollController,
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
                        child:
                        index % 2 == 0 ? getItem(index) : getItem(index),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return ReadPage(
                                    id:index+1,
                                );
                              }));
                        },
                        // onLongPress: () {
                        //   _showBottomSheet(index, context);
                        // },
                      );
                    }, childCount: _size),
              ),
            ],
          ),
          onRefresh: _onRefresh),
    ),);
  }

  Future<Null> nouse() async{
    // print("nouse");
    return null;
  }

  //刷新
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      await NoteTransporter.postNoteReload();
      print('refresh');
      DbUtil.noteDbHelper.getDatabase().then((database) {
        database
            .query('notes', orderBy: 'time DESC')
            .then((List<Map<String, dynamic>> records) {
          _size = records.length;
          _noteList.clear();
          for (int i = 0; i < records.length; i++) {
            _noteList.add(Note.fromMap(records.elementAt(i)));
          }
          setState(() {
            print(_noteList.length);
          });
        });
      });
    });
  }

  Widget getItem(int index) {
    // print("item");
    return Container(
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        _noteList.elementAt(index).title,
                        //'${DateTime.fromMillisecondsSinceEpoch(_noteList.elementAt(index).time).day}',
                        style: TextStyle(
                            color: Color.fromRGBO(52, 52, 54, 1),
                            fontSize: 50,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                _noteList.elementAt(index).content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color.fromRGBO(103, 103, 103, 1),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //subscription.cancel();
  }

  @override
  bool get wantKeepAlive => true;

}
