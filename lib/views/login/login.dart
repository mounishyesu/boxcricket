import 'dart:developer';

import 'package:boxcricket/views/authentication/auth.dart';
import 'package:boxcricket/views/pinsetup/setpin.dart';
import 'package:boxcricket/views/teamdashboard/teamdetails.dart';
import 'package:boxcricket/views/teamregistration/teamregistration.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/responsive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const LoginPage(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const LoginPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController pinController = TextEditingController();
  String capName = "", logPIN = "", teamCount = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.singinBgColor,
      bottomSheet: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              children: [
                SizedBox(
                  height: Constants.labelSize * 3,
                ),
                Icon(
                  Icons.tag_faces,
                  size: Constants.registrationTextFieldHeight,
                  color: Constants.blueGrey,
                ),
                SizedBox(
                  height: Constants.labelSize,
                ),
                GestureDetector(
                  onTap: () async {
                    bool isAuthenticated = await AuthService.authenticateUser();
                    if (isAuthenticated) {
                      log("success");
                    } else {
                      log("failed");
                    }
                  },
                  child: Text(
                    Constants.biometricUnlock,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        height: 2,
                        color: Constants.blueColor,
                        fontSize: Constants.textSize,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: Constants.labelSize,
                ),
                Text(
                  "( Or )",
                  style: TextStyle(
                      fontSize: Constants.labelSize,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Constants.defaultPadding,
                ),
                Text(
                  Constants.loginEnterPIN,
                  style: TextStyle(
                      fontSize: Constants.loginBtnTextSize,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Constants.defaultPadding,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      fillColor: Constants.textFieldFilledColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                    ),
                    onChanged: (value) => {
                      if (value.length > 4)
                        {
                          Get.defaultDialog(
                              title: "Alert",
                              middleText: "PIN must be 4 characters only"),
                          pinController.clear(),
                        }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: Constants.labelSize * 4,
                      right: Constants.defaultPadding,
                      top: Constants.defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {                        },
                        child: Text(
                          Constants.notYou,
                          style: TextStyle(
                            color: Constants.darkgrey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const SetPin());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            Constants.forgetPin,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              height: 2,
                              color: Constants.blueColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Constants.defaultPadding,
                ),
                GestureDetector(
                  onTap: () {
                    log(logPIN);
                    log(teamCount);
                    if(logPIN.toString() == pinController.text){
                      if(teamCount.toString() != null || teamCount.toString() != '0'){
                        Get.offAll(const TeamDetails());
                      }else{
                        Get.offAll(const TeamRegistration());
                      }
                    }else{
                      Get.snackbar("Alert", "PIN is Incorrect",
                          overlayBlur: 5,
                          backgroundColor: Constants.buttonRed,
                          titleText: Text(
                            'Alert',
                            style: TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.headerSize),
                          ),
                          messageText: Text(
                            "PIN is Incorrect",
                            style: TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.headerSize),
                          ));
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: Constants.registrationTextFieldHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Constants.buttonRed,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Text(
                      Constants.loginButton,
                      style: TextStyle(
                          color: Constants.buttonTextColor,
                          fontSize: Constants.loginBtnTextSize),
                    ),
                  ),
                ),
                SizedBox(
                  height: Constants.defaultPadding * 2,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Image.asset(
              Constants.logoImage,
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: Constants.defaultPadding * 2,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Hi ${capName.toString()}!',
                  style: TextStyle(
                      fontSize: Constants.loginBtnTextSize,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  checkDetails() async {
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    log(registerPrefs.getString('teamCaptain').toString());
    log(registerPrefs.getString('loginPIN').toString());
    log(registerPrefs.getString('teamCount').toString());
    setState(() {
      capName = registerPrefs.getString('teamCaptain').toString();
      logPIN = registerPrefs.getString('loginPIN').toString();
      teamCount = registerPrefs.getString('teamCount').toString();
    });
  }
}
