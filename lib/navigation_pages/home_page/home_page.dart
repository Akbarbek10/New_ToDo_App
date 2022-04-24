import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/models/task_date.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/constants/date_format.dart';
import 'package:to_do_app/models/boxes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.box('tasks').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FCFF),
      body: SafeArea(
        child: ValueListenableBuilder<Box<Task>>(
            valueListenable: Boxes.getTasks().listenable(),
            builder: (context, box, _) {
              final tasks = box.values.toList().cast<Task>();
              if (tasks.isEmpty) {
                return NoDataMessage();
              } else {
                return ShowData(tasks, box);
              }
            }),
      ),
    );
  }

  Widget ShowData(List<Task> tasks, Box<Task> box) {
    print(box.get(3)?.name.toString());
    List<TaskDateModel> tasksWithDates = loadTasksWithDates(tasks);
    return Container(
      child: Container(
        child: ListView.builder(
          itemCount: tasksWithDates.length,
          // itemBuilder: (context, index) => TaskItem(index,tasks[index],box),
          itemBuilder: (context, index) =>
              TaskDateItem(tasksWithDates[index].date!, tasksWithDates[index].taskList!, box),
        ),
      ),
    );
  }

  Widget NoDataMessage() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/svg/ic_no_data.svg",
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "No tasks",
                style: TextStyle(
                    color: Color(0xFF554E8F),
                    fontSize: 24,
                    fontFamily: 'Rubik'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class TaskDateItem extends StatefulWidget {
  @override
  _TaskDateItemState createState() => _TaskDateItemState();

  late String date;
  late List<Task> taskList;
  late Box<Task> box;

  TaskDateItem(String date, List<Task> taskList,Box<Task> box) {
    this.date = date;
    this.taskList = taskList;
    this.box = box;
  }
}

class _TaskDateItemState extends State<TaskDateItem> {
  String myDate = "";

  @override
  void initState() {
    DateTime dateTime = DateFormat(MyDateFormat.item_date_pattern).parse(widget.date);
    String date = DateFormat("EEE, d MMM yyyy").format(dateTime);
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day+1);

    String todayStr = DateFormat("EEE, d MMM yyyy").format(now);
    String tomorrowStr = DateFormat("EEE, d MMM yyyy").format(tomorrow);

    if(date == todayStr){
      myDate = "Today";
    }else if(date == tomorrowStr){
      myDate = "Tomorrow";
    }else{
      myDate = DateFormat("EEE, d MMM yyyy").format(dateTime);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
            child: Text(myDate.toString(),style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8B87B3),
              fontFamily: 'Rubik',
            ),),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.taskList.length,
            // itemBuilder: (context, index) => TaskItem(index,tasks[index],box),
            itemBuilder: (context, index) =>
                TaskItem(index, widget.taskList[index], widget.box),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  int index;
  Task task;
  Box<Task> box;

  TaskItem(this.index, this.task, this.box);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isChecked = false;

  // @override
  // void initState() {
  //   // _isChecked = widget.task.isCompleted;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    DateTime parseDate =
        DateFormat(MyDateFormat.date_pattern).parse(widget.task.date!);
    String date = DateFormat.jm().format(parseDate);

    return Card(
      color: loadColor(widget.task.taskType),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      shadowColor: Color(0xFFEBEDF0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        padding: EdgeInsets.only(top: 8, bottom: 8, right: 12),
        margin: EdgeInsets.only(left: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.25,
              child: Checkbox(
                value: _isChecked,
                side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(
                      width: 1.5,
                      color:
                          _isChecked ? Color(0xFF91DC5A) : Color(0xFFB5B5B5)),
                ),
                checkColor: Colors.white,
                activeColor: Color(0xFF91DC5A),
                shape: CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                    // widget.task.isCompleted = _isChecked;
                    // widget.box.putAt(widget.index, widget.task);
                  });
                },
              ),
            ),
            Text(
              "${date}",
              style: TextStyle(
                  fontSize: 16, fontFamily: 'Rubik', color: Color(0xFFC6C6C8)),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Text(
              "${widget.task.name}",
              style: !_isChecked
                  ? TextStyle(
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      color: Color(0xFF554E8F))
                  : TextStyle(
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      color: Color(0xFFD9D9D9),
                      decoration: TextDecoration.underline,
                    ),
            )),
            SizedBox(width: 10),
            Icon(
              Icons.notifications,
              color: Color(0xFFD9D9D9),
            )
          ],
        ),
      ),
    );
  }

  Color loadColor(int? taskType) {
    Color color = Colors.red;
    switch (taskType) {
      case 0:
        {
          color = Color(0xFFFFD506);
          break;
        }
      case 1:
        {
          color = Color(0xFF5DE61A);
          break;
        }
      case 2:
        {
          color = Color(0xFFD10263);
          break;
        }
      case 3:
        {
          color = Color(0xFF3044F2);
          break;
        }
      case 4:
        {
          color = Color(0xFFF29130);
          break;
        }
      case 5:
        {
          color = Color(0xFF09ACCE);
          break;
        }
    }
    return color;
  }
}

List<TaskDateModel> loadTasksWithDates(List<Task> tasks) {
  List<String> listOfUniqueDates = [];

  //retrieving only unique dates
  tasks.forEach((task) {
    DateTime dateTime = DateFormat(MyDateFormat.date_pattern).parse(task.date!);
    String date = DateFormat(MyDateFormat.item_date_pattern).format(dateTime);
    if(!listOfUniqueDates.contains(date)){
      listOfUniqueDates.add(date);
    }
  });

  //sorting dates unique dates A -> Z
  listOfUniqueDates.sort((a,b) => a.compareTo(b));


  //filling tasks for each date
  List<TaskDateModel> dateTaskList = [];
  listOfUniqueDates.forEach((date) {
    List<Task> taskList = [];

    tasks.forEach((task) {
      DateTime dateTime = DateFormat(MyDateFormat.date_pattern).parse(task.date!);
      String task_date = DateFormat(MyDateFormat.item_date_pattern).format(dateTime);
      if(date == task_date){
        taskList.add(task);
      }
    });

    dateTaskList.add(TaskDateModel(date, taskList));
  });

  return dateTaskList;

}
