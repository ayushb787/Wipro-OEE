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
    {'dropdownType': 'Machine', 'value': 'ACE CNC-1'},
    {'dropdownType': 'Machine', 'value': 'ACE CNC-2'},
    {'dropdownType': 'Machine', 'value': 'ACE CNC-3'},
    {'dropdownType': 'Machine', 'value': 'ACE CNC-4'},
    {'dropdownType': 'Machine', 'value': 'ACE CNC-5'},
    {'dropdownType': 'Machine', 'value': 'ACE CNC-6'},
    {'dropdownType': 'Machine', 'value': 'ACE CNC-7'},
    {'dropdownType': 'Machine', 'value': 'ACE CNC-8'},
    {'dropdownType': 'Machine', 'value': 'AMS-MACHINING CENTER -1'},
    {'dropdownType': 'Machine', 'value': 'AMS-MACHINING CENTER -2'},
    {'dropdownType': 'Machine', 'value': 'AMS-MACHINING CENTER -3'},
    {'dropdownType': 'Machine', 'value': 'BEH-CUTTING MACHINE -1'},
    {'dropdownType': 'Machine', 'value': 'BURNISHING -1(WIDMA)'},
    {'dropdownType': 'Machine', 'value': 'BURNISHING -2(SIERRA-1)'},
    {'dropdownType': 'Machine', 'value': 'BURNISHING -3(SIERRA-2)'},
    {'dropdownType': 'Machine', 'value': 'BUSH PRESS -1'},
    {'dropdownType': 'Machine', 'value': 'BUSH PRESS -2'},
    {'dropdownType': 'Machine', 'value': 'BUSH PRESS -3'},
    {'dropdownType': 'Machine', 'value': 'BUSH PRESS -4 '},
    {'dropdownType': 'Machine', 'value': 'CO2 WELDING (PRIMO 1)'},
    {'dropdownType': 'Machine', 'value': 'DOOSAN PUMA 400'},
    {'dropdownType': 'Machine', 'value': 'DRILLING M/C -1'},
    {'dropdownType': 'Machine', 'value': 'EMA -1'},
    {'dropdownType': 'Machine', 'value': 'FLOW LINES TESTING - LCC'},
    {'dropdownType': 'Machine', 'value': 'FRICTION WELDING MACHINE'},
    {'dropdownType': 'Machine', 'value': 'HANEL-1'},
    {'dropdownType': 'Machine', 'value': 'HANEL-2'},
    {'dropdownType': 'Machine', 'value': 'HEC TORQUING (SLEW)'},
    {'dropdownType': 'Machine', 'value': 'HYDRAULIC BUSH PRESSING -1'},
    {'dropdownType': 'Machine', 'value': 'HYUNDAI CNC -1'},
    {'dropdownType': 'Machine', 'value': 'HYUNDAI CNC -2'},
    {'dropdownType': 'Machine', 'value': 'HYUNDAI CNC -3'},
    {'dropdownType': 'Machine', 'value': 'IO BOOM HEC TROQUE '},
    {'dropdownType': 'Machine', 'value': 'JCB ASSEMBLY'},
    {'dropdownType': 'Machine', 'value': 'JCB COMPONENT WASHING'},
    {'dropdownType': 'Machine', 'value': 'JCB TESTING'},
    {'dropdownType': 'Machine', 'value': 'MARKING CEC / TUBE'},
    {'dropdownType': 'Machine', 'value': 'MARKING HEC'},
    {'dropdownType': 'Machine', 'value': 'MARKING LCC'},
    {'dropdownType': 'Machine', 'value': 'MARKING VSCP'},
    {'dropdownType': 'Machine', 'value': 'MCP ASSEMBLY NEW'},
    {'dropdownType': 'Machine', 'value': 'MCP TESTING NEW'},
    {'dropdownType': 'Machine', 'value': 'MICROCON ASSEMBLY'},
    {'dropdownType': 'Machine', 'value': 'MMT -1'},
    {'dropdownType': 'Machine', 'value': 'MMT -3'},
    {'dropdownType': 'Machine', 'value': 'MMT -4'},
    {'dropdownType': 'Machine', 'value': 'MMT -5'},
    {'dropdownType': 'Machine', 'value': 'PAINTING BOOTH - 1'},
    {'dropdownType': 'Machine', 'value': 'PAINTING BOOTH - 2'},
    {'dropdownType': 'Machine', 'value': 'PISTON TORQUING - SLEW'},
    {'dropdownType': 'Machine', 'value': 'ROBOT -1 (ABB)'},
    {'dropdownType': 'Machine', 'value': 'ROBOT WELDING -1'},
    {'dropdownType': 'Machine', 'value': 'ROBOT WELDING -2'},
    {'dropdownType': 'Machine', 'value': 'ROBOT WELDING -3'},
    {'dropdownType': 'Machine', 'value': 'ROBOT WELDING -4'},
    {'dropdownType': 'Machine', 'value': 'SCP ASSEMBLY'},
    {'dropdownType': 'Machine', 'value': 'SCP TESTING'},
    {'dropdownType': 'Machine', 'value': 'SHRINK FITTING'},
    {'dropdownType': 'Machine', 'value': 'SLEW TESTING'},
    {'dropdownType': 'Machine', 'value': 'SPM WELDING MACHINE'},
    {'dropdownType': 'Machine', 'value': 'SRV COMPONENT WASHING -2'},
    {'dropdownType': 'Machine', 'value': 'SRV TUBE WASHING(SCP2)'},
    {'dropdownType': 'Machine', 'value': 'STRAIGHTENING (BEMCO-1)'},
    {'dropdownType': 'Machine', 'value': 'STRAIGHTENING -2 (ETA)'},
    {'dropdownType': 'Machine', 'value': 'SUPPORT LEG ASSEMBLY (INDMAS)'},
    {'dropdownType': 'Machine', 'value': 'TUBE WASHING - CLEANTECH'},
    {'dropdownType': 'Machine', 'value': 'TUBE WASHING MACHINE - SLEW'},
    {'dropdownType': 'Machine', 'value': 'ULTRA SONIC WASHING - MANUAL'},
    {'dropdownType': 'Machine', 'value': 'ULTRA SONIC WASHING (VSCP)'},
    {'dropdownType': 'Machine', 'value': 'VSCP ASSEMBLY'},
    {'dropdownType': 'Machine', 'value': 'VSCP TESTING'},
    {'dropdownType': 'Shift', 'value': 'Shift 1'},
    {'dropdownType': 'Shift', 'value': 'Shift 2'},
    {'dropdownType': 'Shift', 'value': 'Shift 3'},
    {'dropdownType': 'Operator', 'value': 'Operator 1'},
    {'dropdownType': 'Operator', 'value': 'Operator 2'},
    {'dropdownType': 'Operator', 'value': 'Operator 3'},
    {'dropdownType': 'P Number', 'value': 'P10022'},
    {'dropdownType': 'P Number', 'value': 'P10023'},
    {'dropdownType': 'P Number', 'value': 'P10148'},
    {'dropdownType': 'P Number', 'value': 'P10209'},
    {'dropdownType': 'P Number', 'value': 'P10211'},
    {'dropdownType': 'P Number', 'value': 'P10313'},
    {'dropdownType': 'P Number', 'value': 'P10315'},
    {'dropdownType': 'P Number', 'value': 'P10421'},
    {'dropdownType': 'P Number', 'value': 'P10631'},
    {'dropdownType': 'P Number', 'value': 'P10632'},
    {'dropdownType': 'P Number', 'value': 'P10665'},
    {'dropdownType': 'P Number', 'value': 'P10666'},
    {'dropdownType': 'P Number', 'value': 'P10667'},
    {'dropdownType': 'P Number', 'value': 'P10728'},
    {'dropdownType': 'P Number', 'value': 'P10751'},
    {'dropdownType': 'P Number', 'value': 'P10752'},
    {'dropdownType': 'P Number', 'value': 'P10797'},
    {'dropdownType': 'P Number', 'value': 'P10824'},
    {'dropdownType': 'P Number', 'value': 'P10831'},
    {'dropdownType': 'P Number', 'value': 'P10832'},
    {'dropdownType': 'P Number', 'value': 'P10834'},
    {'dropdownType': 'P Number', 'value': 'P10835'},
    {'dropdownType': 'P Number', 'value': 'P10960'},
    {'dropdownType': 'P Number', 'value': 'P10961'},
    {'dropdownType': 'P Number', 'value': 'P11031'},
    {'dropdownType': 'P Number', 'value': 'P11136'},
    {'dropdownType': 'P Number', 'value': 'P11174'},
    {'dropdownType': 'P Number', 'value': 'P11176'},
    {'dropdownType': 'P Number', 'value': 'P11197'},
    {'dropdownType': 'P Number', 'value': 'P11198'},
    {'dropdownType': 'P Number', 'value': 'P11549'},
    {'dropdownType': 'P Number', 'value': 'P11592'},
    {'dropdownType': 'P Number', 'value': 'P11593'},
    {'dropdownType': 'P Number', 'value': 'P11646'},
    {'dropdownType': 'P Number', 'value': 'P11682'},
    {'dropdownType': 'P Number', 'value': 'P11689'},
    {'dropdownType': 'P Number', 'value': 'P11690'},
    {'dropdownType': 'P Number', 'value': 'P11709'},
    {'dropdownType': 'P Number', 'value': 'P11714'},
    {'dropdownType': 'P Number', 'value': 'P11715'},
    {'dropdownType': 'P Number', 'value': 'P11718'},
    {'dropdownType': 'P Number', 'value': 'P11739'},
    {'dropdownType': 'P Number', 'value': 'P11742'},
    {'dropdownType': 'P Number', 'value': 'P11743'},
    {'dropdownType': 'P Number', 'value': 'P11817'},
    {'dropdownType': 'P Number', 'value': 'P11992'},
    {'dropdownType': 'P Number', 'value': 'P12222'},
    {'dropdownType': 'P Number', 'value': 'P12488'},
    {'dropdownType': 'P Number', 'value': 'P12553'},
    {'dropdownType': 'P Number', 'value': 'P12606'},
    {'dropdownType': 'P Number', 'value': 'P12607'},
    {'dropdownType': 'P Number', 'value': 'P12863'},
    {'dropdownType': 'P Number', 'value': 'P13078'},
    {'dropdownType': 'P Number', 'value': 'P13431'},
    {'dropdownType': 'P Number', 'value': 'P13468'},
    {'dropdownType': 'P Number', 'value': 'P13469'},
    {'dropdownType': 'P Number', 'value': 'P13470'},
    {'dropdownType': 'P Number', 'value': 'P13471'},
    {'dropdownType': 'P Number', 'value': 'P13575'},
    {'dropdownType': 'P Number', 'value': 'P13576'},
    {'dropdownType': 'P Number', 'value': 'P13577'},
    {'dropdownType': 'P Number', 'value': 'P13589'},
    {'dropdownType': 'P Number', 'value': 'P13590'},
    {'dropdownType': 'P Number', 'value': 'P13597'},
    {'dropdownType': 'P Number', 'value': 'P13644'},
    {'dropdownType': 'P Number', 'value': 'P13645'},
    {'dropdownType': 'P Number', 'value': 'P13646'},
    {'dropdownType': 'P Number', 'value': 'P13647'},
    {'dropdownType': 'P Number', 'value': 'P13790'},
    {'dropdownType': 'P Number', 'value': 'P13841'},
    {'dropdownType': 'P Number', 'value': 'P13860'},
    {'dropdownType': 'P Number', 'value': 'P13883'},
    {'dropdownType': 'P Number', 'value': 'P13944'},
    {'dropdownType': 'P Number', 'value': 'P13951'},
    {'dropdownType': 'P Number', 'value': 'P13952'},
    {'dropdownType': 'P Number', 'value': 'P13953'},
    {'dropdownType': 'P Number', 'value': 'P13954'},
    {'dropdownType': 'P Number', 'value': 'P14071'},
    {'dropdownType': 'P Number', 'value': 'P14093'},
    {'dropdownType': 'P Number', 'value': 'P14118'},
    {'dropdownType': 'P Number', 'value': 'P14125'},
    {'dropdownType': 'P Number', 'value': 'P14246'},
    {'dropdownType': 'P Number', 'value': 'P14247'},
    {'dropdownType': 'P Number', 'value': 'P14374'},
    {'dropdownType': 'P Number', 'value': 'P14474'},
    {'dropdownType': 'P Number', 'value': 'P14498'},
    {'dropdownType': 'P Number', 'value': 'P14608'},
    {'dropdownType': 'P Number', 'value': 'P14614'},
    {'dropdownType': 'P Number', 'value': 'P14648'},
    {'dropdownType': 'P Number', 'value': 'P14649'},
    {'dropdownType': 'P Number', 'value': 'P14664'},
    {'dropdownType': 'P Number', 'value': 'P14665'},
    {'dropdownType': 'P Number', 'value': 'P14666'},
    {'dropdownType': 'P Number', 'value': 'P14667'},
    {'dropdownType': 'P Number', 'value': 'P14668'},
    {'dropdownType': 'P Number', 'value': 'P14669'},
    {'dropdownType': 'P Number', 'value': 'P14688'},
    {'dropdownType': 'P Number', 'value': 'P14717'},
    {'dropdownType': 'P Number', 'value': 'P14741'},
    {'dropdownType': 'P Number', 'value': 'P14742'},
    {'dropdownType': 'P Number', 'value': 'P14842'},
    {'dropdownType': 'P Number', 'value': 'P14850'},
    {'dropdownType': 'P Number', 'value': 'P14851'},
    {'dropdownType': 'P Number', 'value': 'P14852'},
    {'dropdownType': 'P Number', 'value': 'P14853'},
    {'dropdownType': 'P Number', 'value': 'P14874'},
    {'dropdownType': 'P Number', 'value': 'P14901'},
    {'dropdownType': 'P Number', 'value': 'P14902'},
    {'dropdownType': 'P Number', 'value': 'P14903'},
    {'dropdownType': 'P Number', 'value': 'P14916'},
    {'dropdownType': 'P Number', 'value': 'P14917'},
    {'dropdownType': 'P Number', 'value': 'P14922'},
    {'dropdownType': 'P Number', 'value': 'P14923'},
    {'dropdownType': 'P Number', 'value': 'P15181'},
    {'dropdownType': 'P Number', 'value': 'P15183'},
    {'dropdownType': 'P Number', 'value': 'P15205'},
    {'dropdownType': 'P Number', 'value': 'P15240'},
    {'dropdownType': 'P Number', 'value': 'P15321'},
    {'dropdownType': 'P Number', 'value': 'P15537'},
    {'dropdownType': 'P Number', 'value': 'P15707'},
    {'dropdownType': 'P Number', 'value': 'P4003'},
    {'dropdownType': 'P Number', 'value': 'P4220'},
    {'dropdownType': 'P Number', 'value': 'P4313'},
    {'dropdownType': 'P Number', 'value': 'P4314'},
    {'dropdownType': 'P Number', 'value': 'P4491'},
    {'dropdownType': 'P Number', 'value': 'P4492'},
    {'dropdownType': 'P Number', 'value': 'P4754'},
    {'dropdownType': 'P Number', 'value': 'P5087'},
    {'dropdownType': 'P Number', 'value': 'P5088'},
    {'dropdownType': 'P Number', 'value': 'P5089'},
    {'dropdownType': 'P Number', 'value': 'P5120'},
    {'dropdownType': 'P Number', 'value': 'P5188'},
    {'dropdownType': 'P Number', 'value': 'P5189'},
    {'dropdownType': 'P Number', 'value': 'P5884'},
    {'dropdownType': 'P Number', 'value': 'P5884'},
    {'dropdownType': 'P Number', 'value': 'P5885'},
    {'dropdownType': 'P Number', 'value': 'P6188'},
    {'dropdownType': 'P Number', 'value': 'P6278'},
    {'dropdownType': 'P Number', 'value': 'P6378'},
    {'dropdownType': 'P Number', 'value': 'P6521'},
    {'dropdownType': 'P Number', 'value': 'P7720'},
    {'dropdownType': 'P Number', 'value': 'P7767'},
    {'dropdownType': 'P Number', 'value': 'P8020'},
    {'dropdownType': 'P Number', 'value': 'P8130'},
    {'dropdownType': 'P Number', 'value': 'P8215'},
    {'dropdownType': 'P Number', 'value': 'P8626'},
    {'dropdownType': 'P Number', 'value': 'P8831'},
    {'dropdownType': 'P Number', 'value': 'P8832'},
    {'dropdownType': 'P Number', 'value': 'P8990'},
    {'dropdownType': 'P Number', 'value': 'P9416'},
    {'dropdownType': 'P Number', 'value': 'P9583'},
    {'dropdownType': 'P Number', 'value': 'P9653'},
    {'dropdownType': 'P Number', 'value': 'P9729'},
    {'dropdownType': 'P Number', 'value': 'P9733'},
    {'dropdownType': 'P Number', 'value': 'P9765'},
    {'dropdownType': 'P Number', 'value': 'P9799'},
    {'dropdownType': 'P Number', 'value': 'P9844'},
    {'dropdownType': 'P Number', 'value': 'P9862'},
    {'dropdownType': 'P Number', 'value': 'P9866'},
    {'dropdownType': 'P Number', 'value': 'P9882'},
    {'dropdownType': 'P Number', 'value': 'P9883'},
    {'dropdownType': 'P Number', 'value': 'P9914'},
    {'dropdownType': 'P Number', 'value': 'P9957'},
    {'dropdownType': 'P Number', 'value': 'PP15048'},
    {'dropdownType': 'P Number', 'value': 'PP15362'},
    {'dropdownType': 'P Number', 'value': 'PP15363'},
    {'dropdownType': 'P Number', 'value': 'PP15707'},
    {'dropdownType': 'P Number', 'value': 'PP15749'},
    {'dropdownType': 'P Number', 'value': 'PP15750'},
    {'dropdownType': 'P Number', 'value': 'PP15751'},
    {'dropdownType': 'P Number', 'value': 'PP15752'},
    {'dropdownType': 'P Number', 'value': 'SK8119 '},
    {'dropdownType': 'P Number', 'value': 'SK8120 '},
    {'dropdownType': 'P Number', 'value': 'SK8313 '},
    {'dropdownType': 'P Number', 'value': 'SK8314 '},
    {'dropdownType': 'P Number', 'value': 'SK8315 '},
    {'dropdownType': 'P Number', 'value': 'TC0296'},
    {'dropdownType': 'P Number', 'value': 'TC0306'},
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
