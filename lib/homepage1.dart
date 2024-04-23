import 'package:flutter/material.dart';
import 'package:gradproj2/editprofile.dart';
import 'package:gradproj2/notificationmain.dart';
import 'package:gradproj2/profilepage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'searchflightroundtrip.dart';
import 'searchflightoneday.dart';

// ignore: camel_case_types
class home1 extends StatefulWidget {
  const home1({Key? key}) : super(key: key);

  @override
  State<home1> createState() => _home1State();
}

// ignore: camel_case_types
class _home1State extends State<home1> with TickerProviderStateMixin {
  late TabController _tabController;
  bool show = false;
  late ColorNotifire notifire;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getdarkmodepreviousstate();
  }

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
                          builder: (BuildContext context) =>
                              const editprofile(),
                        ),
                      );
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
                            "Amman,",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                fontFamily: 'Gilroy'),
                          ),
                          Text(
                            "Jordan",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontFamily: 'Gilroy'),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          // const Icon(Icons.keyboard_arrow_down_outlined,
                          //     color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const notification(),
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
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Welcome, UserName", // GET THE LOGGED IN USERNAME
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Search flight",
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
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
                      borderSide:
                          BorderSide(color: Color(0xff1F75EC), width: 2),
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
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [const roundtrip(), const oneday()],
                  ),
                ),
              ],
            ),
          ),
        ));
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
