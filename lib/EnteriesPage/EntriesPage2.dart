import 'package:wiproapp/CreateUser/AddUsers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiproapp/SplashScreen.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter/cupertino.dart';
import 'package:wiproapp/DataBase/db.dart';
import 'package:wiproapp/SelectServices/SelectService.dart';
import 'package:elegant_notification/elegant_notification.dart';

class EnteriesPageTwoWidget extends StatefulWidget {
  final String? plant;
  final String? line;
  final String? machine;
  final String? shift;
  final String? operator;
  final String? pnumber;
  final String? loss;
  final String? userId;
  final String? userName;
  const EnteriesPageTwoWidget(
      {super.key,
      required this.plant,
      required this.line,
      required this.machine,
      required this.shift,
      required this.operator,
      required this.pnumber,
      required this.loss,
      required this.userId,
      required this.userName});

  @override
  State<EnteriesPageTwoWidget> createState() => _EnteriesPageTwoWidgetState();
}

class _EnteriesPageTwoWidgetState extends State<EnteriesPageTwoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadData = true;
  String? _subLoss = "Select Sub-Loss";
  String? _minutes = "";
  String? _defectQuantity = "";
  String? _setupNo = "";
  List<String> subLossValues = ["Select Sub-Loss"];
  final DateFormat formatter1 = DateFormat('h:mm a');
  final DateFormat formatter2 = DateFormat('dd/MM/yy');
  Future<void> getDropDownData() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    Future<List<String>> sublosses =
        databaseHelper.getAllSubLosses(widget.loss!);
    sublosses.then((result) {
      print(result);
      subLossValues.addAll(result);
      _loadData = false;
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler sScaler = ScreenScaler()..init(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        // appBar: PreferredSize(
        //   preferredSize:
        //       Size.fromHeight(MediaQuery.sizeOf(context).height * 0.10),
        //   child: AppBar(
        //     backgroundColor: Colors.white,
        //     automaticallyImplyLeading: false,
        //     flexibleSpace: FlexibleSpaceBar(
        //       background: ClipRRect(
        //         borderRadius: BorderRadius.circular(8),
        //         child: Image.asset(
        //           'assets/images/WiproLogo.png',
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),
        //     centerTitle: false,
        //     elevation: 0,
        //   ),
        // ),
        body: FutureBuilder(
            future: _loadData == true ? getDropDownData() : null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              }
              return CustomPaint(
                painter: CurvePainter(),
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/WiproLogo.png',
                                height: 59,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Select Following Options',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: sScaler.getTextSize(11),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.80,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFA5CF53),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                value: _subLoss,
                                onChanged: (value) {
                                  setState(() {
                                    _loadData = false;
                                    _subLoss = value;
                                  });
                                },
                                dropdownColor: const Color(0xFFA5CF53),
                                items: subLossValues.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        value,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: sScaler.getTextSize(11),
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                icon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: sScaler.getTextSize(14),
                                  ),
                                ),
                                isExpanded: true,
                                underline: Container(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.80,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF26B671),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Minutes',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontSize: sScaler.getTextSize(11),
                                    ),
                                    border: InputBorder.none,
                                    // filled: true,
                                    // fillColor: const Color(0xFF26B671),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.white,
                                    fontSize: sScaler.getTextSize(11.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _minutes = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.80,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF349AB5),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Defect Quantity',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontSize: sScaler.getTextSize(11),
                                    ),
                                    border: InputBorder.none,
                                    // filled: true,
                                    // fillColor: const Color(0xFF349AB5),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.white,
                                    fontSize: sScaler.getTextSize(11.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _defectQuantity = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.80,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF144F8B),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter No. of Setups',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontSize: sScaler.getTextSize(11),
                                    ),
                                    border: InputBorder.none,
                                    // filled: true,
                                    // fillColor: const Color(0xFF144F8B),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.white,
                                    fontSize: sScaler.getTextSize(11.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _setupNo = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 16, 0, 16),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (_subLoss == "Select Plant" ||
                                    _minutes == "" ||
                                    _defectQuantity == "" ||
                                    _setupNo == "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      'Select All Fields',
                                    ),
                                    backgroundColor: Colors.red,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  ));
                                } else {
                                  DatabaseHelper databaseHelper =
                                      DatabaseHelper.instance;

                                  // Inserting data
                                  Map<String, dynamic> userData = {
                                    'date': formatter2
                                        .format(DateTime.now())
                                        .toString(),
                                    'time': formatter1
                                        .format(DateTime.now())
                                        .toString(),
                                    'selectedPlant': widget.plant,
                                    'selectedLine': widget.line,
                                    'selectedMachine': widget.machine,
                                    'selectedUser': widget.userId,
                                    'selectedShift': widget.shift,
                                    'selectedOperator': widget.operator,
                                    'selectedPNumber': widget.pnumber,
                                    'selectedLoss': widget.loss,
                                    'selectedSubLoss': _subLoss,
                                    'selectedMinutes': _minutes,
                                    'selectedDefectQty': _defectQuantity,
                                    'selectedNoOfSetups': _setupNo,
                                    // Add other fields as needed
                                  };

                                  await databaseHelper.insertUserData(userData);
                                  ElegantNotification.success(
                                    title: const Text("Success"),
                                    description: const Text("Data Entered"),
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    toastDuration: const Duration(seconds: 5),
                                  ).show(context);
                                  List<Map<String, dynamic>> _data =
                                      await databaseHelper.getDataByDateRange(
                                          formatter2
                                              .format(DateTime.now())
                                              .toString(),
                                          formatter2
                                              .format(DateTime.now()
                                                  .add(Duration(days: 1)))
                                              .toString());
                                  print(
                                      "===============================================");
                                  print(_data);
                                  print(
                                      "===============================================");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectServiceWidget()));
                                }
                              },
                              text: 'Sumbit',
                              options: FFButtonOptions(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                elevation: 3,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

Color colorOne = Colors.deepPurple[400]!;
Color colorTwo = Colors.deepPurple[200]!;
Color colorThree = Colors.deepPurple[100]!;
Color colorFour = Colors.amberAccent;
Color colorFive = Colors.blueAccent;

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.70,
        size.width * 0.17, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.20, size.height, size.width * 0.25, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.40,
        size.width * 0.50, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
        size.width * 0.65, size.height * 0.65);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.90, size.width, 0);
    path.close();

    paint.color = colorThree;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.27, size.height * 0.60);
    path.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorTwo;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
        size.width * 0.22, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
        size.width * 0.40, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
        size.width * 0.65, size.height * 0.70);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.85, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorOne;
    canvas.drawPath(path, paint);

    path = Path();

    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.20,
        size.width * 0.17, size.height * 0.30);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.5,
        size.width * 0.25, size.height * 0.30);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.10,
        size.width * 0.50, size.height * 0.20);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.25,
        size.width * 0.65, size.height * 0.35);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.40, size.width, 0);
    path.close();

    paint.color = colorFour;
    canvas.drawPath(path, paint);

    // path = Path();

    // path.lineTo(0, size.height * 0.55);
    // path.quadraticBezierTo(size.width * 0.10, size.height * 0.40,
    //     size.width * 0.17, size.height * 0.50);
    // path.quadraticBezierTo(size.width * 0.20, size.height * 0.15,
    //     size.width * 0.25, size.height * 0.50);
    // path.quadraticBezierTo(size.width * 0.40, size.height * 0.30,
    //     size.width * 0.50, size.height * 0.40);
    // path.quadraticBezierTo(size.width * 0.60, size.height * 0.45,
    //     size.width * 0.65, size.height * 0.65);
    // path.quadraticBezierTo(
    //     size.width * 0.70, size.height * 0.70, size.width, 0);
    // path.close();

    // paint.color = colorFive;
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
