import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/views/apiservice/restapi.dart';
import 'package:boxcricket/views/termsandconditions/termsandconditions.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../otp/otpscreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const LoginScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const LoginScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                  child: Text(
                Constants.welcomeHeader,
                style: TextStyle(
                    color: Constants.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.welcomeTextSize),
              )),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Constants.blackColor,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.all(50),
                height: 200,
                width: 200,
                child: Text(
                  "Box Cricket",
                  style: TextStyle(
                      color: Constants.whiteColor,
                      fontSize: Constants.welcomeTextSize),
                ),
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
              GestureDetector(
                onTap: () => {
                  if (mobileNumberController.text.toString().isEmpty)
                    {
                      Get.snackbar("Alert", Constants.loginAlertMsg,
                          overlayBlur: 5,
                          titleText: Text(
                            'Alert',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.headerSize),
                          ),
                          messageText: Text(Constants.loginAlertMsg)),
                    }
                  else if (mobileNumberController.text.length < 10)
                    {
                      Get.snackbar("Alert", Constants.loginAlertMsg,
                          overlayBlur: 5,
                          titleText: Text(
                            'Alert',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constants.headerSize),
                          ),
                          messageText: Text(Constants.loginAlertMsg)),
                    }
                  else
                    {
                      sendOtpApiService(mobileNumberController.text.toString()),
                      // Get.to(const TermsAndConditions()),
                    }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: Constants.loginTextFieldHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Constants.buttonRed,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    Constants.newTeam,
                    style: TextStyle(
                        color: Constants.buttonTextColor,
                        fontSize: Constants.loginBtnTextSize),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {},
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Constants.buttonRed,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
    );
  }

  sendOtpApiService(mobNumber) async {
    var requestBody = jsonEncode({"mobile_number": mobNumber});
    await ApiService.otpPostCall("MobileOtp", requestBody).then((success) async {
      String data = success.body; //store response as string
      var responseBody = json.decode(data);
      print(responseBody);
      print(responseBody['status']);
      print(responseBody['data']['OTP']);
      print(responseBody['message']);
      if(responseBody['status'] == true && responseBody['data']['OTP']!=""){
        Get.snackbar('Alert', responseBody['message'],messageText:Text(responseBody['message'],style: const TextStyle(fontWeight: FontWeight.w500),), );
        Future.delayed(const Duration(seconds: 2), () async {
          Get.to(const OtpVerification(),arguments: responseBody);
        });
      }else{
        Get.snackbar('Alert',Constants.someThingWentWrong);
      }
    });
  }
}
