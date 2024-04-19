import 'package:flutter/material.dart';
import 'package:gradproj2/boardingpass.dart';
import 'package:gradproj2/bottomnavigationbar.dart';
import 'package:gradproj2/planeinfo.dart';
import 'package:gradproj2/pricebreakdownpage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class confirmpage extends StatefulWidget {
  const confirmpage({Key? key}) : super(key: key);

  @override
  State<confirmpage> createState() => _confirmpageState();
}

// ignore: camel_case_types
class _confirmpageState extends State<confirmpage> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FloatingActionButton.extended(
            label: const Text(
              "BACK TO HOME",
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const BottomNav(),
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                      'assets/kisspng-confetti-desktop-wallpaper-clip-art-confetti-5abb217f930b39 1.png'),
                  Image.asset('assets/confirmillustrationofflight.png'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your’re confirmed!',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy'),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Itinerary #2457241828',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff9299A0),
                          fontFamily: 'Gilroy'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 97,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: notifire.notificationbackground,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 25),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DEA',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24,
                                      color: notifire.getdarkscolor,
                                      fontFamily: 'Gilroy'),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                const Text(
                                  'Dubai',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff9299A0),
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 23, left: 26),
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: Colors.grey),
                                              //color: Colors.indigo.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: SizedBox(
                                            height: 6,
                                            width: 6,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: notifire.getdarkscolor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Stack(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 24,
                                                child: LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    return Flex(
                                                      // ignore: sort_child_properties_last
                                                      children: List.generate(
                                                        (constraints.constrainWidth() /
                                                                12)
                                                            .floor(),
                                                        (index) =>
                                                            const SizedBox(
                                                          height: 1,
                                                          width: 7,
                                                          child: DecoratedBox(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Color(
                                                                        0xff575975)),
                                                          ),
                                                        ),
                                                      ),
                                                      direction:
                                                          Axis.horizontal,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                    );
                                                  },
                                                ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 24),
                                                child: Center(
                                                  child: Text(
                                                    '1h 25min, 11:54 AM',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff848D94),
                                                        fontFamily: 'Gilroy'),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 35),
                                                  child: Image.asset(
                                                    'assets/confirmationpageplane.png',
                                                    scale: 23,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 23, right: 26),
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: Colors.grey),
                                              // color: Colors.indigo.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: SizedBox(
                                            height: 6,
                                            width: 6,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: notifire.getdarkscolor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'LAH',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24,
                                      color: notifire.getdarkscolor,
                                      fontFamily: 'Gilroy'),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                const Text(
                                  'Lahore',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff9299A0),
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Row(
                      children: [
                        const Text(
                          "1 traveller",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff848D94),
                              fontFamily: 'Gilroy'),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 2, left: 5, right: 5),
                          child: Container(
                            height: 3,
                            width: 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(0xff848D94),
                            ),
                          ),
                        ),
                        const Text(
                          "0 stop",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff848D94),
                              fontFamily: 'Gilroy'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    const Divider(thickness: 1),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/checkoutbreakdown.png'),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff1F75EC),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const pricebreakdown(),
                              ),
                            );
                          },
                          child: const Text(
                            'Price breakdown',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/boardingpassiconfirm.png'),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff1F75EC),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const baordingpasspage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Boarding Pass',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/planecheckout.png'),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff1F75EC),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const planeinfo(),
                              ),
                            );
                          },
                          child: const Text(
                            'Plane Info',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 17),
                    //   child: SizedBox(
                    //     height: 56,
                    //     width: double.infinity,
                    //     child: FloatingActionButton(
                    //       elevation: 0,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(14)),
                    //       // ignore: sort_child_properties_last
                    //       child: const Text('BACK TO HOME',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w600, fontSize: 16)),
                    //       backgroundColor: Colors.blueAccent.shade400,
                    //       onPressed: () {
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //             builder: (BuildContext context) =>
                    //             const BottomNav(),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
