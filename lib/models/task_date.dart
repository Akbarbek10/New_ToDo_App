import 'package:to_do_app/models/task_model.dart';

class TaskDateModel{
  String? date;
  List<Task>? taskList;

  TaskDateModel(String date, List<Task> taskList) {
    this.date = date;
    this.taskList = taskList;
  }
}