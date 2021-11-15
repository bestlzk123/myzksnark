const String columnTeacherId = 'teacher_id'; // 表名
const String columnTeacherName = 'teacher_name'; // 属性名 theme
const String columnCourseId = 'course_id'; // 属性名 text
const String columnIndex = "index"; //属性名 edit_time
const String columnCourseName = "course_name"; //属性名 num
const String columnRoomId = "room_id"; //属性名 id
const String columnRoomName = "room_name";//属性名
class Course {
  String teacherId = "";
  String teacherName = "";
  String courseId = "";
  int index = -1;
  String courseName = "";
  String roomId = "";
  String roomName ="";
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTeacherId: teacherId,
      columnTeacherName: teacherName,
      columnCourseId: courseId,
      columnIndex: index,
      columnCourseName:courseName,
      columnRoomId:roomId,
      columnRoomName:roomName,
    };
    //map[columnId] = id;
    return map;
  }
  // 构造方法/实例化方法
  Course();
  // 通过数据集合返回一个实体对象
  Course.fromMap(Map<String, dynamic> map) {
    teacherId = map[columnTeacherId];
    teacherName = map[columnTeacherName];
    courseId = map[columnCourseId];
    index = map[columnIndex] ;
    courseName = map[columnCourseName];
    roomId = map[columnRoomId];
    roomName = map[columnRoomName] ;
  }
}