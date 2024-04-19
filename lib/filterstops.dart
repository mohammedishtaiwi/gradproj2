import 'package:flutter/material.dart';
import 'package:gradproj2/filtershortdetailpage.dart';
import 'package:gradproj2/selectflight.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class stopfilterpage extends StatefulWidget {
  const stopfilterpage({Key? key}) : super(key: key);

  @override
  State<stopfilterpage> createState() => _stopfilterpageState();
}

// ignore: camel_case_types
class _stopfilterpageState extends State<stopfilterpage> {
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
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
                              const filtershortdetail(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FloatingActionButton.extended(
            label: const Text(
              "SEARCH",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'Gilroy'),
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color(0xff1F75EC),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const selectflight(),
                ),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Container(
                height: 233,
                decoration: BoxDecoration(
                  color: notifire.notificationbackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24, left: 16),
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
                      padding:
                          const EdgeInsets.only(left: 16, right: 14, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '3 type of stops are available',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff9299A0),
                                fontFamily: 'Gilroy'),
                          ),
                          Text(
                            'From',
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                        thickness: 1, color: notifire.backbuttonborderColor),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ListTile(
                        horizontalTitleGap: 0,
                        //minLeadingWidth: 20,
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        leading: Checkbox(
                          splashRadius: 0,
                          side: const BorderSide(color: Colors.grey),
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          // ignore: unnecessary_this
                          value: this.value1,
                          onChanged: (bool? value) {
                            setState(() {
                              value1 = value!;
                            });
                          },
                        ),
                        title: Row(
                          children: [
                            Text(
                              "Nonstop",
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy'),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "(4)",
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy'),
                            ),
                          ],
                        ),
                        trailing: Text(
                          "\$565",
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ListTile(
                        horizontalTitleGap: 0,
                        //minLeadingWidth: 20,
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        leading: Checkbox(
                          splashRadius: 0,
                          side: const BorderSide(color: Colors.grey),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          // ignore: unnecessary_this
                          value: this.value2,
                          onChanged: (bool? value) {
                            setState(() {
                              value2 = value!;
                            });
                          },
                        ),
                        title: Row(
                          children: [
                            Text(
                              "1 stop",
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy'),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "(14)",
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy'),
                            ),
                          ],
                        ),
                        trailing: Text(
                          "\$565",
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ListTile(
                        horizontalTitleGap: 0,
                        //minLeadingWidth: 20,
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        leading: Checkbox(
                          splashRadius: 0,
                          side: const BorderSide(color: Colors.grey),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          // ignore: unnecessary_this
                          value: this.value3,
                          onChanged: (bool? value) {
                            setState(() {
                              value3 = value!;
                            });
                          },
                        ),
                        title: Row(
                          children: [
                            Text(
                              "2+ stops",
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy'),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "(2)",
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy'),
                            ),
                          ],
                        ),
                        trailing: Text(
                          "\$565",
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   height: 56,
            //   width: double.infinity,
            //   margin: const EdgeInsets.only(top: 420),
            //   padding: const EdgeInsets.only(left: 24, right: 24),
            //   child: FloatingActionButton(
            //     elevation: 0,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(14)),
            //     // ignore: sort_child_properties_last
            //     child: const Text(
            //       "DONE",
            //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            //     ),
            //     backgroundColor: Colors.blueAccent.shade400,
            //     onPressed: () {
            //       // Navigator.of(context).push(
            //       //   MaterialPageRoute(
            //       //       builder: (BuildContext context) => BottomNav()),
            //       // );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
