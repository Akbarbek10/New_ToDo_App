import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/constants/date_format.dart';
import 'package:to_do_app/models/task_card.dart';

import '../../models/boxes.dart';
import '../../models/task_model.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
List<Task> tasks = [];

  // Task(
  //     name: "To do smth",
  //     date: "12.02.2022 16:48",
  //     taskType: 0),
  // Task(
  //     name: "To do smth",
  //     date: "12.02.2022 16:48",
  //     taskType: 0),
  // Task(
  //     name: "To do smth 2",
  //     date: "12.02.2022 16:48",
  //     taskType: 1),
  // Task(
  //     name: "To do smth 3",
  //     date: "12.02.2022 16:48",
  //     taskType: 2),
  // Task(
  //     name: "To do smth 5",
  //     date: "12.02.2022 16:48",
  //     taskType: 3),
  // Task(
  //     name: "To do smth 5",
  //     date: "12.02.2022 16:48",
  //     taskType: 3),
  // Task(
  //     name: "To do smth 6",
  //     date: "12.02.2022 16:48",
  //     taskType: 4),
  // Task(
  //     name: "To do smth 3",
  //     date: "12.02.2022 16:48",
  //     taskType: 5),
  // ];
  Map taskCard = {
    0: TaskCard(
        title: "Personal",
        bg_color: Color(0xFFFFF9DB),
        icon: "assets/images/svg/ic_user.svg"),
    1: TaskCard(
        title: "Work",
        bg_color: Color(0xFFE4FFDB),
        icon: "assets/images/svg/ic_briefcase.svg"),
    2: TaskCard(
        title: "Meeting",
        bg_color: Color(0xFFFFDBED),
        icon: "assets/images/svg/ic_presentation.svg"),
    3: TaskCard(
        title: "Shopping",
        bg_color: Color(0xFFF8E7D5),
        icon: "assets/images/svg/ic_basket.svg"),
    4: TaskCard(
        title: "Party",
        bg_color: Color(0xFFD9FCFA),
        icon: "assets/images/svg/ic_party.svg"),
    5: TaskCard(
        title: "Study",
        bg_color: Color(0xFFF9D9FD),
        icon: "assets/images/svg/ic_study.svg"),
  };

  @override
  void initState() {
    // taskItemCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 18),
                child: Text(
                  "Projects",
                  style: TextStyle(
                      color: Color(0xFF8B87B3),
                      fontSize: 14,
                      fontFamily: 'Rubik'),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Expanded(
                child: ValueListenableBuilder<Box<Task>>(
                    valueListenable: Boxes.getTasks().listenable(),
                    builder: (context, box, _) {
                      tasks = box.values.toList().cast<Task>();
                      return StaggeredGridView.countBuilder(
                        itemCount: taskCard.length,
                        crossAxisCount: 2,
                        padding: EdgeInsets.only(left: 18, right: 18),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        itemBuilder: (context, index) => TaskCardItem(
                            context, taskCard.values.elementAt(index)),
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

}

Widget TaskCardItem(BuildContext context, TaskCard task) {
  return Card(
    color: Colors.transparent,
    elevation: 8,
    shadowColor: Color(0xFFEBEDF0),
    child: Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: task.bg_color,
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset("${task.icon}"),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "${task.title}",
            style: TextStyle(
                color: Color(0xFF686868), fontSize: 20, fontFamily: 'Rubik'),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            "${task.amount} Task",
            style: TextStyle(
                color: Color(0xFFA1A1A1), fontSize: 12, fontFamily: 'Rubik'),
          ),
        ],
      ),
    ),
  );
}
