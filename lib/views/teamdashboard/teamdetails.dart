import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:basic_utils/basic_utils.dart';
import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/home/homepage.dart';
import 'package:boxcricket/views/registrationsuccess/successpage.dart';
import 'package:boxcricket/views/teamregistration/teamregistration.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamDetails extends StatefulWidget {
  const TeamDetails({super.key});

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const TeamDetailScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const TeamDetailScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeamDetailScreen extends StatefulWidget {
  const TeamDetailScreen({super.key});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  List playersList = [];
  Timer? _timer;
  String teamName = "", capName = "", teamCount = "", capImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.singinBgColor,
      appBar: AppBar(
        title: Text(teamName.toString()),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize,
            color: Constants.blackColor,
            fontWeight: FontWeight.bold),
        leading: Container(
          margin: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: Icon(
              Icons.arrow_circle_left_sharp,
              size: Constants.backIconSize,
              color: Constants.backIconColor,
            ),
            onPressed: () => Get.offAll(() => const Home()),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Constants.labelSize * 2,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    left: 30,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.blueGrey),
                    color: Constants.singinBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      capImage.toString(),
                    ),
                    radius: 30,
                  ),
                ),
                SizedBox(
                  width: Constants.labelSize,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capName.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Constants.loginBtnTextSize),
                    ),
                    Text(
                      "CAPTAIN",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Constants.headerSize),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: Constants.labelSize,
            ),
            Visibility(
              visible: teamCount.toString() == '15' ? false : true,
              child: GestureDetector(
                onTap: () => {
                  Get.to(const TeamRegistration()),
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.center,
                  height: Constants.registrationTextFieldHeight,
                  decoration: BoxDecoration(
                      color: Constants.blackColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    Constants.addPlayerButton,
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
            playersList.isEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.3),
                    child: Text(
                      'No Players Found',
                      style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: Constants.headerSize,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : SafeArea(
                    bottom: true,
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: playersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Constants.blackColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  decoration: BoxDecoration(
                                      color: Constants.buttonRed,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20))),
                                  padding: const EdgeInsets.only(
                                      left: 30, top: 10, bottom: 10),
                                  child: Text(
                                    playersList[index]['role_name'],
                                    style: TextStyle(
                                        color: Constants.whiteColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(20),
                                  child: GridView.builder(
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2.5,
                                      crossAxisCount:
                                          2, // number of items in each row
                                      mainAxisSpacing:
                                          1.0, // spacing between rows
                                      crossAxisSpacing:
                                          1.0, // spacing between columns
                                    ),
                                    // padding: EdgeInsets.all(8.0), // padding around the grid
                                    itemCount: playersList[index]['players']
                                        .length, // total number of items
                                    itemBuilder: (context, playerIndex) {
                                      var playerName = playersList[index]
                                          ['players'][playerIndex];
                                      return Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              '${playerName['profile_image_url']}',
                                            ),
                                            radius: 25,
                                          ),
                                          SizedBox(
                                            width: Constants.labelSize,
                                          ),
                                          SizedBox(
                                            width: 80,
                                            child: Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                '${playerName['player_name']}',
                                                style: TextStyle(
                                                    color: Constants.blackColor,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  getPlayersData() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    log(registerPrefs.getString('captainNumber').toString());
    var teamID = registerPrefs.getString('teamID').toString();
    capName = StringUtils.capitalize(
        registerPrefs.getString('teamCaptain').toString());
    teamCount = registerPrefs.getString('teamCount').toString();
    capImage = registerPrefs.getString('capProfilePic').toString();
    var encodeBody = jsonEncode({"team_id": teamID.toString()});
    log(encodeBody);
    log('-----------------------');
    log(capName.toString());
    log(teamCount.toString());
    log(capImage.toString());
    log('-----------------------');
    await ApiService.post("Users/getPlayersByTeamId", encodeBody)
        .then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          log(responseBody.toString());
          log(responseBody.toString());
          playersList = responseBody['team_players'];
          log(playersList.length.toString());
          teamName = StringUtils.capitalize(
              registerPrefs.getString('teamName').toString());
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }
}
