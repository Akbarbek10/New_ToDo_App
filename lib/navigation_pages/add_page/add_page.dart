import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/constants/date_format.dart';
import 'package:to_do_app/models/my_task_type.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final taskText = TextEditingController();
  int? selectedTaskType = null;

  final List<MyTaskTypeModel> listOfTaskTypes = [
    MyTaskTypeModel(name: "Personal", color: Color(0xFFFFD506), taskType: 0),
    MyTaskTypeModel(name: "Work", color: Color(0xFF1ED102), taskType: 1),
    MyTaskTypeModel(name: "Meeting", color: Color(0xFFD10263), taskType: 2),
    MyTaskTypeModel(name: "Study", color: Color(0xFF3044F2), taskType: 3),
    MyTaskTypeModel(name: "Shopping", color: Color(0xFFF29130), taskType: 4),
    MyTaskTypeModel(name: "Party", color: Color(0xFF09ACCE), taskType: 5)
  ];

  DateTime? dateTime;
  String? chosenDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "Add new task",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF404040),
                    fontFamily: 'Rubik',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor: Color(0xFF373737),
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Rubik',
                    color: Color(0xFF373737)),
                controller: taskText,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                  hintText: 'Your to do text...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              Container(
                height: 1,
                color: Color(0xFFCFCFCF),
                margin: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(listOfTaskTypes.length, (index) {
                    return CustomRadioBtn(listOfTaskTypes[index]);
                  }),
                ),
              ),
              Container(
                height: 1,
                color: Color(0xFFCFCFCF),
                margin: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: TextButton.icon(
                  onPressed: () {
                    dateTime = DateTime.now();
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildBottomPicker(
                          CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.dateAndTime,
                            initialDateTime: dateTime,
                            onDateTimeChanged: (DateTime newDateTime) {
                              if (mounted) {
                                setState(() {
                                  dateTime = newDateTime;
                                  String date = DateFormat(MyDateFormat.date_pattern)
                                      .format(newDateTime);
                                  chosenDate = date;
                                });
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                  label: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 24.0,
                    color: Color(0xFF404040),
                  ),
                  icon: Text(
                    chosenDate == null ? "Choose date" : '$chosenDate',
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        color: Color(0xFF404040)),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 14),
                          child: ElevatedButton(
                              onPressed: () {
                                if(checkCredentials(taskText.text.toString(),chosenDate,selectedTaskType)){
                                  Task newTask = Task(
                                      name: taskText.text.toString(),
                                      date: chosenDate,
                                      taskType: selectedTaskType);
                                  Navigator.pop(context, newTask);
                                }else{
                                  Fluttertoast.showToast(
                                      msg: "Fill all fields!",
                                      backgroundColor: Color(0xFFF44336),
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_SHORT);
                                }


                              },
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Color(0xFF76A9F9)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFF76A9F9)),
                                  shadowColor: MaterialStateProperty.all(
                                      Color(0xFF76A9F9)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Add task",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Rubik',
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomRadioBtn(MyTaskTypeModel myTaskTypeModel) {
    bool isSelected = selectedTaskType == myTaskTypeModel.taskType;
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedTaskType = myTaskTypeModel.taskType;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? myTaskTypeModel.color : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Visibility(
                visible: !isSelected,
                child: Container(
                  child: CircleAvatar(
                    radius: 6,
                    child: ClipOval(
                      child: Container(
                        color: myTaskTypeModel.color,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${myTaskTypeModel.name}",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    color: isSelected ? Colors.white : Color(0xFF8E8E8E),
                  ),
                ),
              ))
            ],
          ),
        ));
  }

  Widget _buildBottomPicker(CupertinoDatePicker picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  bool checkCredentials(String name, String? chosenDate, int? taskType) {
    if(name.isEmpty || chosenDate==null || taskType ==null){
      return false;
    }
    return true;
  }
}
