import 'package:flutter/material.dart';
import 'package:gradproj2/explorepageofnavigationbar.dart';
import 'package:gradproj2/homepage1.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:gradproj2/tripspagenaviggationbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  // int selectedIndex1 = 1;
  // int selectedIndex2 = 2;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  List<Widget> myChilders = const [
    home1(),
    explorepageofnavigationbar(),
    tripspageofnavigationbar(),
  ];
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
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: myChilders),
      bottomNavigationBar: BottomAppBar(
        color: notifire.bottomnavigationbarbacground,
        child: TabBar(
          onTap: (index) {
            setState(
              () {
                selectedIndex = index;
              },
            );
          },
          indicator: const UnderlineTabIndicator(
            insets: EdgeInsets.only(
              bottom: 72,
            ),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
          labelColor: Colors.blueAccent,
          //isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: [
            Tab(
              iconMargin: const EdgeInsets.only(bottom: 3, top: 5),
              icon: //Icon(Icons.home_filled),
                  selectedIndex == 0
                      ? Image.asset("assets/homeselected.png", scale: 24)
                      : Image.asset("assets/homeunselected.png",
                          scale: 24, color: Colors.grey),
              child: const Text(
                'Home',
                style: TextStyle(fontSize: 12, fontFamily: 'Gilroy'),
              ),
            ),
            Tab(
              iconMargin: const EdgeInsets.only(bottom: 3, top: 5),
              icon: //Icon(Icons.explore),
                  selectedIndex == 1
                      ? Image.asset("assets/exploreunsselected.png", scale: 24)
                      : Image.asset(
                          "assets/exploreunselected.png",
                          scale: 24,
                          color: Colors.grey,
                        ),
              child: const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
            Tab(
              iconMargin: const EdgeInsets.only(bottom: 3, top: 5),
              icon: //Icon(Icons.shopping_bag_outlined),
                  selectedIndex == 2
                      ? Image.asset("assets/tripselected.png", scale: 24)
                      : Image.asset(
                          "assets/tripunselected.png",
                          scale: 24,
                          color: Colors.grey,
                        ),
              child: const Text(
                'Trips',
                style: TextStyle(fontSize: 12, fontFamily: 'Gilroy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
