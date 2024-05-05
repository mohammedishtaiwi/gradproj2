import 'package:flutter/material.dart';
import 'package:gradproj2/homepage1.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/chat_bot.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  List<Widget> d = const [
    home1(),
    Chat(),
    BookedTicketsPage(),
  ];

  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previousState = prefs.getBool("setIsDark");
    if (previousState == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previousState;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: d,
      ),
      bottomNavigationBar: BottomAppBar(
        color: notifire.bottomnavigationbarbacground,
        child: TabBar(
          onTap: (index) {
            tabController.animateTo(index);
          },
          indicator: const UnderlineTabIndicator(
            insets: EdgeInsets.only(bottom: 72),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 106, 160, 225), width: 2),
          ),
          labelColor: Color.fromARGB(255, 106, 160, 225),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: [
            Tab(
              iconMargin: EdgeInsets.only(bottom: 3, top: 5),
              icon: Image.asset("assets/homeselected.png", scale: 24),
              child: Text(
                'Home',
                style: TextStyle(fontSize: 12, fontFamily: 'Gilroy'),
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.only(bottom: 3, top: 5),
              icon: Image.asset("assets/exploreunsselected.png", scale: 24),
              child: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.only(bottom: 3, top: 5),
              icon: Image.asset("assets/tripselected.png", scale: 24),
              child: Text(
                'Bookings',
                style: TextStyle(fontSize: 12, fontFamily: 'Gilroy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
