import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';

class ScoreCard extends StatefulWidget {
  const ScoreCard({super.key});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const ScoreCardPage(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const ScoreCardPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreCardPage extends StatefulWidget {
  const ScoreCardPage({super.key});

  @override
  State<ScoreCardPage> createState() => _ScoreCardPageState();
}

class _ScoreCardPageState extends State<ScoreCardPage> {
  dynamic argumentData = Get.arguments;
  Timer? _timer;
  List matchScores = [];
  List teamOneMatchBatting = [];
  List teamOneMatchBowling = [];
  List teamTwoMatchBatting = [];
  List teamTwoMatchBowling = [];
  String teamOneProfile = "",
      teamTwoProfile = "",
      teamOneName = "",
      teamTwoName = "",
      teamOneMandal = "",
      teamTwoMandal = "",
      teamOneTeamId = "",
      teamTwoTeamId = "",
      teamOneScore = "",
      teamTwoScore = "",
      teamOneWickets = "",
      teamTwoWickets = "",
      dateOfMatch = "",
      placeOfMatch = "",
      tossWinHeader = "";
  @override
  void initState() {
    // initialize controller
    super.initState();
    log("------------argumentData------------");
    log(argumentData.toString());
    getScoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.matchScoreCard),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize, color: Constants.blackColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Constants.backIconSize,
            color: Constants.backIconColor,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              tooltip: 'Refresh',
              icon: Icon(
                Icons.sync,
                size: Constants.backIconSize,
                color: Constants.backIconColor,
              ),
              onPressed: () => getScoreData(),
            ),
          ),
        ],
      ),
      backgroundColor: Constants.singinBgColor,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            tossWinHeader.toString().isEmpty
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      tossWinHeader.toString(),
                      style: TextStyle(
                          color: Constants.buttonRed,
                          fontWeight: FontWeight.bold,),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ExpandedTile(
                trailing: Icon(
                  Icons.keyboard_double_arrow_right,
                  size: 30,
                  color: Constants.whiteColor,
                ),
                theme: ExpandedTileThemeData(
                  headerColor: Constants.buttonRed,
                  headerRadius: 20.0,
                  headerSplashColor: Constants.buttonRed,
                ),
                controller: ExpandedTileController(isExpanded: true),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Constants.blueGrey),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              teamOneProfile.toString(),
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
                              teamOneName.toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: Constants.subHeaderSize,
                                  color: Constants.whiteColor),
                            ),
                            Text(
                              teamOneMandal.toString(),
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: Constants.labelSize),
                            ),
                            Text("SPL00${teamOneTeamId.toString()}",
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: Constants.labelSize),
                            ),
                            Text(
                              dateOfMatch.toString(),
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: Constants.labelSize),
                            ),
                            Text(
                              placeOfMatch.toString(),
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: Constants.labelSize),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        "${teamOneScore.toString()} /${teamOneWickets.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.textSize),
                      ),
                    ),
                  ],
                ),
                content: Column(
                  children: [
                    ExpandedTile(
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 30,
                        color: Constants.whiteColor,
                      ),
                      theme: ExpandedTileThemeData(
                        headerColor: Constants.darkgrey,
                        headerRadius: 20.0,
                        headerSplashColor: Constants.darkgrey,
                      ),
                      controller: ExpandedTileController(isExpanded: true),
                      title: Text(
                        'Batting Records',
                        style: TextStyle(
                            color: Constants.whiteColor,
                            fontSize: Constants.subHeaderSize),
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: teamOneMatchBatting.length > 5
                            ? MediaQuery.of(context).size.height * 1.12
                            : MediaQuery.of(context).size.height * 0.35,
                        child: DataTable2(
                            headingTextStyle: TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.w400),
                            headingRowHeight: 30,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Constants.buttonRed),
                            columnSpacing: 0,
                            dataRowHeight: 50,
                            columns: [
                              DataColumn2(
                                fixedWidth:
                                    MediaQuery.of(context).size.width * 0.28,
                                label: const Text(
                                  'PLAYER',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                fixedWidth:
                                    MediaQuery.of(context).size.width * 0.18,
                                label: const Text('R(B)'),
                              ),
                              DataColumn2(
                                fixedWidth:
                                    MediaQuery.of(context).size.width * 0.1,
                                label: const Text('4s'),
                              ),
                              const DataColumn2(
                                label: Text('6s'),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                                teamOneMatchBatting.length,
                                (index) => DataRow(cells: [
                                      DataCell(SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                teamOneMatchBatting[index]
                                                        ['player']
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Constants.blackColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text(
                                                "(${teamOneMatchBatting[index]['status'].toString()})",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Constants.darkgrey,
                                                    fontSize: 12,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      )),
                                      DataCell(Text(
                                          "${teamOneMatchBatting[index]['runs'].toString()}(${teamOneMatchBatting[index]['balls'].toString()})",
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: Constants.textSize,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamOneMatchBatting[index]['fours']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamOneMatchBatting[index]['sixs']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                    ]))),
                      ),
                      onTap: () {
                        debugPrint("tapped!!");
                      },
                      onLongTap: () {
                        debugPrint("long tapped!!");
                      },
                    ),
                    ExpandedTile(
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 30,
                        color: Constants.whiteColor,
                      ),
                      theme: ExpandedTileThemeData(
                        headerColor: Constants.darkgrey,
                        headerRadius: 20.0,
                        headerSplashColor: Constants.darkgrey,
                      ),
                      controller: ExpandedTileController(isExpanded: true),
                      title: Text(
                        'Bowling Records',
                        style: TextStyle(
                            color: Constants.whiteColor,
                            fontSize: Constants.subHeaderSize),
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: teamOneMatchBowling.length > 5
                            ? MediaQuery.of(context).size.height * 1.12
                            : MediaQuery.of(context).size.height * 0.35,
                        child: DataTable2(
                            headingTextStyle: TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.w400),
                            headingRowHeight: 30,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Constants.buttonRed),
                            columnSpacing: 0,
                            dataRowHeight: 50,
                            columns: [
                              DataColumn2(
                                fixedWidth:
                                    MediaQuery.of(context).size.width * 0.35,
                                label: const Text('PLAYER'),
                                size: ColumnSize.L,
                              ),
                              const DataColumn2(
                                label: Text('O'),
                              ),
                              const DataColumn2(
                                label: Text('M'),
                              ),
                              const DataColumn2(
                                label: Text('R'),
                              ),
                              const DataColumn2(
                                label: Text('W'),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                                teamOneMatchBowling.length,
                                (index) => DataRow(cells: [
                                      DataCell(SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Text(
                                            teamOneMatchBowling[index]['player']
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Constants.blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      )),
                                      DataCell(Text(
                                          teamOneMatchBowling[index]['overs']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamOneMatchBowling[index]['maiden']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamOneMatchBowling[index]['runs']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamOneMatchBowling[index]['wickets']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                    ]))),
                      ),
                      onTap: () {
                        debugPrint("tapped!!");
                      },
                      onLongTap: () {
                        debugPrint("long tapped!!");
                      },
                    ),
                  ],
                ),
                onTap: () {
                  debugPrint("tapped!!");
                },
                onLongTap: () {
                  debugPrint("long tapped!!");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ExpandedTile(
                trailing: Icon(
                  Icons.keyboard_double_arrow_right,
                  size: 30,
                  color: Constants.whiteColor,
                ),
                theme: ExpandedTileThemeData(
                  headerColor: Constants.buttonRed,
                  headerRadius: 20.0,
                  headerSplashColor: Constants.buttonRed,
                ),
                controller: ExpandedTileController(isExpanded: false),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Constants.blueGrey),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              teamTwoProfile.toString(),
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
                              teamTwoName.toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: Constants.subHeaderSize,
                                  color: Constants.whiteColor),
                            ),
                            Text(
                              teamTwoMandal.toString(),
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: Constants.labelSize),
                            ),
                            Text("SPL00${teamTwoTeamId.toString()}",
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: Constants.labelSize),
                            ),
                            Text(
                              dateOfMatch.toString(),
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: Constants.labelSize),
                            ),
                            Text(
                              placeOfMatch.toString(),
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontSize: Constants.labelSize),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        "${teamTwoScore.toString()} /${teamTwoWickets.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.textSize),
                      ),
                    ),
                  ],
                ),
                content: Column(
                  children: [
                    ExpandedTile(
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 30,
                        color: Constants.whiteColor,
                      ),
                      theme: ExpandedTileThemeData(
                        headerColor: Constants.darkgrey,
                        headerRadius: 20.0,
                        headerSplashColor: Constants.darkgrey,
                      ),
                      controller: ExpandedTileController(isExpanded: false),
                      title: Text(
                        'Batting Records',
                        style: TextStyle(
                            color: Constants.whiteColor,
                            fontSize: Constants.subHeaderSize),
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: teamTwoMatchBatting.length > 5
                            ? MediaQuery.of(context).size.height * 1.12
                            : MediaQuery.of(context).size.height * 0.35,
                        child: DataTable2(
                            headingTextStyle: TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.w400),
                            headingRowHeight: 30,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Constants.buttonRed),
                            columnSpacing: 0,
                            dataRowHeight: 50,
                            columns: [
                              DataColumn2(
                                fixedWidth:
                                    MediaQuery.of(context).size.width * 0.28,
                                label: const Text(
                                  'PLAYER',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                fixedWidth:
                                    MediaQuery.of(context).size.width * 0.18,
                                label: const Text('R(B)'),
                              ),
                              DataColumn2(
                                fixedWidth:
                                    MediaQuery.of(context).size.width * 0.1,
                                label: const Text('4s'),
                              ),
                              const DataColumn2(
                                label: Text('6s'),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                                teamTwoMatchBatting.length,
                                (index) => DataRow(cells: [
                                      DataCell(SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                teamTwoMatchBatting[index]
                                                        ['player']
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Constants.blackColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text(
                                                "(${teamTwoMatchBatting[index]['status'].toString()})",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Constants.darkgrey,
                                                    fontSize: 12,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      )),
                                      DataCell(Text(
                                          "${teamTwoMatchBatting[index]['runs'].toString()}(${teamTwoMatchBatting[index]['balls'].toString()})",
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamTwoMatchBatting[index]['fours']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamTwoMatchBatting[index]['sixs']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                    ]))),
                      ),
                      onTap: () {
                        debugPrint("tapped!!");
                      },
                      onLongTap: () {
                        debugPrint("long tapped!!");
                      },
                    ),
                    ExpandedTile(
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 30,
                        color: Constants.whiteColor,
                      ),
                      theme: ExpandedTileThemeData(
                        headerColor: Constants.darkgrey,
                        headerRadius: 20.0,
                        headerSplashColor: Constants.darkgrey,
                      ),
                      controller: ExpandedTileController(isExpanded: false),
                      title: Text(
                        'Bowling Records',
                        style: TextStyle(
                            color: Constants.whiteColor,
                            fontSize: Constants.subHeaderSize),
                      ),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        height: teamTwoMatchBowling.length > 5
                            ? MediaQuery.of(context).size.height * 1.12
                            : MediaQuery.of(context).size.height * 0.35,
                        child: DataTable2(
                            headingTextStyle: TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.w400),
                            headingRowHeight: 30,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Constants.buttonRed),
                            columnSpacing: 0,
                            dataRowHeight: 50,
                            columns: [
                              DataColumn2(
                                fixedWidth:
                                    MediaQuery.of(context).size.width * 0.35,
                                label: const Text('PLAYER'),
                                size: ColumnSize.L,
                              ),
                              const DataColumn2(
                                label: Text('O'),
                              ),
                              const DataColumn2(
                                label: Text('M'),
                              ),
                              const DataColumn2(
                                label: Text('R'),
                              ),
                              const DataColumn2(
                                label: Text('W'),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                                teamTwoMatchBowling.length,
                                (index) => DataRow(cells: [
                                      DataCell(SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Text(
                                            teamTwoMatchBowling[index]['player']
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Constants.blackColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      )),
                                      DataCell(Text(
                                          teamTwoMatchBowling[index]['overs']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamTwoMatchBowling[index]['maiden']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamTwoMatchBowling[index]['runs']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(
                                          teamTwoMatchBowling[index]['wickets']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                    ]))),
                      ),
                      onTap: () {
                        debugPrint("tapped!!");
                      },
                      onLongTap: () {
                        debugPrint("long tapped!!");
                      },
                    ),
                  ],
                ),
                onTap: () {
                  debugPrint("tapped!!");
                },
                onLongTap: () {
                  debugPrint("long tapped!!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getScoreData() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    var matchID = argumentData.toString();
    var encodeBody = jsonEncode({"match_id": matchID.toString()});
    log('-----------------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("Users/getMatchInformation", encodeBody)
        .then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          matchScores = responseBody['data'];
          log(responseBody['toss'].toString());
          if (responseBody['winner'].toString().isEmpty &&
              responseBody['toss'].toString().isEmpty) {
            tossWinHeader = "";
          } else if (responseBody['winner'].toString().isEmpty &&
              responseBody['toss'].toString().isNotEmpty) {
            tossWinHeader = responseBody['toss'].toString();
          } else if (responseBody['toss'].toString().isEmpty &&
              responseBody['winner'].toString().isNotEmpty) {
            tossWinHeader = responseBody['winner'].toString();
          } else if (responseBody['winner'].toString().isNotEmpty &&
              responseBody['toss'].toString().isNotEmpty) {
            tossWinHeader = responseBody['winner'].toString();
          } else {
            tossWinHeader = "";
          }

          log(responseBody.toString());
          log(responseBody['winner'].toString());
          log('-----------------------------------------------------------------------');
          log(matchScores.toString());
          teamOneProfile = matchScores[0]['team_profile'].toString();
          teamTwoProfile = matchScores[1]['team_profile'].toString();
          teamOneName = matchScores[0]['team_name'].toString();
          teamTwoName = matchScores[1]['team_name'].toString();
          teamOneMandal = matchScores[0]['mandalam'].toString();
          teamTwoMandal = matchScores[1]['mandalam'].toString();
          teamOneTeamId = matchScores[0]['team_Id'].toString();
          teamTwoTeamId = matchScores[1]['team_Id'].toString();
          teamOneScore = matchScores[0]['score'].toString();
          teamTwoScore = matchScores[1]['score'].toString();
          teamOneWickets = matchScores[0]['wickets'].toString();
          teamTwoWickets = matchScores[1]['wickets'].toString();
          dateOfMatch = matchScores[0]['DOM'].toString();
          placeOfMatch = matchScores[0]['POM'].toString();
          teamOneMatchBatting = matchScores[0]['batting'];
          teamTwoMatchBatting = matchScores[1]['batting'];
          teamOneMatchBowling = matchScores[0]['bowling'];
          teamTwoMatchBowling = matchScores[1]['bowling'];
          log('-------------------teamOneMatchBatting----------------------------------------------------');
          log(teamOneMatchBatting.toString());
          log('-------------------teamTwoMatchBatting----------------------------------------------------');
          log(teamTwoMatchBatting.toString());
          log('-------------------teamOneMatchBowling----------------------------------------------------');
          log(teamOneMatchBowling.toString());
          log('-------------------teamTwoMatchBowling----------------------------------------------------');
          log(teamTwoMatchBowling.toString());
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }
}
