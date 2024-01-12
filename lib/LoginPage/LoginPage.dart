import 'package:wiproapp/SplashScreen.dart';
import '/SelectServices/SelectService.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/CustomWidgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:wiproapp/DataBase/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class UserLoginWidget extends StatefulWidget {
  const UserLoginWidget({Key? key}) : super(key: key);

  @override
  UserLoginWidgetState createState() => UserLoginWidgetState();
}

class UserLoginWidgetState extends State<UserLoginWidget> {
  late String _userId;
  late String _password;
  var _passwordVisibility = false;

  @override
  void initState() {
    super.initState();
    _passwordVisibility = false;
  }

  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler sScaler = ScreenScaler()..init(context);
    return GestureDetector(
      onTap: () => _focusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_focusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: 100,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  alignment: const AlignmentDirectional(0.00, -1.00),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          alignment: const AlignmentDirectional(-1.00, 0.00),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 20, 20, 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/WiproLogo.png',
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.00, 1.00),
                          child: Text('Login Page',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto Mono',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.00, 0.00),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                32, 32, 32, 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: TextFormField(
                                      autofocus: false,
                                      focusNode: _focusNode,
                                      autofillHints: const [
                                        AutofillHints.username
                                      ],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'User Id',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: const Color(0xFF57636C),
                                          fontSize: sScaler.getTextSize(11),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFF1F4F8),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF1F4F8),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: const Color(0xFF101213),
                                        fontSize: sScaler.getTextSize(11),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        _userId = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: TextFormField(
                                      autofocus: false,
                                      autofillHints: const [
                                        AutofillHints.password
                                      ],
                                      obscureText: !_passwordVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: const Color(0xFF57636C),
                                          fontSize: sScaler.getTextSize(11),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFF1F4F8),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF1F4F8),
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _passwordVisibility =
                                                !_passwordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: const Color(0xFF57636C),
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: const Color(0xFF101213),
                                        fontSize: sScaler.getTextSize(11),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      onChanged: (value) {
                                        _password = value;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _focusNode.unfocus();
                                      DatabaseHelper dbHelper =
                                          DatabaseHelper.instance;
                                      try {
                                        if (_userId == "admin" &&
                                            _password == "admin123") {
                                          var sharedPref =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPref.setBool(
                                              SplashScreenState.KEYLOGIN, true);
                                          sharedPref.setString(
                                              SplashScreenState.USERID,
                                              'admin');
                                          sharedPref.setString(
                                              SplashScreenState.USERNAME,
                                              'ADMIN');
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectServiceWidget()));
                                        } else {
                                          // Authorize login
                                          Map<String, dynamic>? user =
                                              await dbHelper.authorizeLogin(
                                                  _userId, _password);
                                          print(
                                              "========================Response User=====================");
                                          print(user);
                                          if (user != null) {
                                            print(
                                                'Login successful! User ID: ${user['userId']}, Name: ${user['name']}');

                                            var sharedPref =
                                                await SharedPreferences
                                                    .getInstance();
                                            sharedPref.setBool(
                                                SplashScreenState.KEYLOGIN,
                                                true);
                                            sharedPref.setString(
                                                SplashScreenState.USERID,
                                                user['userId']);
                                            sharedPref.setString(
                                                SplashScreenState.USERNAME,
                                                user['name']);
                                            const String USERID_KEY =
                                                SplashScreenState.USERID;
                                            const String USERNAME_KEY =
                                                SplashScreenState.USERNAME;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Login Successful',
                                                ),
                                                backgroundColor: Colors.green,
                                                elevation: 10,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(5),
                                              ),
                                            );
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectServiceWidget()));
                                          } else {
                                            print('Login failed');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Login Failed',
                                                ),
                                                backgroundColor: Colors.red,
                                                elevation: 10,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(5),
                                              ),
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        final snackBar = SnackBar(
                                          content:
                                              Text('Error: ${e.toString()}'),
                                          backgroundColor: Colors.red,
                                          elevation: 10,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(5),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    text: 'Sign In',
                                    options: FFButtonOptions(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: const Color(0xFF4B39EF),
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

                                // You will have to add an action on this rich text to go to your login page.
                                // Padding(
                                //   padding: const EdgeInsetsDirectional.fromSTEB(
                                //       0, 12, 0, 12),
                                //   child: InkWell(
                                //     splashColor: Colors.transparent,
                                //     focusColor: Colors.transparent,
                                //     hoverColor: Colors.transparent,
                                //     highlightColor: Colors.transparent,
                                //     onTap: () async {
                                //       if (_email.isEmpty) {
                                //         ScaffoldMessenger.of(context)
                                //             .showSnackBar(
                                //           const SnackBar(
                                //             content: Text(
                                //               'Email required!',
                                //             ),
                                //             backgroundColor: Colors.red,
                                //             elevation: 10,
                                //             behavior: SnackBarBehavior.floating,
                                //             margin: EdgeInsets.all(5),
                                //           ),
                                //         );
                                //         return;
                                //       }
                                //       await _auth.sendPasswordResetEmail(
                                //         email: _email,
                                //       );
                                //     },
                                //     child: RichText(
                                //       textScaleFactor: MediaQuery.of(context)
                                //           .textScaleFactor,
                                //       text: TextSpan(
                                //         children: [
                                //           const TextSpan(
                                //             text: 'Don\'t RememberPassword? ',
                                //             style: TextStyle(),
                                //           ),
                                //           TextSpan(
                                //             text: 'Forgot Password',
                                //             style: TextStyle(
                                //               fontFamily: 'Plus Jakarta Sans',
                                //               color: const Color(0xFF4B39EF),
                                //               fontSize: sScaler.getTextSize(11),
                                //               fontWeight: FontWeight.w600,
                                //             ),
                                //           )
                                //         ],
                                //         style: TextStyle(
                                //           fontFamily: 'Plus Jakarta Sans',
                                //           color: Color(0xFF101213),
                                //           fontSize: sScaler.getTextSize(11),
                                //           fontWeight: FontWeight.w500,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                // // You will have to add an action on this rich text to go to your login page.
                                // Padding(
                                //   padding: const EdgeInsetsDirectional.fromSTEB(
                                //       0, 12, 0, 12),
                                //   child: InkWell(
                                //     splashColor: Colors.transparent,
                                //     focusColor: Colors.transparent,
                                //     hoverColor: Colors.transparent,
                                //     highlightColor: Colors.transparent,
                                //     onTap: () async {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) =>
                                //                   const AdminLoginWidget()));
                                //     },
                                //     child: RichText(
                                //       textScaleFactor: MediaQuery.of(context)
                                //           .textScaleFactor,
                                //       text: TextSpan(
                                //         children: [
                                //           const TextSpan(
                                //             text: 'Go to Admin Login? ',
                                //             style: TextStyle(),
                                //           ),
                                //           TextSpan(
                                //             text: 'Admin Login here',
                                //             style: TextStyle(
                                //               fontFamily: 'Plus Jakarta Sans',
                                //               color: const Color(0xFF4B39EF),
                                //               fontSize: sScaler.getTextSize(11),
                                //               fontWeight: FontWeight.w600,
                                //             ),
                                //           )
                                //         ],
                                //         style: TextStyle(
                                //           fontFamily: 'Plus Jakarta Sans',
                                //           color: const Color(0xFF101213),
                                //           fontSize: sScaler.getTextSize(11),
                                //           fontWeight: FontWeight.w500,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
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
      ),
    );
  }
}
