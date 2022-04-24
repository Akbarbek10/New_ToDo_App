import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/navigation_pages/add_page/add_page.dart';
import 'package:to_do_app/navigation_pages/home_page/home_page.dart';
import 'package:to_do_app/navigation_pages/task_page/task_page.dart';

import '../models/boxes.dart';
import '../models/task_type.dart';

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int checkedPageIndex = 0;
  bool _isNotificationVisible = true;

  final pages = [HomePage(), TaskPage()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // top
              Container(
                color: Color(0xFF5E99E6),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello Akbar!",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Today you have 9 tasks",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: CircleAvatar(
                              radius: 20,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isNotificationVisible,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 22, right: 22, top: 4, bottom: 18),
                        decoration: BoxDecoration(
                          color: Color(0xFF99C4F1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 14, 8, 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Today Reminder",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12
                                    ),
                                    Text(
                                      "Meeting with client",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Rubik',
                                          color: Color(0xFFF3F3F3)),
                                    ),
                                    SizedBox(
                                      height: 4
                                    ),
                                    Text(
                                      "13.00 PM",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Rubik',
                                          color: Color(0xFFF3F3F3)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 6),
                              Container(
                                margin: EdgeInsets.only(top: 12),
                                child: SvgPicture.asset(
                                  "assets/images/svg/ic_bell.svg",
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isNotificationVisible = false;
                                      });
                                    },
                                    constraints: BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.close),
                                    color: Colors.white,
                                    iconSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // bottom
              Expanded(
                child: Container(
                  child: pages[checkedPageIndex],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          elevation: 20,
          backgroundColor: Colors.white,
          currentIndex: checkedPageIndex,
          onTap: (index) {
            setState(() {
              checkedPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: SvgPicture.asset(
                "assets/images/svg/ic_home.svg",
                color: Color(0xFFBEBEBE),
                height: 24,
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/images/svg/ic_home.svg",
                color: Color(0xFF5F87E7),
                height: 30,
                width: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Task',
              icon: SvgPicture.asset(
                "assets/images/svg/ic_task.svg",
                color: Color(0xFFBEBEBE),
                height: 24,
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/images/svg/ic_task.svg",
                color: Color(0xFF5F87E7),
                height: 30,
                width: 30,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: true,
              isDismissible: true,
              context: context,
              builder: (context) => BuildAddBottomSheet(),
              backgroundColor: Colors.transparent,
          ).then((value)  {
            setState(() {
              if(value!=null){
                Task newTask = value;
                addTask(newTask);
                
              }
            });
          });
        },
        backgroundColor: Color(0xFFED39B2),
        child: SvgPicture.asset("assets/images/svg/ic_add.svg"),
      ),
    );
  }

  Widget BuildAddBottomSheet() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: DraggableScrollableSheet(
        initialChildSize: 0.8,
        builder: (_, controller) => Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.elliptical(250, 30))),
            child: AddPage()),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 130),
        child: Container(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Color(0xFFED39B2),
            child: SvgPicture.asset("assets/images/svg/ic_close.svg"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }

  Future addTask(Task task) async {
    final box = Boxes.getTasks();
    box.add(task);
  }


}
