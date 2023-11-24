import 'dart:async';
import 'dart:developer';

import 'package:boxcricket/views/login/login.dart';
import 'package:boxcricket/views/pinsetup/setpin.dart';
import 'package:boxcricket/views/signup/signup.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      _changeOpacity();
    });

    getLoginstatus();
  }

  getLoginstatus() async {
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 1500));
    log(registerPrefs.getString('teamID').toString());
    log(registerPrefs.getString('pin').toString());
    log("page checking");
    if (registerPrefs.getString('teamID') == null) {
      Timer(const Duration(seconds: 3), () => Get.offAll(const SingnUpPage()));
    } else {
      if (registerPrefs.getString('loginPIN') != null && registerPrefs.getString('loginPIN') != "" ) {
        Timer(const Duration(seconds: 3), () => Get.offAll(const Login()));
      } else {
        Timer(const Duration(seconds: 3), () => Get.offAll(const SetPin()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Constants.singinBgColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: AnimatedOpacity(
                opacity: opacityLevel,
                duration: const Duration(seconds: 3),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Constants.ballImage))),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.asset(
                        Constants.logoImage,
                        height: 350,
                        width: 350,
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    ));
  }
}
