import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boxcricket/views/matchschedule/matchschedule.dart';
import 'package:boxcricket/views/pinsetup/setpin.dart';
import 'package:boxcricket/views/teamdashboard/teamdetails.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamRegistration extends StatefulWidget {
  const TeamRegistration({super.key});

  @override
  State<TeamRegistration> createState() => _TeamRegistrationState();
}

class _TeamRegistrationState extends State<TeamRegistration> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const TeamRegistrationScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const TeamRegistrationScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeamRegistrationScreen extends StatefulWidget {
  const TeamRegistrationScreen({super.key});

  @override
  State<TeamRegistrationScreen> createState() => _TeamRegistrationScreenState();
}

class _TeamRegistrationScreenState extends State<TeamRegistrationScreen> {
  String specializationDropdownValue = "";
  String jerseyDropdownValue = "";
  String shirtSizeDropdownValue = "";
  String teamName = "Loading...";
  var specializationList = [
    {"id": "1", "category": "Batsman"},
    {"id": "2", "category": "Wicket Keepers"},
    {"id": "3", "category": "Bowlers"},
    {"id": "4", "category": "All Rounders"},
  ];
  var jerseyList = [
    {"id": "1", "number": "36"},
    {"id": "2", "number": "197"},
    {"id": "3", "number": "108"},
    {"id": "4", "number": "111"},
  ];
  var shirtSizeList = [
    {"id": "1", "category": "M - Medium(38)"},
    {"id": "2", "category": "L - Large(40)"},
    {"id": "3", "category": "XL - Extra Large(42)"},
    {"id": "4", "category": "XXL - Double Extra Large(44)"},
  ];
  List names = [], paths = [], baseImg = [];
  File? image, selectedImage;
  TextEditingController playerNameController = TextEditingController();
  TextEditingController playerMobNumController = TextEditingController();
  TextEditingController playerAgeController = TextEditingController();
  TextEditingController playerAadharController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTeamName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.teamregistrationHeader),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize, color: Constants.blackColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Constants.backIconSize,
            color: Constants.backIconColor,
          ),
          onPressed: () => Get.offAll(const TeamDetails()),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      color: Constants.blueColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Text(teamName.toString(),
                    style: TextStyle(
                        fontSize: Constants.loginBtnTextSize,
                        color: Constants.whiteColor),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "You can add only 11 - 15 Team Players Only",
                      style: TextStyle(fontSize: Constants.headerSize),
                    )),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Text(
                  Constants.playerName,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: Constants.registrationTextFieldHeight,
                  child: TextField(
                    controller: playerNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    ),
                    onChanged: (value) => {},
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Text(
                  Constants.specialization,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  // height: ,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      // hintText: Constants.specializationHintText,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        specializationDropdownValue = newValue.toString();
                        log(specializationDropdownValue);
                      });
                    },
                    items: specializationList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'],
                        child: Text(
                          item['category'].toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.playerMobNum,
                          style: TextStyle(fontSize: Constants.headerSize),
                        ),
                        SizedBox(
                          height: Constants.gapBetweenFields,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          height: Constants.registrationTextFieldHeight,
                          child: TextField(
                            controller: playerMobNumController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Constants.textFieldFilledColor,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              contentPadding:
                                  const EdgeInsets.only(top: 10, left: 10),
                            ),
                            onChanged: (value) => {
                              if (value.length > 10)
                                {
                                  Get.defaultDialog(
                                    title: "Alert",
                                    middleText: "Enter Valid Mobile Number",
                                  ),
                                  playerMobNumController.clear(),
                                }
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.captainAge,
                          style: TextStyle(fontSize: Constants.headerSize),
                        ),
                        SizedBox(
                          height: Constants.gapBetweenFields,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          height: Constants.registrationTextFieldHeight,
                          child: TextField(
                            controller: playerAgeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Constants.textFieldFilledColor,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              contentPadding:
                                  const EdgeInsets.only(top: 10, left: 10),
                            ),
                            onChanged: (value) => {
                              if (value.length > 2)
                                {
                                  Get.defaultDialog(
                                    title: "Alert",
                                    middleText: "Enter Valid Age",
                                  ),
                                  playerAgeController.clear(),
                                }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Text(
                  Constants.playerAadhar,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: Constants.registrationTextFieldHeight,
                  child: TextField(
                    controller: playerAadharController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    ),
                    onChanged: (value) => {
                      log(value.length.toString()),
                      if (value.length > 12)
                        {
                          Get.defaultDialog(
                              title: "Alert",
                              middleText: "Enter Valid Aadhar Number"),
                          playerAadharController.clear(),
                        }
                    },
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Text(
                  Constants.tshirtSize,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  // height: ,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        shirtSizeDropdownValue = newValue.toString();
                        log(shirtSizeDropdownValue);
                      });
                    },
                    items: shirtSizeList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'],
                        child: Text(
                          item['category'].toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Text(
                  Constants.jerseyNumber,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  // height: ,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        jerseyDropdownValue = newValue.toString();
                        log(jerseyDropdownValue);
                      });
                    },
                    items: jerseyList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'],
                        child: Text(
                          item['number'].toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        Constants.profilePic,
                        style: TextStyle(fontSize: Constants.subHeaderSize),
                      ),
                      SizedBox(
                        height: Constants.gapBetweenFields,
                      ),
                      GestureDetector(
                        onTap: () => imageDialog(),
                        child: names.isEmpty
                            ? DottedBorder(
                                child: IconButton(
                                  onPressed: () => imageDialog(),
                                  icon: Constants.cameraIcon,
                                  iconSize: 30,
                                ),
                              )
                            : Image.file(
                                File(paths[0]),
                                height: 150,
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => {
          // if(playerNameController.text.isEmpty){
          //   Get.snackbar("Alert", Constants.registrationPlayerNameAlertMsg,
          //       overlayBlur: 5,
          //       backgroundColor: Constants.whiteColor,
          //       titleText: Text(
          //         'Alert',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: Constants.headerSize),
          //       ),
          //       messageText: Text(Constants.registrationPlayerNameAlertMsg)),
          // } else if (specializationDropdownValue.isEmpty)
          //   {
          //     Get.snackbar("Alert", Constants.specializationAlertMsg,
          //         overlayBlur: 5,
          //         backgroundColor: Constants.whiteColor,
          //         titleText: Text(
          //           'Alert',
          //           style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: Constants.headerSize),
          //         ),
          //         messageText: Text(Constants.specializationAlertMsg)),
          //   } else if (playerMobNumController.text.isEmpty ||
          //       playerMobNumController.text.length < 10)
          //     {
          //       Get.snackbar("Alert", Constants.loginAlertMsg,
          //           overlayBlur: 5,
          //           backgroundColor: Constants.whiteColor,
          //           titleText: Text(
          //             'Alert',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: Constants.headerSize),
          //           ),
          //           messageText: Text(Constants.loginAlertMsg)),
          //     }else if (playerAgeController.text.isEmpty || playerAgeController.text.length < 2)
          //       {
          //         Get.snackbar("Alert", Constants.ageAlertMsg,
          //             overlayBlur: 5,
          //             backgroundColor: Constants.whiteColor,
          //             titleText: Text(
          //               'Alert',
          //               style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: Constants.headerSize),
          //             ),
          //             messageText: Text(Constants.ageAlertMsg)),
          //       }else if (playerAadharController.text.isEmpty ||
          //           playerAadharController.text.length < 12)
          //         {
          //           Get.snackbar("Alert", Constants.aadharAlertMsg,
          //               overlayBlur: 5,
          //               backgroundColor: Constants.whiteColor,
          //               titleText: Text(
          //                 'Alert',
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: Constants.headerSize),
          //               ),
          //               messageText: Text(Constants.aadharAlertMsg)),
          //         }else if (shirtSizeDropdownValue.isEmpty)
          //           {
          //             Get.snackbar("Alert", Constants.shirtAlertMsg,
          //                 overlayBlur: 5,
          //                 backgroundColor: Constants.whiteColor,
          //                 titleText: Text(
          //                   'Alert',
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: Constants.headerSize),
          //                 ),
          //                 messageText: Text(Constants.shirtAlertMsg)),
          //           }else if (jerseyDropdownValue.isEmpty)
          //           {
          //             Get.snackbar("Alert", Constants.jerseyAlertMsg,
          //                 overlayBlur: 5,
          //                 backgroundColor: Constants.whiteColor,
          //                 titleText: Text(
          //                   'Alert',
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: Constants.headerSize),
          //                 ),
          //                 messageText: Text(Constants.jerseyAlertMsg)),
          //           }else{
          //   log('Pressed Continue'),
          //   log(shirtSizeDropdownValue),
          Get.to(const MatchSchedule()),
          // }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          height: Constants.registrationTextFieldHeight,
          decoration: BoxDecoration(
              color: Constants.buttonRed,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Text(
            Constants.saveButton,
            style: TextStyle(
                color: Constants.buttonTextColor,
                fontSize: Constants.loginBtnTextSize),
          ),
        ),
      ),
    );
  }

  imageDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Add Photo!",
        ),
        content: SizedBox(
          height: 130,
          width: 50,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              GestureDetector(
                  child: Card(
                    color: Constants.darkgrey,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Take Photo",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () async {
                    takePhoto(ImageSource.camera);
                    Get.back();
                  }),
              GestureDetector(
                child: Card(
                  color: Constants.darkgrey,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Choose From Gallery",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  takePhoto(ImageSource.gallery);
                  Get.back();
                },
              ),
              GestureDetector(
                child: Card(
                  color: Constants.buttonRed,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  takePhoto(ImageSource source) async {
    names = [];
    paths = [];
    baseImg = [];

    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    final File file = File(image!.path);

    log(image.toString());
    log(file.toString());

    try {
      if (image != null) {
        setState(() {
          selectedImage = file;
          String fileName = image.path.toString().split('/').last;
          List<int> imageBytes = selectedImage!.readAsBytesSync();
          var imageB64 = base64Encode(imageBytes);
          baseImg.add(imageB64);
          names.add(fileName);
          paths.add(image.path.toString());
          log('-----image details----');
          log(imageBytes.toString());
          log(imageB64.toString());
          log(imageB64.toString());
          log(baseImg.toString());
          log(names.toString());
          log(paths.toString());
        });
      }
    } catch (e) {
      return e;
    }
  }

  setTeamName() async {
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    log(registerPrefs.getString('teamName').toString());
    setState(() {
      teamName = registerPrefs.getString('teamName').toString();
    });
  }

}
