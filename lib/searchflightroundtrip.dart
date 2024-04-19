import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradproj2/roundtripcabinclassview.dart';
import 'package:gradproj2/roundtrippassengerview.dart';
import 'package:gradproj2/searchflightroundtripssearchbar.dart';
import 'package:gradproj2/selectflight.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   initializeDateFormatting().then((_) => runApp(roundtrip()));
// }

// ignore: camel_case_types
class roundtrip extends StatefulWidget {
  const roundtrip({Key? key}) : super(key: key);

  @override
  State<roundtrip> createState() => _roundtripState();
}

// ignore: camel_case_types
class _roundtripState extends State<roundtrip>
    with SingleTickerProviderStateMixin {
  final from = TextEditingController();
  final to = TextEditingController();
  final departure = TextEditingController();
  final passengers = TextEditingController();
  final clas = TextEditingController();
  late TabController _tabController;
  final _selectedColor = const Color(0xff1a73e8);

  // ignore: prefer_typing_uninitialized_variables
  var height;
  // ignore: prefer_typing_uninitialized_variables
  var width;

  //final _unselectedColor = Color(0xff5f6368);
  final _tabs = [
    const Tab(text: 'Passengers'),
    const Tab(text: 'Cabin class'),
  ];
  // ignore: prefer_typing_uninitialized_variables
  var _isVisible;

  final firstdate = DateTime(2010, 1);
  final lastdate = DateTime(2030, 12);
  late ScrollController _hideButtonController;

  @override
  void initState() {
    departure.text = "";
    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          /* only set when the previous state is false
             * Less widget rebuilds
             */
          // ignore: avoid_print
          print("**** $_isVisible up"); //Move IO away from setState
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            /* only set when the previous state is false
               * Less widget rebuilds
               */
            // ignore: avoid_print
            print("**** $_isVisible down"); //Move IO away from setState
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: double.infinity,
        height: 56,
        child: Visibility(
          visible: _isVisible,
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
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: from,
                style: TextStyle(
                    color: notifire.getdarkscolor, fontFamily: "gilroy"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  hintStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                  fillColor: Colors.white,
                  // hintText: 'Enter Your Email',
                  labelText: "FROM",
                  labelStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 290, top: 2, bottom: 2),
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () {},
                          child: Image.asset('assets/Group 615.png')),
                    ),
                  ),
                ),
              ),
              TextField(
                controller: to,
                style: TextStyle(
                    color: notifire.getdarkscolor, fontFamily: "gilroy"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: notifire.getgreycolor,
                      ),
                    ),
                    hintStyle: TextStyle(
                        color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    fillColor: Colors.white,
                    // hintText: 'Enter Your Email',
                    labelText: "TO",
                    labelStyle: TextStyle(
                        color: notifire.getdarkscolor, fontFamily: "gilroy")),
              ),
              const SizedBox(
                height: 28,
              ),
              TextField(
                style: TextStyle(
                    fontFamily: "gilroy", color: notifire.getdarkscolor),
                controller: departure,
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: firstdate,
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: lastdate,
                  );
                  if (selectedDate != null) {
                    // ignore: avoid_print
                    print(selectedDate);
                    String formattedDate =
                        DateFormat.yMd().format(selectedDate);
                    // ignore: avoid_print
                    print(formattedDate);
                    setState(
                      () {
                        departure.text = formattedDate;
                      },
                    );
                  } else {
                    // ignore: avoid_print
                    print("Date is not selected");
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  suffixIcon: Image.asset("assets/calendar07.png", scale: 3.5),
                  hintText: 'DATE OF BIRTH',
                  hintStyle: TextStyle(
                      fontFamily: "gilroy", color: notifire.getdarkscolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 5.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              TextField(
                style: TextStyle(
                    fontFamily: "gilroy", color: notifire.getdarkscolor),
                textInputAction: TextInputAction.next,
                controller: passengers,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  //hintText: 'Enter Your Email',
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctxt) => AlertDialog(
                          backgroundColor: notifire.notificationbackground,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          insetPadding: const EdgeInsets.all(13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          actions: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 30),
                                height: 56,
                                width: 173,
                                child: FloatingActionButton(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  // ignore: sort_child_properties_last
                                  child: const Text('DONE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  backgroundColor: Colors.blueAccent.shade400,
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const searchflightroundtrip(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                          title: SizedBox(
                            height: 360,
                            width: 349,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                    controller: _tabController,
                                    tabs: _tabs,
                                    unselectedLabelColor: Colors.grey,
                                    isScrollable: true,
                                    labelColor: _selectedColor,
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80.0),
                                      color: _selectedColor.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: const [
                                      roundtrippassenger(),
                                      roundtripcabinclass(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      setState(
                        () {},
                      );
                    },
                    icon: Image.asset("assets/people1.png", scale: 3.5),
                  ),
                  labelText: "PASSENGERS",
                  labelStyle: TextStyle(
                      fontFamily: "gilroy", color: notifire.getdarkscolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 5.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              TextField(
                style: TextStyle(
                    fontFamily: "gilroy", color: notifire.getdarkscolor),
                textInputAction: TextInputAction.next,
                controller: clas,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  //hintText: 'Enter Your Email',
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctxt) => AlertDialog(
                          backgroundColor: notifire.notificationbackground,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          insetPadding: const EdgeInsets.all(13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          actions: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 30),
                                height: 56,
                                width: 173,
                                child: FloatingActionButton(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  // ignore: sort_child_properties_last
                                  child: const Text('DONE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  backgroundColor: Colors.blueAccent.shade400,
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const searchflightroundtrip(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                          title: SizedBox(
                            height: 360,
                            width: 349,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                    controller: _tabController,
                                    tabs: _tabs,
                                    unselectedLabelColor: Colors.grey,
                                    isScrollable: true,
                                    labelColor: _selectedColor,
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80.0),
                                      color: _selectedColor.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: const [
                                      roundtrippassenger(),
                                      roundtripcabinclass(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      setState(
                        () {},
                      );
                    },
                    icon: Image.asset("assets/chair.png", scale: 3.5),
                  ),
                  labelText: "CLASS",
                  labelStyle: TextStyle(
                      fontFamily: "gilroy", color: notifire.getdarkscolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 5.0,
                    ),
                  ),
                ),
              ),
              //Spacer(),
              // SizedBox(
              //   height: height /10,
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: FloatingActionButton(
              //     elevation: 0,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12)),
              //     backgroundColor: Colors.blueAccent.shade400,
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (BuildContext context) =>
              //               const selectflight(),
              //         ),
              //       );
              //     },
              //     child: const Text('SEARCH',
              //         style:
              //             TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              //   ),
              // ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
