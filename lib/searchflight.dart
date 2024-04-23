// ignore_for_file: camel_case_types, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gradproj2/searchflightoneday.dart';
import 'package:gradproj2/searchflightroundtrip.dart';
import 'package:gradproj2/selectflightfilterandshort.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage1.dart';

class searchflight extends StatefulWidget {
  const searchflight({Key? key}) : super(key: key);

  @override
  State<searchflight> createState() => _searchflightState();
}

class _searchflightState extends State<searchflight>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool show = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  late ColorNotifire notifire;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.backgroundallscreenColor,
      appBar: AppBar(
        backgroundColor: notifire.backgroundallscreenColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4, top: 8),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      border: Border.all(color: notifire.backbuttonborderColor),
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: notifire.backbuttoniconColor,
                      ),
                      iconSize: 14,
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const home1(),
                          ),
                        );
                      },
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Search flight",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: IconButton(
                  icon: Image.asset('assets/settingsselect.png'),
                  iconSize: 20,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const filterandshortmain(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 12),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).pop(
        //         MaterialPageRoute(
        //           builder: (BuildContext context) => searchflight(),
        //         ),
        //       );
        //     },
        //     child: Image.asset("assets/Backbutton.png"),
        //   ),
        // ),

        //Container(
        //   height: 20,
        //   margin: const EdgeInsets.only(left: 20),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(16),
        //     border: Border.all(
        //       color: Color(0xffDEDEDE),
        //     ),
        //   ),
        //   alignment: Alignment.center,
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back_ios_new_outlined,
        //       color: Color(0xff0F182E),
        //     ),
        //     iconSize: 20,
        //     color: Colors.black,
        //     onPressed: () {
        //       Navigator.of(context).pop(
        //         MaterialPageRoute(
        //           builder: (BuildContext context) => searchflight(),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        // title: Row(
        //   children: [
        //     Text(
        //       "Search flight",
        //       style: TextStyle(
        //           color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
        //     ),
        //     SizedBox(
        //       height: 52,
        //       width: 52,
        //       child: CircleAvatar(
        //         backgroundColor: Colors.white,
        //         // ignore: sort_child_properties_last
        //         child: Image.asset(
        //           'assets/Notification.png',
        //           height: 20,
        //         ),
        //         radius: 25,
        //       ),
        //     ),
        //   ],
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              //height: kToolbarHeight + 4,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: TabBar(
                // ignore: avoid_types_as_parameter_names
                onTap: (bool) async {
                  show = !show;
                },
                controller: _tabController,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xff1F75EC), width: 2),
                  insets: EdgeInsets.fromLTRB(0, 0, 0, 45),
                ),
                labelColor: const Color(0xff1F75EC),
                unselectedLabelColor: Colors.grey,
                splashBorderRadius: BorderRadius.circular(10),
                tabs: const [
                  Tab(
                    child: Text(
                      "Round trip",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "One way",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  // Tab(
                  //   child: Text(
                  //     "Multi-city",
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //         fontFamily: 'Gilroy'),
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const roundtrip(),
                  const oneday(),
                  //const multicity()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
