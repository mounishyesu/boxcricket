import 'dart:developer';

import 'package:boxcricket/views/registration/registrationform.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  bool checkedValue = false;
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
                    image: AssetImage(Constants.bgImage), fit: BoxFit.cover)),
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
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: Constants.labelSize * 3,top: Constants.defaultPadding),
                  child: Text(
                    "Me Team Lo Motham 11 Nunchi 15 Aatagaallu Thappanisari Undali"
                    "\nMe team Thappakunda Srikakulam Lo Edho Oka Mandalam Ki Sambandhinchi Aatagaallu Matramey Undali"
                    "\nMe Team Yokka Captain Poorthi Samacharam Kavali"
                    "\nMe Team Lo Unna Prathi Aatagaadu Aadhar Number Kachithanga Undali",
                    style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: Constants.headerSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Constants.labelSize*3),
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
                GestureDetector(
                  onTap: () => {
                  log(argumentData.toString()),
                    if (checkedValue == true)
                      {
                        Get.to(()=>const RegistrationForm(),arguments: argumentData),
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
                            messageText: Text(Constants.tncAlertMsg,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.textSize,
                                  color: Constants.whiteColor),)),
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
                SizedBox(
                  height: Constants.labelSize,
                ),
                const Text(
                  "Or",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () => {},
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
                SizedBox(
                  height: Constants.defaultPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
