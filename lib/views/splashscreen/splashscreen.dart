import 'dart:async';

import 'package:boxcricket/views/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      _changeOpacity();
    });
    _navigateToLogin();

    // getLoginstatus().then((status) {
    //   if (status) {
    //     _navigateToHome();
    //   } else {
    //     _navigateToLogin();
    //   }
    // });
  }

  // getLoginstatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await Future.delayed(Duration(milliseconds: 1500));
  //   if (prefs.getBool('isLogin') == null) {
  //     return false;
  //   }
  //   else{
  //     return true;
  //   }
  // }

  // void _navigateToHome() {
  //   Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuditHome(fromType: 'login',))));
  //
  // }


  void _navigateToLogin() {
    Timer(const Duration(seconds: 3), () => Get.to(const SingnUpPage()));
  }

  @override


  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                    opacity: opacityLevel,
                    duration:  Duration(seconds: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      width: MediaQuery.of(context).size.width*0.7,
                      height: MediaQuery.of(context).size.height*0.4,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          // Image.asset("assets/images/splash_logo.png",),
                          Text("Welcome")
                        ],
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
