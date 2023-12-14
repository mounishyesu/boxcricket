import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllStories extends StatefulWidget {
  const AllStories({super.key});

  @override
  State<AllStories> createState() => _AllStoriesState();
}

class _AllStoriesState extends State<AllStories> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const AllStoriesPage(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const AllStoriesPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllStoriesPage extends StatefulWidget {
  const AllStoriesPage({super.key});

  @override
  State<AllStoriesPage> createState() => _AllStoriesPageState();
}

class _AllStoriesPageState extends State<AllStoriesPage> {
  dynamic allStories = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Stories',
        ),
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
      body: SafeArea(
        bottom: true,
        child: ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: allStories.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                      allStories[index]['cuisine_file_url'].toString(),
                      height: 200,
                      width: 500,
                      fit: BoxFit.fill),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        allStories[index]['cuisine_name'].toString(),
                        style: TextStyle(
                            color: Constants.darkgrey,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      children: [
                        Text(
                          allStories[index]['description'].toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
