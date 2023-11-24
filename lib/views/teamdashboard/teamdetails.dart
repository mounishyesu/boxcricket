import 'package:boxcricket/views/registrationsuccess/successpage.dart';
import 'package:boxcricket/views/teamregistration/teamregistration.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  List specializationList = [
    {
      "id": "1",
      "category": "Batsman",
      "players": [
        {"id": "1", "name": "mounishmounishmounish"},
        {"id": "2", "name": "bhanu murthy"},
        {"id": "3", "name": "pavan"},
        {"id": "4", "name": "ramu"},
      ]
    },
    {
      "id": "2",
      "category": "Wicket Keepers",
      "players": [
        {"id": "1", "name": "manoj"},
        {"id": "2", "name": "gosi"},
        {"id": "3", "name": "sagar"},
        {"id": "4", "name": "mounish4"},
      ]
    },
    {
      "id": "3",
      "category": "Bowlers",
      "players": [
        {"id": "1", "name": "chandhu"},
        {"id": "2", "name": "bahnu"},
        {"id": "3", "name": "mounish3"},
        {"id": "4", "name": "manohar"},
      ]
    },
    {
      "id": "4",
      "category": "All Rounders",
      "players": [
        {"id": "1", "name": "mounish1"},
        {"id": "2", "name": "mounish2"},
        {"id": "3", "name": "mounish3"},
        {"id": "4", "name": "mounish4"},
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.singinBgColor,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: Constants.loginBtnTextSize * 2,
              width: Constants.loginBtnTextSize * 2,
              decoration: BoxDecoration(
                  color: Constants.blackColor, shape: BoxShape.circle),
            ),
            SizedBox(
              width: Constants.defaultPadding,
            ),
            const Text("Seekol Team"),
          ],
        ),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize,
            color: Constants.blackColor,
            fontWeight: FontWeight.bold),
        // leading: Container(
        //   margin: const EdgeInsets.only(left: 15),
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.arrow_circle_left_sharp,
        //       size: Constants.backIconSize,
        //       color: Constants.backIconColor,
        //     ),
        //     onPressed: () => Get.back(),
        //   ),
        // ),
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
                  height: 80,
                  width: 80,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    left: 30,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.blueGrey),
                    color: Constants.singinBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    Constants.logoImage,
                    height: 50,
                    width: 50,
                  ),
                ),
                SizedBox(
                  width: Constants.labelSize,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Satish Ippili",
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
            playersList.isEmpty
                ? GestureDetector(
                    onTap: () => {
                      Get.to(const Congratulations()),
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                  )
                : Container(),
            SizedBox(
              height: Constants.labelSize,
            ),
            SafeArea(
              bottom: true,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: specializationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Constants.blackColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
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
                                specializationList[index]['category'],
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
                                  mainAxisSpacing: 1.0, // spacing between rows
                                  crossAxisSpacing:
                                      1.0, // spacing between columns
                                ),
                                // padding: EdgeInsets.all(8.0), // padding around the grid
                                itemCount: specializationList[index]['players']
                                    .length, // total number of items
                                itemBuilder: (context, playerIndex) {
                                  var playerName = specializationList[index]
                                      ['players'][playerIndex];
                                  return Row(
                                    children: [
                                      Image.asset(
                                        Constants.defaultUserImage,
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        width: Constants.labelSize,
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            '${playerName['name']}',
                                            style: TextStyle(
                                                color: Constants.blackColor,
                                                fontWeight: FontWeight.w500)),
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
            ),
          ],
        ),
      ),
    );
  }
}
