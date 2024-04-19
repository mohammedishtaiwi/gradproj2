import 'package:flutter/material.dart';
import 'package:gradproj2/filterairlinespage.dart';
import 'package:gradproj2/filterdeparturetime.dart';
import 'package:gradproj2/filterstops.dart';
import 'package:gradproj2/searchflight.dart';
import 'package:gradproj2/selectflight.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class filterandshortmain extends StatefulWidget {
  const filterandshortmain({Key? key}) : super(key: key);

  @override
  State<filterandshortmain> createState() => _filterandshortmainState();
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

// ignore: camel_case_types
class _filterandshortmainState extends State<filterandshortmain> {
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FloatingActionButton.extended(
            label: const Text(
              "APPLY",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'Gilroy'),
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.blueAccent.shade400,
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => const selectflight(),
              //   ),
              // );
            },
          ),
        ),
      ),
      backgroundColor: notifire.backgroundallscreenColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.backgroundallscreenColor,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (BuildContext context) => const selectflight(),
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
                          builder: (BuildContext context) =>
                              const searchflight(),
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
        title: Text(
          "Filter",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Card(
          elevation: 0.2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            height: 370,
            width: double.infinity,
            decoration: BoxDecoration(
                color: notifire.notificationbackground,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Gilroy'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '229 of 229 results shown',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff9299A0),
                            fontFamily: 'Gilroy'),
                      ),
                      TextButton(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              color: notifire.getdarkscolor,
                              fontFamily: 'Gilroy'),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1, color: notifire.backbuttonborderColor),
                Expanded(
                  child: ListView(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const stopfilterpage(),
                              ),
                            );
                          },
                          child: ListTile(
                            horizontalTitleGap: 14,
                            minLeadingWidth: 15,
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -2),
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                height: 20,
                                width: 21,
                                child: Image.asset('assets/stops.png',
                                    color: notifire.filterandshortmainColor),
                              ),
                            ),
                            subtitle: const Text(
                              "Nonstop, 1 stop, 2+ stop",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy'),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Stops",
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const stopfilterpage(),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Color(0xffADB3B8),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: Divider(thickness: 1,color:notifire.backbuttonborderColor),
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const filtertimedeparture(),
                              ),
                            );
                          },
                          child: ListTile(
                            horizontalTitleGap: 14,
                            minLeadingWidth: 15,
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -2),
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                height: 20,
                                width: 21,
                                child: Image.asset(
                                  'assets/Time Circle.png',
                                  color: notifire.filterandshortmainColor,
                                ),
                              ),
                            ),
                            subtitle: const Text(
                              "Anytime",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy'),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Time",
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const filtertimedeparture(),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Color(0xffADB3B8),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: Divider(thickness: 1,color:notifire.backbuttonborderColor),
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const airlinesfilter(),
                              ),
                            );
                          },
                          child: ListTile(
                            horizontalTitleGap: 14,
                            minLeadingWidth: 15,
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -2),
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                height: 20,
                                width: 21,
                                child: Image.asset('assets/airline.png',
                                    color: notifire.filterandshortmainColor),
                              ),
                            ),
                            subtitle: const Text(
                              "Any",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy'),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Airlines",
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const airlinesfilter(),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Color(0xffADB3B8),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: Divider(thickness: 1,color:notifire.backbuttonborderColor),
                        // ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //     const stop(),
                            //   ),
                            // );
                          },
                          child: ListTile(
                            horizontalTitleGap: 14,
                            minLeadingWidth: 15,
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -2),
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                height: 20,
                                width: 21,
                                child: Image.asset(
                                  'assets/buggage.png',
                                  color: notifire.filterandshortmainColor,
                                ),
                              ),
                            ),
                            subtitle: const Text(
                              "Any",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy'),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Buggage",
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const filtertimedeparture(),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Color(0xffADB3B8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).toList(),
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
