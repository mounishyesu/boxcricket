import 'dart:developer';

import 'package:boxcricket/views/authentication/auth.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.lightgrey,
      bottomSheet: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Constants.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            width: MediaQuery.of(context).size.width * 1,
            // height: MediaQuery.of(context).size.height * 0.5,
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
                  onTap: ()async{
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
                        onTap: () {},
                        child: Text(
                          Constants.notYou,
                          style: TextStyle(
                            color: Constants.darkgrey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
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
                  onTap: () {},
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
            Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Constants.blackColor),
            ),
            SizedBox(
              height: Constants.defaultPadding * 2,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Hi PAN SURYA!',
                  style: TextStyle(
                      fontSize: Constants.loginBtnTextSize,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
