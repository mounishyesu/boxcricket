import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/home/homepage.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                    Get.to(()=>const Home()),
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
    var requestBody = jsonEncode({"mobile_number": mobNumber});
    await ApiService.otpPostCall("Users/MobileOtp", requestBody)
        .then((success) async {
      setState(() {
        String data = success.body; //store response as string
        var responseBody = json.decode(data);
        log(responseBody.toString());
        if (responseBody['status'] == true &&
            responseBody['data']['OTP'] != "") {
          Get.snackbar(
            'Alert',
            responseBody['message'],
            titleText: Text(
              'Alert',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Constants.headerSize,
                  color: Constants.whiteColor),
            ),
            backgroundColor: Constants.green,
            overlayBlur: 5,
            messageText: Text(
              responseBody['message'],
              style: TextStyle(
                  fontSize: Constants.textSize,
                  fontWeight: FontWeight.bold,
                  color: Constants.whiteColor),
            ),
          );
          Future.delayed(const Duration(seconds: 2), () async {
            Get.to(const OtpVerification(), arguments: responseBody);
          });
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
    });
  }
}

