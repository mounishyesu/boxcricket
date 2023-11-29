import 'package:boxcricket/views/home/homepage.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopStories extends StatefulWidget {
  const TopStories({super.key});

  @override
  State<TopStories> createState() => _TopStoriesState();
}

class _TopStoriesState extends State<TopStories> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const TopStoriesPage(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const TopStoriesPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopStoriesPage extends StatefulWidget {
  const TopStoriesPage({super.key});

  @override
  State<TopStoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends State<TopStoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.topstoriesHeader),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize, color: Constants.blackColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Constants.backIconSize,
            color: Constants.backIconColor,
          ),
          onPressed: () => Get.offAll(()=>const Home()),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(Constants.storyImage,
                  height: 200, width: 500, fit: BoxFit.fill),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Story Headline",
                  style: TextStyle(
                      color: Constants.darkgrey, fontWeight: FontWeight.bold,fontSize: Constants.headerSize),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pretium magna vel leo viverra, vitae tempor nibh imperdiet. Vestibulum luctus risus turpis, in sagittis turpis bibendum et. Curabitur suscipit tempor elit, in egestas velit imperdiet eget. ",
                  style: TextStyle(
                    color: Constants.darkgrey,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}