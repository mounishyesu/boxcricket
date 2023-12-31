import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/registrationsuccess/successpage.dart';
import 'package:boxcricket/views/teamdashboard/teamdetails.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  final _formKey = GlobalKey<FormState>();
  String specializationDropdownValue = "";
  String jerseyDropdownValue = "";
  String shirtSizeDropdownValue = "";
  String teamName = "Loading...";
  String teamID = "";
  var specializationList = [];
  var jerseyList = [
    {"id": "1", "number": "36"},
    {"id": "2", "number": "197"},
    {"id": "3", "number": "108"},
    {"id": "4", "number": "111"},
  ];
  var shirtSizeList = [];
  Timer? _timer;

  List names = [], paths = [], baseImg = [];
  File? image, selectedImage;
  TextEditingController playerNameController = TextEditingController();
  TextEditingController playerMobNumController = TextEditingController();
  TextEditingController playerAgeController = TextEditingController();
  TextEditingController playerAadharController = TextEditingController();
  TextEditingController playerjerseyNumController = TextEditingController();

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
        automaticallyImplyLeading: false,
        title: Text(Constants.teamregistrationHeader),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize, color: Constants.blackColor),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_circle_left_sharp,
        //     size: Constants.backIconSize,
        //     color: Constants.backIconColor,
        //   ),
        //   onPressed: () => Get.offAll(() => const TeamDetails()),
        // ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    child: Text(
                      teamName.toString(),
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
                    // height: Constants.registrationTextFieldHeight,
                    child: TextFormField(
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
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter player name';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select player specialization';
                        }
                        return null;
                      },
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
                            item['name'].toString(),
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
                            child: TextFormField(
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter player mobile number';
                                }
                                return null;
                              },
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
                            child: TextFormField(
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter age';
                                }
                                return null;
                              },
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
                    child: TextFormField(
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
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter player aadhar number';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select player T shirt size';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        setState(() {
                          shirtSizeDropdownValue = newValue.toString();
                          log(shirtSizeDropdownValue);
                        });
                      },
                      items: shirtSizeList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item['shirt_id'],
                          child: Text(
                            item['shirt_name'].toString(),
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
                    child: TextFormField(
                      controller: playerjerseyNumController,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter player jersey';
                        }
                        return null;
                      },
                      onChanged: (value) => {
                        if (value.length > 3)
                          {
                            Get.defaultDialog(
                              title: "Alert",
                              middleText:
                                  "Jersey Number can contain only 3 numbers",
                            ),
                            playerjerseyNumController.clear(),
                          }
                      },
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
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => {
          if (_formKey.currentState!.validate())
            {
              if (names.isEmpty)
                {
                  Get.snackbar(
                    "Alert",
                    Constants.profileAlertMsg,
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
                      Constants.profileAlertMsg,
                      style: TextStyle(
                          fontSize: Constants.textSize,
                          fontWeight: FontWeight.bold,
                          color: Constants.whiteColor),
                    ),
                  ),
                }
              else
                {
                  log('Pressed Continue'),
                  log(shirtSizeDropdownValue),
                  makePlayerAddApiCall(),
                }
            }
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
      teamID = registerPrefs.getString('teamID').toString();
    });
    getShirtSizes();
  }

  getShirtSizes() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    await ApiService.get("Users/getShirtSizes").then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          log(responseBody.toString());
          shirtSizeList = responseBody['Data'];
          getSpecialization();
        });
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }

  getSpecialization() async {
    await ApiService.get("Users/getPlayerRoles").then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          log(responseBody.toString());
          specializationList = responseBody['Data'];
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }

  makePlayerAddApiCall() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Saving . . .",
    );
    log(playerNameController.text.toString());
    log(
      specializationDropdownValue.toString(),
    );
    log(playerMobNumController.text.toString());
    log(
      playerAgeController.text.toString(),
    );
    log(
      playerAadharController.text.toString(),
    );
    log(
      shirtSizeDropdownValue.toString(),
    );
    log(
      playerjerseyNumController.text.toString(),
    );
    log(paths[0].toString());
    await ApiService.playerRegisterForm(
            "Users/teamPlayerAdd",
            teamID.toString(),
            playerNameController.text.toString(),
            specializationDropdownValue.toString(),
            playerMobNumController.text.toString(),
            playerAgeController.text.toString(),
            playerAadharController.text.toString(),
            shirtSizeDropdownValue.toString(),
            playerjerseyNumController.text.toString(),
            paths[0].toString())
        .then((success) {
      var responseBody = json.decode(success);
      print(responseBody);
      if (responseBody['status'] == true) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          if (responseBody['status'] == true) {
            saveteamDetails(responseBody);
            Get.snackbar("Success", responseBody['message'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.green,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize,
                      color: Constants.whiteColor),
                ),
                messageText: Text(
                  responseBody['message'].toString(),
                  style: TextStyle(
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ));
            if (responseBody['teamCount'].toString() == '15') {
              Get.offAll(() => const Congratulations());
            } else {
              Get.offAll(() => const TeamDetails());
            }
          }
        });
        EasyLoading.showSuccess(responseBody['message'].toString());
      } else {
        var errorList = responseBody['errors'];
        if (errorList['team_id'] != null) {
          Get.snackbar("Alert", errorList['team_id'].toString(),
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
                errorList['team_id'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        else if (errorList['player_name'] != null) {
          Get.snackbar("Alert", errorList['player_name'].toString(),
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
                errorList['player_name'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        else if (errorList['player_specialization'] != null) {
          Get.snackbar("Alert", errorList['player_specialization'].toString(),
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
                errorList['player_specialization'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        else if (errorList['player_mobile'] != null) {
          Get.snackbar("Alert", errorList['player_mobile'].toString(),
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
                errorList['player_mobile'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        else if (errorList['player_age'] != null) {
          Get.snackbar("Alert", errorList['player_age'].toString(),
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
                errorList['player_age'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        else if (errorList['player_aadhar'] != null) {
          Get.snackbar("Alert", errorList['player_aadhar'].toString(),
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
                errorList['player_aadhar'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        else if (errorList['player_shirt_size'] != null) {
          Get.snackbar("Alert", errorList['player_shirt_size'].toString(),
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
                errorList['player_shirt_size'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        else if (errorList['player_shirt_size'] != null) {
          Get.snackbar("Alert", errorList['player_shirt_size'].toString(),
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
                errorList['player_shirt_size'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        else if (errorList['player_jersey'] != null) {
          Get.snackbar("Alert", errorList['player_jersey'].toString(),
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
                errorList['player_jersey'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.textSize,
                    color: Constants.whiteColor),
              ));
        }
        EasyLoading.showInfo("Player Adding Failed");
      }
    });
  }
}

saveteamDetails(resposnse) async {
  SharedPreferences registerPrefs = await SharedPreferences.getInstance();

  registerPrefs.setString("teamCount", resposnse['teamCount'].toString());

  log("==================");
  log(resposnse.toString());
  log(registerPrefs.getString('teamCount').toString());
  log("==================");
}
