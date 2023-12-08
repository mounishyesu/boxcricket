import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
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
      mobile: const ScoreCardScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const ScoreCardScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreCardScreen extends StatefulWidget {
  const ScoreCardScreen({super.key});

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
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
      ),
      backgroundColor: Constants.singinBgColor,
      body: const Column(
        children: <Widget>[
          ExpansionTile(
            title: Text('ExpansionTile 1'),
            subtitle: Text('Trailing expansion arrow icon'),
            children: <Widget>[
              ListTile(title: Text('This is tile number 1')),
            ],
          ),
        ],
      ),
    );
  }
}
