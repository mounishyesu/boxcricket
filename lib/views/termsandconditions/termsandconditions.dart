import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/pinsetup/fanpinsetup.dart';
import 'package:boxcricket/views/registration/registrationform.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const TermsAndConditionsScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const TermsAndConditionsScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  dynamic argumentData = Get.arguments;
  Timer? _timer;
  List tncData = [];
  bool checkedValue = false;
  String userRole="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTnCapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Constants.bgImage),
                    fit: BoxFit.contain,
                    opacity: 0.2)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Center(
                      child: Text(
                    Constants.termsAndConditions,
                    style: TextStyle(
                        color: Constants.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.welcomeTextSize),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.43,
                    child: SafeArea(
                      bottom: true,
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tncData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    left: Constants.labelSize * 3,
                                    top: Constants.defaultPadding),
                                child: Text(
                                  tncData[index]['question'].toString(),
                                  style: TextStyle(
                                      color: Constants.blackColor,
                                      fontSize: Constants.headerSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    left: Constants.labelSize * 3,
                                    top: Constants.defaultPadding),
                                child: Text(
                                  tncData[index]['answer'].toString(),
                                  style: TextStyle(
                                      color: Constants.blackColor,
                                      fontSize: Constants.subHeaderSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Constants.labelSize * 3),
                    child: CheckboxListTile(
                      title: Text(
                        Constants.acceptTnC,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Constants.blueColor),
                      ),
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue!;
                        });
                        log(newValue.toString());
                        log(checkedValue.toString());
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),
                  Visibility(
                    visible: userRole == "TEAM"?true:false,
                    child: GestureDetector(
                      onTap: () => {
                        log(argumentData.toString()),
                        if (checkedValue == true)
                          {
                            Get.to(() => const RegistrationForm(),
                                arguments: argumentData),
                          }
                        else
                          {
                            Get.snackbar("Alert", Constants.tncAlertMsg,
                                backgroundColor: Constants.buttonRed,
                                overlayBlur: 5,
                                titleText: Text(
                                  'Alert',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constants.headerSize,
                                      color: Constants.whiteColor),
                                ),
                                messageText: Text(
                                  Constants.tncAlertMsg,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constants.textSize,
                                      color: Constants.whiteColor),
                                )),
                          }
                      },
                      child: Container(
                        // margin: const EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 60,
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
                  ),
                  SizedBox(
                    height: Constants.labelSize,
                  ),
                  // const Text(
                  //   "Or",
                  //   style: TextStyle(fontWeight: FontWeight.w500),
                  // ),
                  Visibility(
                    visible: userRole == "TEAM"?false:true,
                    child: GestureDetector(
                      onTap: () => {
                        if (checkedValue == true)
                          {
                            Get.to(()=>const FanSetPin()),
                          }
                        else
                          {
                            Get.snackbar("Alert", Constants.tncAlertMsg,
                                backgroundColor: Constants.buttonRed,
                                overlayBlur: 5,
                                titleText: Text(
                                  'Alert',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constants.headerSize,
                                      color: Constants.whiteColor),
                                ),
                                messageText: Text(
                                  Constants.tncAlertMsg,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constants.textSize,
                                      color: Constants.whiteColor),
                                )),
                          }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Constants.buttonRed,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          Constants.cricketFan,
                          style: TextStyle(
                              color: Constants.buttonTextColor,
                              fontSize: Constants.loginBtnTextSize),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Constants.defaultPadding,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getTnCapi() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    userRole = registerPrefs.getString('userRole').toString();
    log('----userRole-----------');
    log(userRole.toString());
    log('---------------');
    await ApiService.get("Users/getTermsConditions").then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          tncData = responseBody['Data'];
          log('---------------');
          log(responseBody.toString());
          log(tncData.toString());
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }
}
