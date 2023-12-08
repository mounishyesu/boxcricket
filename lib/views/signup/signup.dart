import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/home/homepage.dart';
import 'package:boxcricket/views/teamdashboard/teamdetails.dart';
import 'package:boxcricket/views/teamregistration/teamregistration.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../otp/otpscreen.dart';

class SingnUpPage extends StatefulWidget {
  const SingnUpPage({super.key});

  @override
  State<SingnUpPage> createState() => _SingnUpPageState();
}

class _SingnUpPageState extends State<SingnUpPage> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const SingnUpScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const SingnUpScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SingnUpScreen extends StatefulWidget {
  const SingnUpScreen({super.key});

  @override
  State<SingnUpScreen> createState() => _SingnUpScreenState();
}

class _SingnUpScreenState extends State<SingnUpScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.singinBgColor,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Constants.bgImage), fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Center(
                    child: Text(
                  Constants.welcomeHeader,
                  style: TextStyle(
                      color: Constants.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.welcomeTextSize),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: "Enter Your Mobile Number",
                    ),
                    onChanged: (value) => {
                      if (value.length > 10)
                        {
                          Get.defaultDialog(
                              title: "Alert",
                              middleText:
                                  "Mobile Number Cannot Be More Than 10 Characters"),
                          mobileNumberController.clear(),
                        }
                      else
                        {log(value)}
                    },
                  ),
                ),
                SizedBox(
                  height: Constants.labelSize,
                ),
                GestureDetector(
                  onTap: () => {
                    if (mobileNumberController.text.toString().isEmpty)
                      {
                        Get.snackbar("Alert", Constants.loginAlertMsg,
                            overlayBlur: 5,
                            backgroundColor: Constants.buttonRed,
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize,
                                  color: Constants.whiteColor),
                            ),
                            messageText: Text(
                              Constants.loginAlertMsg,
                              style: TextStyle(
                                  fontSize: Constants.textSize,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.whiteColor),
                            )),
                      }
                    else if (mobileNumberController.text.length < 10)
                      {
                        Get.snackbar("Alert", Constants.loginAlertMsg,
                            overlayBlur: 5,
                            backgroundColor: Constants.buttonRed,
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize,
                                  color: Constants.whiteColor),
                            ),
                            messageText: Text(
                              Constants.loginAlertMsg,
                              style: TextStyle(
                                  fontSize: Constants.textSize,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.whiteColor),
                            )),
                      }
                    else
                      {
                        sendOtpApiService(
                            mobileNumberController.text.toString()),
                        // Get.to(const OtpVerification()),
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
                      Constants.newTeam,
                      style: TextStyle(
                          color: Constants.buttonTextColor,
                          fontSize: Constants.loginBtnTextSize),
                    ),
                  ),
                ),
                SizedBox(
                  height: Constants.defaultPadding * 2,
                ),
                const Text(
                  "Or",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () => {
                    Get.to(() => const Home()),
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
                      Constants.cricketFan,
                      style: TextStyle(
                          color: Constants.buttonTextColor,
                          fontSize: Constants.loginBtnTextSize),
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

  sendOtpApiService(mobNumber) async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "sending OTP",
    );
    var requestBody = jsonEncode({"mobile_number": mobNumber});
    await ApiService.otpPostCall("Users/MobileOtp", requestBody)
        .then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          String data = success.body; //store response as string
          var responseBody = json.decode(data);
          log(responseBody.toString());
          if (responseBody['status'] == true &&
              responseBody['data']['OTP'] != "") {
            if (responseBody['data']['isExist'] == false) {
              Future.delayed(const Duration(seconds: 2), () async {
                Get.to(const OtpVerification(), arguments: responseBody);
              });
            } else {
              saveUserDetails(responseBody);
              if (responseBody['data']['teamCount'] > 0) {
                Get.offAll(() => const TeamDetails());
              } else {
                Get.to(() => const TeamRegistration());
              }
            }
            // Get.snackbar(
            //   'Alert',
            //   responseBody['message'],
            //   titleText: Text(
            //     'Alert',
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: Constants.headerSize,
            //         color: Constants.whiteColor),
            //   ),
            //   backgroundColor: Constants.green,
            //   overlayBlur: 5,
            //   messageText: Text(
            //     responseBody['message'],
            //     style: TextStyle(
            //         fontSize: Constants.textSize,
            //         fontWeight: FontWeight.bold,
            //         color: Constants.whiteColor),
            //   ),
            // );
          } else {
            Get.snackbar('Alert', Constants.someThingWentWrong,
                backgroundColor: Constants.buttonRed,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize,
                      color: Constants.whiteColor),
                ),
                overlayBlur: 5,
                messageText: Text(
                  Constants.someThingWentWrong,
                  style: TextStyle(
                      fontSize: Constants.textSize,
                      fontWeight: FontWeight.bold,
                      color: Constants.whiteColor),
                ));
          }
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading failed");
      }
    });
  }
}

saveUserDetails(resposnse) async {
  SharedPreferences registerPrefs = await SharedPreferences.getInstance();
  registerPrefs.setString("userDetails", resposnse["data"]['user'].toString());
  registerPrefs.setString(
      "teamID", resposnse["data"]['user']['team_id'].toString());
  registerPrefs.setString(
      "teamName", resposnse["data"]['user']['team_name'].toString());
  registerPrefs.setString(
      "teamCaptain", resposnse["data"]['user']['team_captain'].toString());
  registerPrefs.setString(
      "captainNumber", resposnse["data"]['Mobile Number'].toString());
  registerPrefs.setString(
      "teamCount", resposnse["data"]['teamCount'].toString());
  registerPrefs.setString(
      "loginPIN", resposnse["data"]['user']['pin'].toString());
  registerPrefs.setString("capProfilePic",
      resposnse["data"]['user']['profile_image_url'].toString());
  log("==================");
  log(resposnse.toString());
  log(registerPrefs.getString('userDetails').toString());
  log(registerPrefs.getString('teamID').toString());
  log(registerPrefs.getString('teamCaptain').toString());
  log(registerPrefs.getString('captainNumber').toString());
  log(registerPrefs.getString('teamName').toString());
  log(registerPrefs.getString('teamCount').toString());
  log(registerPrefs.getString('loginPIN').toString());
  log("==================");
}
