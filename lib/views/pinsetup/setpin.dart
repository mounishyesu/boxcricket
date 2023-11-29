import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/login/login.dart';
import 'package:boxcricket/views/teamdashboard/teamdetails.dart';
import 'package:boxcricket/views/teamregistration/teamregistration.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.setpinHeader),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize, color: Constants.blackColor),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_circle_left_sharp,
        //     size: Constants.backIconSize,
        //     color: Constants.backIconColor,
        //   ),
        //   onPressed: () => Get.back(),
        // ),
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
                          backgroundColor: Constants.buttonRed,
                          titleText: Text(
                            'Alert',
                            style: TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.headerSize),
                          ),
                          messageText: Text(
                            Constants.enterpinCheck,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.textSize,
                                color: Constants.whiteColor),
                          ));
                    } else if (confirmPinController.text.isEmpty ||
                        confirmPinController.text.length < 4) {
                      Get.snackbar(
                        "Alert",
                        Constants.reenterpinCheck,
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
                          Constants.reenterpinCheck,
                          style: TextStyle(
                              color: Constants.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Constants.textSize),
                        ),
                      );
                    } else if (pinController.text.toString() !=
                        confirmPinController.text.toString()) {
                      Get.snackbar(
                        "Alert",
                        Constants.pinCheck,
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
                          Constants.pinCheck,
                          style: TextStyle(
                              color: Constants.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Constants.headerSize),
                        ),
                      );
                    } else {
                      setPin();
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

  setPin() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Saving . . .",
    );
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    log(registerPrefs.getString('captainNumber').toString());
    var encodeBody = jsonEncode({
      "mobile_number": registerPrefs.getString('captainNumber').toString(),
      "new_pin": confirmPinController.text
    });
    log(encodeBody);
    await ApiService.post("Users/createPin", encodeBody).then((success) async {
      var responseBody = json.decode(success.body);
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          log(responseBody.toString());
          if (responseBody['status'] == true) {
            savePinDetails(responseBody);
            // Get.snackbar("Alert", responseBody['message'].toString(),
            //     overlayBlur: 5,
            //     backgroundColor: Constants.green,
            //     titleText: Text(
            //       'Alert',
            //       style: TextStyle(
            //           color: Constants.whiteColor,
            //           fontWeight: FontWeight.bold,
            //           fontSize: Constants.headerSize),
            //     ),
            //     messageText: Text(
            //       responseBody['message'].toString(),
            //       style: TextStyle(
            //           color: Constants.whiteColor,
            //           fontWeight: FontWeight.bold,
            //           fontSize: Constants.textSize),
            //     ));
            Get.offAll(() => const Login());
          }
        });
        EasyLoading.showSuccess(responseBody['message'].toString());
      } else {
        EasyLoading.showInfo("PIN Creation Failed");
      }
    });
  }
}

savePinDetails(resposnseBody) async {
  SharedPreferences registerPrefs = await SharedPreferences.getInstance();

  registerPrefs.setString(
      "teamID", resposnseBody["team"]['team_id'].toString());

  registerPrefs.setString(
      "teamName", resposnseBody["team"]['team_name'].toString());

  registerPrefs.setString(
      "teamCaptain", resposnseBody['team']['team_captain'].toString());

  registerPrefs.setString(
      "captainNumber", resposnseBody['team']['captain_mobile'].toString());

  registerPrefs.setString("loginPIN", resposnseBody['team']['pin'].toString());
  registerPrefs.setString("teamCount", resposnseBody['teamCount'].toString());

  log('------------------');
  log(registerPrefs.getString('teamID').toString());
  log(registerPrefs.getString('loginPIN').toString());
  log(registerPrefs.getString('teamName').toString());
  log(registerPrefs.getString('teamCaptain').toString());
  log(registerPrefs.getString('teamCount').toString());
  log(registerPrefs.getString('captainNumber').toString());
}
