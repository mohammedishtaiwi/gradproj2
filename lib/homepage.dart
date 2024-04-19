import 'package:flutter/material.dart';
import 'package:gradproj2/signinpage.dart';
import 'package:gradproj2/signuppage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() async {
    setState(() async {});
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
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: notifire.backgroundallscreenColor,
          //resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 170,
                        //color: Colors.red,
                        //height: 30,
                        //padding: EdgeInsets.only(left: 12),
                        child: TabBar(
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                              insets:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              borderSide: BorderSide(
                                  width: 2, color: notifire.getdarkscolor)),
                          // unselectedLabelStyle: TextStyle(color: Colors.red),
                          // unselectedLabelColor: TextStyle(color: Colors.red),
                          labelPadding:
                              const EdgeInsets.only(left: 15, right: 15),
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: notifire.getdarkscolor,
                          labelColor: notifire.getdarkscolor,
                          tabs: [
                            Tab(
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: 18,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: 18,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   //height: 8,
                      //   decoration: BoxDecoration(
                      //       gradient: LinearGradient(
                      //     begin: Alignment.topRight,
                      //     end: Alignment.bottomLeft,
                      //     colors: [
                      //       Colors.blue.shade100,
                      //       Colors.white12,
                      //     ],
                      //   )),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    signin(),
                    signup(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
