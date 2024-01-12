import 'package:flutter/material.dart';
import 'package:wiproapp/CustomWidgets/custom_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:excel/excel.dart';
import 'package:external_path/external_path.dart';
import 'dart:io';
import 'package:wiproapp/DataBase/db.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:wiproapp/SelectServices/SelectService.dart';

class DeleteDateSelectorWidget extends StatefulWidget {
  const DeleteDateSelectorWidget({super.key});

  @override
  State<DeleteDateSelectorWidget> createState() =>
      _SelectDateRouteWidgetState();
}

class _SelectDateRouteWidgetState extends State<DeleteDateSelectorWidget> {
  final DateFormat formatter1 = DateFormat('h:mm a');
  final DateFormat formatter2 = DateFormat('dd/MM/yy');
  String _range = '';
  DateTime _selectedStartDate = DateTime.now().toLocal();
  DateTime _selectedEndDate = DateTime.now().toLocal();
  final TextEditingController _typeAheadController = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yy').format(args.value.endDate ?? args.value.startDate)}';
        _selectedStartDate = args.value.startDate;
        _selectedEndDate = args.value.endDate;
        _typeAheadController.text =
            "${DateFormat('dd MMM, yy').format(_selectedStartDate).toString()}  to  ${DateFormat('dd MMM, yy').format(_selectedEndDate).toString()}";
      }
    });
  }

  Future<void> exportToExcel(
      String selectedStartDate, String selectedEndDate) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List<Map<String, dynamic>> _data = await databaseHelper.getDataByDateRange(
        selectedStartDate, selectedEndDate);
    print("===============================================");
    print(_data);
    print("===============================================");
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];
    // Header row
    List<String> headers = [
      "Date",
      "Time",
      "Plant",
      "Line",
      "Machine",
      "User",
      "Shift",
      "Operator",
      "P Number",
      "Loss",
      "SubLoss",
      "Minutes",
      "Defect Quantity",
      "No Of Setups",
    ];

    for (int i = 0; i < headers.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
        ..value = headers[i]
        ..cellStyle = CellStyle(underline: Underline.Single);
    }
    // Data rows
    for (int rowIndex = 0; rowIndex < _data.length; rowIndex++) {
      Map<String, dynamic> record = _data[rowIndex];
      List<String> values = [
        record['date'] ?? '',
        record['time'] ?? '',
        record['selectedPlant'] ?? '',
        record['selectedLine'] ?? '',
        record['selectedMachine'] ?? '',
        record['selectedUser'] ?? '',
        record['selectedShift'] ?? '',
        record['selectedOperator'] ?? '',
        record['selectedPNumber'] ?? '',
        record['selectedLoss'] ?? '',
        record['selectedSubLoss'] ?? '',
        record['selectedMinutes'] ?? '',
        record['selectedDefectQty'] ?? '',
        record['selectedNoOfSetups'] ?? '',
      ];

      for (int i = 0; i < values.length; i++) {
        sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: i, rowIndex: rowIndex + 1))
          ..value = values[i];
      }
    }

    var fileBytes = excel.save();
    DateTime today = DateTime.now();
    var timeStr = "${today.hour}-${today.minute}-${today.second}";
    var dateStr = "${today.day}-${today.month}-${today.year}";
    var directory = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    File("$directory/${dateStr}_$timeStr.xlsx")
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler sScaler = ScreenScaler()..init(context);
    return SafeArea(
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Scaffold(
          // // appBar: PreferredSize(
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
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                        child: Text(
                          'Delete Data From Database',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: const Color(0xFF57636C),
                            fontSize: sScaler.getTextSize(11),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 8),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 60,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                showCalendarDialog(context);
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    _typeAheadController.text.isEmpty
                                        ? 'Select Date Range'
                                        : _typeAheadController.text,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontSize: sScaler.getTextSize(11),

                                      // fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_typeAheadController.text.isEmpty) {
                              print("Please Select Date Range");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please Select Date Range',
                                  ),
                                  backgroundColor: Colors.red,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                  duration: Duration(milliseconds: 1000),
                                ),
                              );
                              return;
                            }
                            try {
                              exportToExcel(
                                  formatter2
                                      .format(_selectedStartDate)
                                      .toString(),
                                  formatter2
                                      .format(_selectedEndDate)
                                      .toString());
                              DatabaseHelper databaseHelper =
                                  DatabaseHelper.instance;
                              databaseHelper.deleteDataByDateRange(
                                  formatter2
                                      .format(_selectedStartDate)
                                      .toString(),
                                  formatter2
                                      .format(_selectedEndDate)
                                      .toString());
                              ElegantNotification.success(
                                title: const Text("Success"),
                                description: const Text("Data Is Cleared"),
                                width: MediaQuery.of(context).size.width - 30,
                                toastDuration: const Duration(seconds: 5),
                              ).show(context);
                            } catch (e) {
                              print(e);
                              ElegantNotification.error(
                                title: const Text("Error"),
                                description: const Text("Could Not Clear Data"),
                                width: 300,
                              ).show(context);
                            }

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SelectServiceWidget()));
                          },
                          text: 'Delete',
                          icon: Icon(
                            Icons.download,
                            color: Colors.white,
                            size: sScaler.getTextSize(14),
                          ),
                          options: FFButtonOptions(
                            width: MediaQuery.of(context).size.width * 0.80,
                            height: MediaQuery.of(context).size.height * 0.06,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: Colors.black,
                            textStyle: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.white,
                              fontSize: sScaler.getTextSize(11.5),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showCalendarDialog(BuildContext context) {
    final kToday = DateTime.now().toLocal();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  backgroundColor: Colors.black,
                  mini: true,
                  elevation: 5.0,
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
                AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    scrollable: true,
                    actionsOverflowButtonSpacing: 20,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 400,
                          width: 500,
                          child: SfDateRangePicker(
                              onSelectionChanged: _onSelectionChanged,
                              selectionMode:
                                  DateRangePickerSelectionMode.extendableRange,
                              confirmText: 'OK',
                              cancelText: 'RESET',
                              initialSelectedRange: PickerDateRange(
                                DateTime.now()
                                    .toLocal()
                                    .subtract(const Duration(days: 0)),
                                DateTime.now()
                                    .toLocal()
                                    .add(const Duration(days: 0)),
                              ),
                              showActionButtons: true,
                              viewSpacing: 20,
                              selectionRadius: -1,
                              onSubmit: (val) {
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                setState(() {
                                  _selectedEndDate = DateTime.now().toLocal();
                                  _selectedStartDate = DateTime.now().toLocal();
                                });
                              },
                              cellBuilder: (BuildContext context,
                                  DateRangePickerCellDetails cellDetails) {
                                bool isSelectedDate = cellDetails.date ==
                                    DateTime.now().toLocal();
                                return Center(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelectedDate
                                        ? Colors.blue
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    cellDetails.date.day.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      color: isSelectedDate
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ));
                              }),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
