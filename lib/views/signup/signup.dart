import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/teamdashboard/teamdetails.dart';
import 'package:boxcricket/views/teamregistration/teamregistration.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../otp/otpscreen.dart';
import '../termsandconditions/termsandconditions.dart';

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
                  height: Constants.defaultPadding*2,
                ),
                const Text("Or",style: TextStyle(fontWeight: FontWeight.w500),),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: Constants.registrationTextFieldHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Constants.buttonRed,
                        borderRadius: const BorderRadius.all(Radius.circular(30))),
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
        print(responseBody);
        Constants.mobNum = responseBody["data"]['Mobile Number'].toString();
        if (responseBody['status'] == true && responseBody['data']['OTP'] != "") {
          if(responseBody['data']['isExist'] == false){
            Get.snackbar(
              'Alert',
              responseBody['message'],
              messageText: Text(
                responseBody['message'],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () async {
              Get.to(const OtpVerification(), arguments: responseBody);
            });
          }else{
            saveUserDetails(responseBody);
            if(responseBody['data']['teamCount']>0){
              Get.offAll(const TeamDetails());
            }else{
              Get.to(const TeamRegistration());
            }
          }
        } else {
          Get.snackbar('Alert', Constants.someThingWentWrong);
        }
      });
    });
  }
}

saveUserDetails(resposnse) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("userDetails", resposnse["data"]['user'].toString());
  prefs.setString("teamID", resposnse["data"]['user']['team_id'].toString());
  prefs.setString("teamName", resposnse["data"]['user']['team_name'].toString());
  prefs.setString("teamCaptain", resposnse["data"]['user']['team_captain'].toString());
  prefs.setString("mobNumber", resposnse["data"]['Mobile Number'].toString());
  print(prefs.getString('userDetails'));
  print(prefs.getString('teamID'));
  print(prefs.getString('mobNumber'));
}