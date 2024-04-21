import 'package:flutter/material.dart';
import 'package:gradproj2/explorepagebestdeals.dart';
import 'package:gradproj2/homepageseeallpopularplace.dart';
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
