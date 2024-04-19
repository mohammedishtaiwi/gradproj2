import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gradproj2/explorepagebestdeals.dart';
import 'package:gradproj2/homepageseeallbestdestination.dart';
import 'package:gradproj2/homepageseealldealsbymonth.dart';
import 'package:gradproj2/homepageseeallexplore.dart';
import 'package:gradproj2/homepageseeallpopularplace.dart';
import 'package:gradproj2/homepagesseeallbestdeals.dart';
import 'package:gradproj2/notificationmain.dart';
import 'package:gradproj2/profilepage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class home1 extends StatefulWidget {
  const home1({Key? key}) : super(key: key);

  @override
  State<home1> createState() => _home1State();
}

// ignore: camel_case_types
class _home1State extends State<home1> with TickerProviderStateMixin {
  //int _selectedIndex = 0;

  // late TabController tabController;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  List<List1> imagess = [
    List1(image: "assets/planehomehigh.png", name: "Flight"),
    List1(image: "assets/hotelhommepagehigh.png", name: "Hotel"),
    List1(image: "assets/cabhomepagehigh.png", name: "Cab"),
  ];
  List<String> items = [
    'England',
    'USA',
    'India',
    'Pakistan',
    'Canada',
    'Germany',
    'Afghanistan',
    'South Africa',
  ];

  String? selectedValue;

  List<List2> popularplace = [
    List2(
        image1:
            "https://images.unsplash.com/photo-1665049628888-c80b95a107d1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
    List2(
        image1:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg"),
    List2(
        image1:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU"),
  ];

  List<List3> explore = [
    List3(
        image3:
            "https://images.unsplash.com/photo-1569165003085-e8a1066f1cb8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2371&q=80",
        name3: "Romania"),
    List3(
        image3:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg",
        name3: "Italy"),
    List3(
        image3:
            "https://images.unsplash.com/photo-1580837119756-563d608dd119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name3: "Russia"),
    List3(
        image3:
            "https://images.unsplash.com/photo-1523978591478-c753949ff840?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name3: "Norway"),
    List3(
        image3:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU",
        name3: "England"),
    List3(
        image3:
            "https://images.unsplash.com/photo-1548678967-f1aec58f6fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZWNlJTIwd2FsbHBhcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        name3: "Greece"),
  ];

  List<List4> bestdestinations = [
    List4(
        image4:
            "https://images.unsplash.com/photo-1569165003085-e8a1066f1cb8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2371&q=80",
        name4: "Family Trip"),
    List4(
        image4:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg",
        name4: "Longer Trip"),
    List4(
        image4:
            "https://images.unsplash.com/photo-1580837119756-563d608dd119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name4: "Shorter Trip"),
    List4(
        image4:
            "https://images.unsplash.com/photo-1523978591478-c753949ff840?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name4: "Norway"),
    List4(
        image4:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU",
        name4: "England"),
    List4(
        image4:
            "https://images.unsplash.com/photo-1548678967-f1aec58f6fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZWNlJTIwd2FsbHBhcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        name4: "Greece"),
  ];

  List<List5> bestdeals = [
    List5(
        image5:
            "https://images.unsplash.com/photo-1569165003085-e8a1066f1cb8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2371&q=80",
        name5: "Family Trip"),
    List5(
        image5:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg",
        name5: "Longer Trip"),
    List5(
        image5:
            "https://images.unsplash.com/photo-1580837119756-563d608dd119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name5: "Shorter Trip"),
    List5(
        image5:
            "https://images.unsplash.com/photo-1523978591478-c753949ff840?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name5: "Norway"),
    List5(
        image5:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU",
        name5: "England"),
    List5(
        image5:
            "https://images.unsplash.com/photo-1548678967-f1aec58f6fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZWNlJTIwd2FsbHBhcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        name5: "Greece"),
  ];

  List<List6> dealsbymonth = [
    List6(
        image6:
            "https://images.unsplash.com/photo-1569165003085-e8a1066f1cb8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2371&q=80",
        name6: "January"),
    List6(
        image6:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg",
        name6: "Fabruary"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1580837119756-563d608dd119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name6: "March"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1523978591478-c753949ff840?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name6: "April"),
    List6(
        image6:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU",
        name6: "May"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1548678967-f1aec58f6fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZWNlJTIwd2FsbHBhcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        name6: "June"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1503152394-c571994fd383?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540&q=80",
        name6: "July"),
    List6(
        image6:
            "https://media.istockphoto.com/photos/london-in-autumn-time-concept-with-a-person-holding-a-british-in-picture-id1348042661?s=612x612",
        name6: "August"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3383&q=80",
        name6: "September"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1533105079780-92b9be482077?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80",
        name6: "October"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
        name6: "November"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHRyYXZlbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60",
        name6: "December"),
  ];

  // final _drawerController = ZoomDrawerController();
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: notifire.backgroundallscreenColor,
        appBar: AppBar(
          backgroundColor: notifire.backgroundallscreenColor,
          automaticallyImplyLeading: false,
          toolbarHeight: 85,
          //toolbarOpacity: 0,
          elevation: 0,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const profilemain(),
                      ),
                    );
                    setState(
                      () {
                        // ZoomDrawer(
                        //   controller: _drawerController,
                        //   style: DrawerStyle.style1,
                        //   menuScreen: const home1(),
                        //   mainScreen: const home1(),
                        //   borderRadius: 24.0,
                        //   showShadow: false,
                        //   angle: 0.0,
                        //   menuBackgroundColor: Colors.grey.shade100,
                        //   openCurve: Curves.fastOutSlowIn,
                        //   slideWidth: MediaQuery.of(context).size.width * 65,
                        //   closeCurve: Curves.bounceIn,
                        // );
                      },
                    );
                    // ZoomDrawer(
                    //   controller: _drawerController,
                    //   style: DrawerStyle.style1,
                    //   menuScreen: home1(),
                    //   mainScreen: home1(),
                    //   borderRadius: 24.0,
                    //   showShadow: false,
                    //   angle: 0.0,
                    //   menuBackgroundColor: Colors.grey.shade100,
                    //   openCurve: Curves.fastOutSlowIn,
                    //   slideWidth: MediaQuery.of(context).size.width * 2,
                    //   closeCurve: Curves.bounceIn,
                    // );
                  },
                  child: const SizedBox(
                    height: 52,
                    width: 52,
                    child: CircleAvatar(
                      //backgroundColor: Colors.greenAccent[400],
                      backgroundImage:
                          AssetImage('assets/circleavtarimage.png'),
                      radius: 25,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                          fontFamily: "gilroy",
                          fontSize: 12,
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Color(0xff1F75EC),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "London,",
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Gilroy'),
                        ),
                        Text(
                          "UK",
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily: 'Gilroy'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.keyboard_arrow_down_outlined,
                            color: Colors.blue),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const notification(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: SizedBox(
                      height: 52,
                      width: 52,
                      child: CircleAvatar(
                        backgroundColor: notifire.notificationbackground,
                        // ignore: sort_child_properties_last
                        child: Image.asset(
                          'assets/Notification.png',
                          height: 20,
                          color: notifire.backbuttoniconColor,
                        ),
                        radius: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          // reverse: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Hi,',
                      style: TextStyle(
                          fontSize: 24,
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Percy',
                      style: TextStyle(
                          fontSize: 24,
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Let's discover a new adventure.",
                  style: TextStyle(
                      color: notifire.greytextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gilroy'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular place",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy'),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const homepageseeallpopularplace(),
                              ),
                            );
                          },
                          child: Text(
                            "SEE ALL",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: notifire.greytextColor,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: notifire.greytextColor,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const bestDeals(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 310,
                    decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(16)),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularplace.length,
                      itemBuilder: (context, index) {
                        return Card(
                          //elevation: 0,
                          // color: Colors.greenAccent[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            height: 302,
                            width: 275,
                            decoration: BoxDecoration(
                              color: notifire.notificationbackground,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 220,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      //color: Colors.black,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      '${popularplace[index].image1}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ListTile(
                                      title: Text(
                                        "The Colosseum",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: notifire.getdarkscolor,
                                            fontSize: 14,
                                            fontFamily: 'Gilroy'),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Image.asset(
                                              "assets/Locationexplore.png",
                                              scale: 28),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "Lambok,",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: notifire.greytextColor,
                                                fontSize: 12,
                                                fontFamily: 'Gilroy'),
                                          ),
                                          Text(
                                            "USA",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: notifire.greytextColor,
                                                fontSize: 12,
                                                fontFamily: 'Gilroy'),
                                          ),
                                        ],
                                      ),
                                      trailing: Image.asset(
                                          "assets/Heartpopularlist.png",
                                          color: notifire.backbuttoniconColor,
                                          scale: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy'),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const homepageseeallexplore(),
                              ),
                            );
                          },
                          child: Text(
                            "SEE ALL",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: notifire.greytextColor,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: notifire.greytextColor,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                //const SizedBox(height: 12,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const bestDeals(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: explore.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  // ignore: sort_child_properties_last
                                  child: Image.network(
                                    '${explore[index].image3}',
                                    fit: BoxFit.cover,
                                    height: 58,
                                  ),
                                  radius: 29,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  "${explore[index].name3}",
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: 'Gilroy'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best Destination",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy'),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const homepageseeallbestdestination(),
                              ),
                            );
                          },
                          child: Text(
                            "SEE ALL",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: notifire.greytextColor,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: notifire.greytextColor,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const bestDeals(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 175,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: bestdestinations.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  height: 115,
                                  width: 115,
                                  // ignore: sort_child_properties_last
                                  child: Image.network(
                                    '${bestdestinations[index].image4}',
                                    fit: BoxFit.cover,
                                    height: 58,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  "${bestdestinations[index].name4}",
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Gilroy'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best Deals",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy'),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const homepagesseeallbestdeals(),
                              ),
                            );
                          },
                          child: Text(
                            "SEE ALL",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: notifire.greytextColor,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: notifire.greytextColor,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                //SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const bestDeals(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(16)),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bestdeals.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // color: Colors.greenAccent[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            height: 302,
                            width: 275,
                            decoration: BoxDecoration(
                              color: notifire.notificationbackground,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => bestDeals(),
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 8, right: 8),
                                        height: 140,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          //color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            '${bestdeals[index].image5}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        margin: const EdgeInsets.only(
                                            top: 18, right: 16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white.withOpacity(0.5),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/Heart.png",
                                            ),
                                            scale: 32,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 15, sigmaY: 15),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Cabcum",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: notifire.getdarkscolor,
                                                fontFamily: 'Gilroy'),
                                          ),
                                          Text(
                                            "From",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: notifire.greytextColor,
                                                fontFamily: 'Gilroy'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/Locationexplore.png",
                                                  scale: 28),
                                              Text(
                                                "Lambok, USA",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        notifire.greytextColor,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "\$120",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color:
                                                        notifire.getdarkscolor,
                                                    fontFamily: 'Gilroy'),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Deals by month",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy'),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const homepageseealldealsbymonth(),
                              ),
                            );
                          },
                          child: Text(
                            "SEE ALL",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: notifire.greytextColor,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: notifire.greytextColor,
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height:12),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const bestDeals(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 175,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: dealsbymonth.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  height: 115,
                                  width: 115,
                                  // ignore: sort_child_properties_last
                                  child: Image.network(
                                    '${dealsbymonth[index].image6}',
                                    fit: BoxFit.cover,
                                    height: 58,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  "${dealsbymonth[index].name6}",
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Gilroy'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class List1 {
  String? image;
  String? name;

  List1({this.image, this.name});
}

class List2 {
  String? image1;

  //String? name1;

  List2({
    this.image1,
    //this.name1
  });
}

class List3 {
  String? image3;
  String? name3;

  List3({this.image3, this.name3});
}

class List4 {
  String? image4;
  String? name4;

  List4({this.image4, this.name4});
}

class List5 {
  String? image5;
  String? name5;

  List5({this.image5, this.name5});
}

class List6 {
  String? image6;
  String? name6;

  List6({this.image6, this.name6});
}
