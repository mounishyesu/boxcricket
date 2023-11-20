import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/views/termsandconditions/termsandconditions.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apiservice/restapi.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const OtpScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const OtpScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  dynamic argumentData = Get.arguments;
  TextEditingController otpController = TextEditingController();
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(argumentData.toString());
    log('argumentData');
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.verificationHeader),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Constants.blackColor,
            fontSize: Constants.loginBtnTextSize),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Constants.backIconSize,
            color: Constants.backIconColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
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
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                SizedBox(
                  height: Constants.defaultPadding * 3,
                ),
                Text(
                  Constants.verificationHeader,
                  style: TextStyle(color: Constants.darkgrey),
                ),
                SizedBox(
                  height: Constants.defaultPadding,
                ),
                Text(
                  Constants.smsHeader,
                  style: TextStyle(
                      fontSize: Constants.loginBtnTextSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${Constants.onNumber} + 91${argumentData['data']['Mobile Number']}",
                  style: TextStyle(color: Constants.darkgrey),
                ),
                SizedBox(
                  height: Constants.defaultPadding * 2,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      fillColor: Constants.textFieldFilledColor,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Constants.textFieldFilledColor)),
                      hintText: Constants.otpHint,
                    ),
                  ),
                ),
                SizedBox(
                  height: Constants.defaultPadding * 3,
                ),
                GestureDetector(
                  onTap: () {
                    // log(argumentData.toString());
                    // log(otpController.text);
                    // log(argumentData['data']['OTP'].toString());
                    // if (otpController.text.isEmpty) {
                    //   Get.snackbar("Alert", Constants.otpAlertMsg,
                    //       overlayBlur: 5,
                    //       titleText: Text(
                    //         'Alert',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: Constants.headerSize),
                    //       ),
                    //       messageText: Text(Constants.otpAlertMsg),
                    //       backgroundColor: Constants.whiteColor);
                    // } else if (argumentData['data']['OTP'].toString() !=
                    //     otpController.text) {
                    //   Get.snackbar("Alert", Constants.invalidOtp,
                    //       overlayBlur: 5,
                    //       titleText: Text(
                    //         'Alert',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: Constants.headerSize),
                    //       ),
                    //       messageText: Text(Constants.invalidOtp),
                    //       backgroundColor: Constants.whiteColor);
                    // } else {
                    //   Get.defaultDialog(
                    //       title: Constants.successText,
                    //       middleText: Constants.otpVerified);
                    //   Future.delayed(const Duration(seconds: 2), () async {
                        Get.to(const TermsAndConditions());
                    //   });
                    // }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: Constants.loginTextFieldHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Constants.buttonRed,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      Constants.submitButton,
                      style: TextStyle(
                          color: Constants.buttonTextColor,
                          fontSize: Constants.loginBtnTextSize),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Constants.reqOTP} $secondsRemaining ${Constants.seconds}',
                        style: TextStyle(color: Constants.darkgrey,fontSize: Constants.textSize),
                      ),
                      GestureDetector(
                        onTap: (){
                          log('pressed');
                          log(enableResend.toString());
                          enableResend ? _resendCode() : null;
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            Constants.resendCode,
                            style: TextStyle(
                                color: enableResend?Constants.blueColor:Constants.disablecolor,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
      sendOtpApiService(argumentData['data']['Mobile Number'].toString());
    });
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
      }else{
        Get.snackbar('Alert',Constants.someThingWentWrong);
      }
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }
}
