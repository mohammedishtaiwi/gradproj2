import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj2/signinpage.dart';
import 'package:gradproj2/signuppage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

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
          body: Column(
            children: [
              Container(
                color: Color.fromARGB(255, 114, 151, 172),
                child: TabBar(
                  controller: _tabController,
                  indicator: const UnderlineTabIndicator(
                    insets: EdgeInsets.symmetric(horizontal: 10),
                    borderSide: BorderSide(width: 2, color: Colors.white),
                  ),
                  labelPadding: const EdgeInsets.only(left: 15, right: 15),
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: notifire.getdarkscolor,
                  labelColor: notifire.getdarkscolor,
                  dividerColor: const Color.fromARGB(255, 114, 151, 172),
                  tabs: const [
                    Tab(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                  ],
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
