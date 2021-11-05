import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Class {
  String title;
  String description;
  Class(this.title, this.description);
}

class ClassDetail extends StatelessWidget {
  var _classindex = 0;
  Class classinfo = Class("高等数学", "周某某教授@综合楼201");
  ClassDetail(this._classindex);

  @override
  void initState() {
    classinfo.description = _classindex.toString();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      appBar: AppBar(
        title: Text('${classinfo.title}'),
      ),
      body: Center(
        child: Text('${classinfo.description}'),
      ),
    );
  }
}

class SpaceWidget extends StatelessWidget {
  double height, width;

  SpaceWidget({
    this.height = 1,
    this.width = 1,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
    );
  }
}

class PageState extends State<SyllabusPage> {
  var colorList = [
    Colors.red,
    Colors.lightBlueAccent,
    Colors.grey,
    Colors.cyan,
    Colors.amber,
    Colors.deepPurpleAccent,
    Colors.purpleAccent
  ];
  var infoList = ["高等数学-周某某教授@综合楼201", "大学英语-王某某讲师@行政楼501"];
  var weekList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

  var timeinfo = [
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    3,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    2,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0
  ];
  var classindex = [
    "高等数学-周某某教授@综合楼201",
    "大学英语-王某某讲师@行政楼501",
    "大学英语-王某某讲师@行政楼401"
  ];
  var dateList = [];
  var currentWeekIndex = 0;
  var _stimeinfo;
  var _scindex;
  List classStartTime = [
    "8:00",
    "8:55",
    "9:55",
    "10:50",
    "11:45",
    "13:30",
    "14:25",
    "15:25",
    "16:20",
    "17:15",
    "18:30",
    "19:25",
    "20:20",
    "21:15"
  ];
  List classEndTime = [
    "8:45",
    "9:40",
    "10:40",
    "11:35",
    "12:30",
    "14:15",
    "15:10",
    "16:10",
    "17:05",
    "18:00",
    "19:15",
    "20:10",
    "21:05",
    "22:00"
  ];
  PageState(this._stimeinfo, this._scindex);
  @override
  void initState() {
    super.initState();

    var monday = 1;
    var mondayTime = DateTime.now();

    //获取本周星期一是几号
    while (mondayTime.weekday != monday) {
      mondayTime = mondayTime.subtract(new Duration(days: 1));
    }

    mondayTime.year; //2020 年
    mondayTime.month; //6(这里和js中的月份有区别，js中是从0开始，dart则从1开始，我们无需再进行加一处理) 月
    mondayTime.day; //6 日
    // nowTime.hour ;//6 时
    // nowTime.minute ;//6 分
    // nowTime.second ;//6 秒
    for (int i = 0; i < 7; i++) {
      dateList.add(
          mondayTime.month.toString() + "/" + (mondayTime.day + i).toString());
      if ((mondayTime.day + i) == DateTime.now().day) {
        setState(() {
          currentWeekIndex = i + 1;
        });
      }
    }
    if (_stimeinfo == "" || _scindex == "") return;
    // print('Recent monday '+DateTime.now().day.toString());
    var sss = json.decode(_stimeinfo);
    timeinfo.clear();
    for (var i in sss) {
      timeinfo.add(i);
    }
    classindex.clear();
    var ssss = json.decode(_scindex);
    for (var i in ssss) {
      classindex.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8, childAspectRatio: 1 / 1),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: index == this.currentWeekIndex
                        ? Color(0xf7f7f7)
                        : Colors.white,
                    child: Center(
                      child: index == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("星期",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black87)),
                                SpaceWidget(height: 5),
                                Text("日期", style: TextStyle(fontSize: 12)),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(weekList[index - 1],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: index == currentWeekIndex
                                            ? Colors.lightBlue
                                            : Colors.black87)),
                                SpaceWidget(height: 5),
                                Text(dateList[index - 1],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: index == currentWeekIndex
                                            ? Colors.lightBlue
                                            : Colors.black87)),
                              ],
                            ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GridView.builder(
                        shrinkWrap: true,
                        // physics:ClampingScrollPhysics(),
                        itemCount: 14,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 1 / 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              // width: 25,
                              // height:s 80,
                              child: Column(
                                children: [
                                  Center(
                                      child: Text(
                                          (index + 1).toInt().toString(),
                                          style: TextStyle(fontSize: 15))),
                                  Center(
                                      child: Text(
                                    (classStartTime[index]).toString() +
                                        "\n" +
                                        (classEndTime[index]).toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ))
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff5ff5),
                                // border: Border.all(color: Colors.black12, width: 0.5),
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black12, width: 0.5),
                                  right: BorderSide(
                                      color: Colors.black12, width: 0.5),
                                ),
                              ));
                        }),
                  ),
                  Expanded(
                    flex: 7,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 98,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7, childAspectRatio: 1 / 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(color: Colors.black12, width: 0.5),
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1),
                                              right: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                if (timeinfo[index] != 0)
                                  Container(
                                      margin: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: colorList[timeinfo[index] % 7],
                                      ),
                                      child: Center(
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          new ClassDetail(
                                                              timeinfo[index] -
                                                                  1)));
                                            },
                                            style: ButtonStyle(
                                              visualDensity: VisualDensity(
                                                  horizontal: -4.0,
                                                  vertical: -4.0),
                                            ),
                                            child: Text(
                                              classindex[timeinfo[index] - 1],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  letterSpacing: 1),
                                            )),
                                      ))
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
          _bottomView
        ],
      ),
    );
  }

  @override
  String pageTitle() => "我的课表";

  Widget _topView = SizedBox(
    height: 30,
    child: Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            return Text("dd");
          }),
    ),
  );
  Widget _centerView = Expanded(
    child: GridView.builder(
        itemCount: 63,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              // width: 25,
              // height: 80,
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(fontSize: 15),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff5ff5),
                border: Border.all(color: Colors.black12, width: 0.5),
              ));
        }),
  );

  Widget _bottomView = SizedBox(
    height: 10,
    child: Row(
      children: [
        //底部view可自行扩充
      ],
    ),
  );
}
