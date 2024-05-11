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
        color: Colors.white,
        child: TabBar(
          onTap: (index) {
            tabController.animateTo(index);
          },
          indicator: const UnderlineTabIndicator(
            insets: EdgeInsets.only(bottom: 72),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          labelColor: Colors.black,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.black,
          controller: tabController,
          tabs: [
            Tab(
              iconMargin: const EdgeInsets.only(bottom: 3, top: 5),
              icon: Image.asset("assets/home.png", scale: 13),
              child: const Text(
                'Home',
                style: TextStyle(fontSize: 13, fontFamily: 'Gilroy'),
              ),
            ),
            Tab(
              iconMargin: const EdgeInsets.only(bottom: 3, top: 5),
              icon: Image.asset("assets/chat.png", scale: 20),
              child: const Text(
                'Chat',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
            Tab(
              iconMargin: const EdgeInsets.only(bottom: 3, top: 5),
              icon: Image.asset("assets/ticket.png", scale: 20),
              child: const Text(
                'Bookings',
                style: TextStyle(fontSize: 13, fontFamily: 'Gilroy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
