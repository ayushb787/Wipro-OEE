import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wiproapp/LoginPage/LoginPage.dart';
import 'package:wiproapp/SelectServices/SelectService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:wiproapp/CreateUser/AddUsers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "login";
  static const String USERID = "user_id";
  static const String USERNAME = "user_name";

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    var userId = sharedPref.getString(USERID);
    var userName = sharedPref.getString(USERNAME);

    Timer(const Duration(seconds: 2), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SelectServiceWidget()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => UserLoginWidget()));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserLoginWidget()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler sScaler = ScreenScaler()..init(context);
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: FittedBox(
            child: Text(
              "WIPRO",
              style: TextStyle(
                  fontSize: sScaler.getTextSize(18),
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
