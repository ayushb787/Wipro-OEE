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
import 'package:wiproapp/EnteriesPage/EntriesPage2.dart';

class EnteriesPageOneWidget extends StatefulWidget {
  final String? userId;
  final String? userName;
  const EnteriesPageOneWidget(
      {super.key, required this.userId, required this.userName});

  @override
  State<EnteriesPageOneWidget> createState() => _EnteriesPageOneWidgetState();
}

class _EnteriesPageOneWidgetState extends State<EnteriesPageOneWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadData = true;
  String? _plant = "Select Plant";
  String? _line = "Select Line";
  String? _machine = "Select Machine";
  String? _shift = "Select Shift";
  String? _operator = "Select Operator";
  String? _pnumber = "Select P Number";
  String? _loss = "Select Loss";
  List<String> plantValues = ["Select Plant"];
  List<String> lineValues = ["Select Line"];
  List<String> machineValues = ["Select Machine"];
  List<String> shiftValues = ["Select Shift"];
  List<String> operatorValues = ["Select Operator"];
  List<String> pnumberValues = ["Select P Number"];
  List<String> lossValues = ["Select Loss"];

  Future<void> getDropDownData() async {
    // plantValues = ["Select Plant"];
    // lineValues = ["Select Line"];
    // machineValues = ["Select Machine"];
    // shiftValues = ["Select Shift"];
    // operatorValues = ["Select Operator"];
    // pnumberValues = ["Select P Number"];
    if (_loadData) {
      DatabaseHelper databaseHelper = DatabaseHelper.instance;
      List<Map<String, dynamic>> plantDropdownValues =
          await databaseHelper.getDropdownValuesByType('Plant');
      List<Map<String, dynamic>> lineDropdownValues =
          await databaseHelper.getDropdownValuesByType('Line');
      List<Map<String, dynamic>> machineDropdownValues =
          await databaseHelper.getDropdownValuesByType('Machine');
      List<Map<String, dynamic>> shiftDropdownValues =
          await databaseHelper.getDropdownValuesByType('Shift');
      List<Map<String, dynamic>> operatorDropdownValues =
          await databaseHelper.getDropdownValuesByType('Operator');
      List<Map<String, dynamic>> pnumberDropdownValues =
          await databaseHelper.getDropdownValuesByType('P Number');
      List<Map<String, dynamic>> lossDropdownValues =
          await databaseHelper.getDropdownValuesByType('Loss');

      List<String> lineVal =
          lineDropdownValues.map((map) => map['value'] as String).toList();
      List<String> plantVal =
          plantDropdownValues.map((map) => map['value'] as String).toList();
      List<String> machineVal =
          machineDropdownValues.map((map) => map['value'] as String).toList();
      List<String> shiftVal =
          shiftDropdownValues.map((map) => map['value'] as String).toList();
      List<String> operatorVal =
          operatorDropdownValues.map((map) => map['value'] as String).toList();
      List<String> pnumberVal =
          pnumberDropdownValues.map((map) => map['value'] as String).toList();
      List<String> lossVal =
          lossDropdownValues.map((map) => map['value'] as String).toList();
      plantValues.addAll(plantVal);
      lineValues.addAll(lineVal);
      machineValues.addAll(machineVal);
      shiftValues.addAll(shiftVal);
      operatorValues.addAll(operatorVal);
      pnumberValues.addAll(pnumberVal);
      lossValues.addAll(lossVal);
      _loadData = false;
    }
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
                                value: _plant,
                                onChanged: (value) {
                                  setState(() {
                                    _loadData = false;
                                    _plant = value;
                                  });
                                },
                                dropdownColor: const Color(0xFFA5CF53),
                                items: plantValues.map((String value) {
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
                              child: DropdownButton<String>(
                                value: _line,
                                onChanged: (value) {
                                  setState(() {
                                    _loadData = false;
                                    _line = value;
                                  });
                                },
                                dropdownColor: const Color(0xFF26B671),
                                items: lineValues.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Colors.white,
                                          fontSize: sScaler.getTextSize(11),
                                          fontWeight: FontWeight.w500,
                                        ),
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
                                color: const Color(0xFF349AB5),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                value: _machine,
                                onChanged: (value) {
                                  setState(() {
                                    _loadData = false;
                                    _machine = value;
                                  });
                                },
                                dropdownColor: const Color(0xFF349AB5),
                                items: machineValues.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: sScaler.getTextSize(11),
                                          fontWeight: FontWeight.w500,
                                        ),
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
                                color: const Color(0xFF144F8B),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                value: _shift,
                                onChanged: (value) {
                                  setState(() {
                                    _loadData = false;
                                    _shift = value;
                                  });
                                },
                                dropdownColor: const Color(0xFF144F8B),
                                items: shiftValues.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: sScaler.getTextSize(11),
                                          fontWeight: FontWeight.w500,
                                        ),
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
                                color: const Color(0xFF4E639C),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                value: _operator,
                                onChanged: (value) {
                                  setState(() {
                                    _loadData = false;
                                    _operator = value;
                                  });
                                },
                                dropdownColor: const Color(0xFF4E639C),
                                items: operatorValues.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: sScaler.getTextSize(11),
                                          fontWeight: FontWeight.w500,
                                        ),
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
                                color: const Color(0xFFB7176F),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                value: _pnumber,
                                onChanged: (value) {
                                  setState(() {
                                    _loadData = false;
                                    _pnumber = value;
                                  });
                                },
                                dropdownColor: const Color(0xFFB7176F),
                                items: pnumberValues.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: sScaler.getTextSize(11),
                                          fontWeight: FontWeight.w500,
                                        ),
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
                                color: const Color(0xFFF4802B),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                value: _loss,
                                onChanged: (value) {
                                  setState(() {
                                    _loadData = false;
                                    _loss = value;
                                  });
                                },
                                dropdownColor: const Color(0xFFF4802B),
                                items: lossValues.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: sScaler.getTextSize(11),
                                          fontWeight: FontWeight.w500,
                                        ),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 16, 0, 16),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (_plant == "Select Plant" ||
                                    _line == "Select Line" ||
                                    _machine == "Select Machine" ||
                                    _shift == "Select Shift" ||
                                    _operator == "Select Operator" ||
                                    _pnumber == "Select P Number" ||
                                    _loss == "Select Loss") {
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EnteriesPageTwoWidget(
                                                  plant: _plant,
                                                  line: _line,
                                                  machine: _machine,
                                                  shift: _shift,
                                                  operator: _operator,
                                                  pnumber: _pnumber,
                                                  loss: _loss,
                                                  userId: widget.userId,
                                                  userName: widget.userName)));
                                }
                              },
                              text: 'Next',
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
