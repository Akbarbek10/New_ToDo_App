import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String? name;

  @HiveField(1)
  late String? date;

  @HiveField(2)
  late int? taskType;

  @HiveField(3)
  late bool isCompleted = false;

  Task({this.name, this.date, this.taskType});
}


