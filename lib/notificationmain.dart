import 'package:flutter/material.dart';
import 'package:gradproj2/homepage1.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

// ignore: camel_case_types
class _notificationState extends State<notification> {
  List<List1> image = [
    List1(
        image: "assets/palmjumirah.png",
        name: "Package From London",
        name2: "Start from \$45.00"),
    List1(
        image: "assets/palmjumirah.png",
        name: "New trip",
        name2: "Let’s travel with family"),
    List1(
        image: "assets/palmjumirah.png",
        name: "Package From London",
        name2: "Start from \$45.00"),
    List1(
        image: "assets/palmjumirah.png",
        name: "New trip",
        name2: "Let’s travel with family"),
    List1(
        image: "assets/palmjumirah.png",
        name: "Package From London",
        name2: "Start from \$45.00"),
    List1(
        image: "assets/palmjumirah.png",
        name: "New trip",
        name2: "Let’s travel with family"),
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
      backgroundColor: notifire.backgroundallscreenColor,
      appBar: AppBar(
        backgroundColor: notifire.backgroundallscreenColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (BuildContext context) => const home1(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 8),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: notifire.backbuttonborderColor),
                    borderRadius: BorderRadius.circular(16)),
                // ignore: sort_child_properties_last
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
          ),
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 12),
            alignment: Alignment.center,
            child: IconButton(
              icon: Image.asset('assets/notificationsettings.png'),
              iconSize: 16,
              color: Colors.black,
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //     const filterandshortmain(),
                //   ),
                // );
              },
            ),
          ),
        ],
        // centerTitle: true,

        automaticallyImplyLeading: false,
        title: Text(
          "Notifications",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Mark as read",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: notifire.greytextColor,
                          decoration: TextDecoration.underline,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: Container(
                width: double.infinity,
                // height: 120,
                //padding: EdgeInsets.symmetric(vertical: 24),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: image.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) =>
                        //     const searchflight(),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xff1F75EC)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: SizedBox(
                                height: 78,
                                //width: 145,
                                child: Card(
                                  color: notifire.notificationbackground,
                                  elevation: 0.2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        right: 12, left: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 55,
                                          height: 55,
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "${image[index].image}"),
                                                scale: 1,
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${image[index].name}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: notifire.getdarkscolor,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  "${image[index].name2}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: notifire
                                                          .greytextColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Gilroy'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Text(
                                                "2min ago",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        notifire.greytextColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
    );
  }
}

class List1 {
  String? image;
  String? name;
  String? name2;

  List1({this.image, this.name, this.name2});
}
