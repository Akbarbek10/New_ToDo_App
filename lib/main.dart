import 'package:flutter/material.dart';
import 'package:to_do_app/inroduction_page/introduction_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task_model.dart';
import 'models/task_type.dart';
import 'navigation_pages/main_navigation_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To Do App",
      routes: {
        "/":(context) => IntroductionPage(),
        "/navigation_page":(context) => MainNavigationPage(),
      },


    );
  }
}

