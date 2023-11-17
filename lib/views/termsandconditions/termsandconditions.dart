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
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                  child: Text(Constants.termsAndConditions,
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
                child: Text("Box Cricket",style: TextStyle(color: Constants.whiteColor,fontSize: Constants.welcomeTextSize),),
              ),
              GestureDetector(
                onTap: () => Get.to(const RegistrationForm()),
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Constants.buttonRed,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                  child: Text(Constants.newTeam,
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
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Text(Constants.cricketFan,
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
}