import 'dart:developer';

import 'package:boxcricket/views/login/login.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPin extends StatefulWidget {
  const SetPin({super.key});

  @override
  State<SetPin> createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const SetPinScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const SetPinScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.setpinHeader),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize, color: Constants.blackColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Constants.backIconSize,
            color: Constants.backIconColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: Constants.defaultPadding),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constants.setPinTitle,
                  style: TextStyle(color: Constants.darkgrey),
                ),
                SizedBox(
                  height: Constants.defaultPadding * 2,
                ),
                Text(
                  Constants.enterPIN,
                  style: TextStyle(fontSize: Constants.loginBtnTextSize),
                ),
                SizedBox(
                  height: Constants.defaultPadding * 2,
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
                SizedBox(
                  height: Constants.defaultPadding * 2,
                ),
                Text(
                  Constants.reenterPIN,
                  style: TextStyle(fontSize: Constants.loginBtnTextSize),
                ),
                SizedBox(
                  height: Constants.defaultPadding * 2,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: confirmPinController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      fillColor: Constants.textFieldFilledColor,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                    ),
                    onChanged: (value) => {
                      print(value.length),
                      if (value.length > 4)
                        {
                          Get.defaultDialog(
                              title: "Alert",
                              middleText: "PIN must be 4 characters only"),
                          confirmPinController.clear(),
                        }
                    },
                  ),
                ),
                SizedBox(
                  height: Constants.defaultPadding * 3,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.24,
                  decoration: BoxDecoration(
                    color: Constants.textFieldFilledColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Helpful Tips",
                        style: TextStyle(fontSize: Constants.headerSize),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "* Avoid using personal information such as date of birth",
                        style: TextStyle(fontSize: Constants.headerSize),
                      ),
                      Text(
                        "* Never repeat numbers",
                        style: TextStyle(fontSize: Constants.headerSize),
                      ),
                      Text(
                        "* Avoid using consecutive numbers",
                        style: TextStyle(fontSize: Constants.headerSize),
                      ),
                      Text(
                        "* Do not reuse your pin",
                        style: TextStyle(fontSize: Constants.headerSize),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    log(pinController.text);
                    log(confirmPinController.text);
                    if (pinController.text.isEmpty ||
                        pinController.text.length < 4) {
                      Get.snackbar("Alert", Constants.enterpinCheck,
                          overlayBlur: 5,
                          backgroundColor: Constants.whiteColor,
                          titleText: Text(
                            'Alert',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.headerSize),
                          ),
                          messageText: Text(Constants.enterpinCheck));
                    } else if (confirmPinController.text.isEmpty ||
                        confirmPinController.text.length < 4) {
                      Get.snackbar("Alert", Constants.reenterpinCheck,
                          overlayBlur: 5,
                          backgroundColor: Constants.whiteColor,
                          titleText: Text(
                            'Alert',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.headerSize),
                          ),
                          messageText: Text(Constants.reenterpinCheck));
                    } else if (pinController.text.toString() !=
                        confirmPinController.text.toString()) {
                      Get.snackbar("Alert", Constants.pinCheck,
                          overlayBlur: 5,
                          backgroundColor: Constants.whiteColor,
                          titleText: Text(
                            'Alert',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.headerSize),
                          ),
                          messageText: Text(Constants.pinCheck));
                    } else {
                      Get.to(const Login());
                    }
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Constants.registrationTextFieldHeight),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: Constants.loginTextFieldHeight,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Constants.buttonRed,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Text(
                        Constants.nextButton,
                        style: TextStyle(
                            color: Constants.buttonTextColor,
                            fontSize: Constants.loginBtnTextSize),
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
  }
}
