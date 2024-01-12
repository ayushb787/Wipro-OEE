import 'package:flutter/material.dart';
import 'package:wiproapp/SelectServices/SelectService.dart';
import 'package:wiproapp/SplashScreen.dart';
import 'LoginPage/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:wiproapp/DataBase/db.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // SystemChrome.setPreferredOrientations([
//   //   DeviceOrientation.portraitUp,
//   //   DeviceOrientation.portraitDown,
//   // ]);
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  // // Insert a dropdown value with auto-incrementing index
  List<Map<String, String>> valuesToAdd = [
    {'dropdownType': 'Plant', 'value': 'Plant 1'},
    {'dropdownType': 'Plant', 'value': 'Plant 2'},
    {'dropdownType': 'Plant', 'value': 'Plant 3'},
    {'dropdownType': 'Line', 'value': 'Line 1'},
    {'dropdownType': 'Line', 'value': 'Line 2'},
    {'dropdownType': 'Line', 'value': 'Line 3'},
    {'dropdownType': 'Machine', 'value': 'Machine 1'},
    {'dropdownType': 'Machine', 'value': 'Machine 2'},
    {'dropdownType': 'Machine', 'value': 'Machine 3'},
    {'dropdownType': 'Shift', 'value': 'Shift 1'},
    {'dropdownType': 'Shift', 'value': 'Shift 2'},
    {'dropdownType': 'Shift', 'value': 'Shift 3'},
    {'dropdownType': 'Operator', 'value': 'Operator 1'},
    {'dropdownType': 'Operator', 'value': 'Operator 2'},
    {'dropdownType': 'Operator', 'value': 'Operator 3'},
    {'dropdownType': 'P Number', 'value': 'P Number 1'},
    {'dropdownType': 'P Number', 'value': 'P Number 2'},
    {'dropdownType': 'P Number', 'value': 'P Number 3'},
    {'dropdownType': 'Loss', 'value': 'L-1 EQUIPMENT FAILURE'},
    {'dropdownType': 'Loss', 'value': 'L-2 SETUP & ADJUSTMENT'},
    {'dropdownType': 'Loss', 'value': 'L-3 TOOL CHANGE'},
    {'dropdownType': 'Loss', 'value': 'L-4 START UP'},
    {'dropdownType': 'Loss', 'value': 'L-5 IDLING & MINOR STOPPAGE'},
    {'dropdownType': 'Loss', 'value': 'L-6 SPEED'},
    {'dropdownType': 'Loss', 'value': 'L-7 DETECT & REWORK'},
    {'dropdownType': 'Loss', 'value': 'L-8 SHUT DOWN'},
    {'dropdownType': 'Loss', 'value': "L-9 MANAGEMENT"},
    {'dropdownType': 'Loss', 'value': "L-10 OPERATING MOTION"},
    {'dropdownType': 'Loss', 'value': "L-11 LINE ORGANISATION"},
    {'dropdownType': 'Loss', 'value': "L-12 LOGISTICS"},
    {'dropdownType': 'Loss', 'value': "L-13 MEASUREMENT & ADJUSTMENT"},
    {'dropdownType': 'Loss', 'value': "L-14 YIELD"},
    {'dropdownType': 'Loss', 'value': "L-15 ENERGY"},
    {'dropdownType': 'Loss', 'value': "L-16 DIE & JIG"}
  ];

  Map<String, List<String>> sublossesToAdd = {
    'L-1 EQUIPMENT FAILURE': ["Electrical - EBD", "Mechanical - MBD"],
    'L-2 SETUP & ADJUSTMENT': ["Type A to B", "Type B to C", "Type C to D"],
    'L-3 TOOL CHANGE': [
      "Inserts Change",
      "Study bearings",
      "Others (NO tools)",
      "NA"
    ],
    'L-4 START UP': ['NA'],
    'L-5 IDLING & MINOR STOPPAGE': [
      "Temporarily stops due to sensor actuation, jamming, clogging,Air lock,Trip.Minor stoppage"
    ],
    'L-6 SPEED': ["Reduction in act speed"],
    'L-7 DETECT & REWORK': ["Rework job"],
    'L-8 SHUT DOWN': [
      "Shutting equipment deliberately for maintenance, no order, Management reason"
    ],
    'L-9 MANAGEMENT': [
      "Waiting for information, Instruction, Material, Tools & instruments",
      "NO material",
      "OOL /ONP",
      "No Plan",
      "No load",
      "IR Meetings",
      "Others(Plan dowm time)"
    ],
    'L-10 OPERATING MOTION': ["Skill difference losses, Walking losses"],
    'L-11 LINE ORGANISATION': ["Waiting losses generating in multi process"],
    'L-12 LOGISTICS': [
      "Excess material movement within factory / out side factory"
    ],
    'L-13 MEASUREMENT & ADJUSTMENT': [
      "Adjustment of off sets to avoid defect during Set up."
    ],
    'L-14 YIELD': ["Input variation"],
    'L-15 ENERGY': ["Electricity"],
    'L-16 DIE & JIG': ["Tool  holder change"],
  };
  await databaseHelper.addAllSubLosses(sublossesToAdd);

  await databaseHelper.addDropdownValues(valuesToAdd);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(background: Colors.white),
        ),
        home: const SplashScreen());
  }
}
