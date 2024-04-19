import 'package:flutter/material.dart';
import 'package:gradproj2/selectflightfilterandshort.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filtershortdetailpage.dart';

// ignore: camel_case_types
class filtertimedeparture extends StatefulWidget {
  const filtertimedeparture({Key? key}) : super(key: key);

  @override
  State<filtertimedeparture> createState() => _filtertimedepartureState();
}

// ignore: camel_case_types
class _filtertimedepartureState extends State<filtertimedeparture> {
  bool selectedMorning = false;
  bool selectednoon = false;
  bool selectednight = false;

  bool selectedMorning1 = false;
  bool selectednoon1 = false;
  bool selectednight1 = false;
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
                  builder: (BuildContext context) => const filtershortdetail(),
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
              "DONE",
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
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (BuildContext context) => const filterandshortmain(),
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   //height: 251,
              //   margin: EdgeInsets.only(top: 32),
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 16),
              //     child: Column(
              //       //crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(left: 12),
              //           child: Row(
              //             children: const [
              //               Text(
              //                 'Departure time',
              //                 style: TextStyle(
              //                     fontSize: 18, fontWeight: FontWeight.w600),
              //               ),
              //             ],
              //           ),
              //         ),
              //         const SizedBox(
              //           height: 16,
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Stack(
              //               children: [
              //                 Container(
              //                   padding: EdgeInsets.all(10),
              //                   // height: 100,
              //                   // width: 170,
              //                   alignment: Alignment.center,
              //                   // padding: EdgeInsets.only(top: 10,right: 10),
              //                   //color: Colors.amberAccent,
              //                   child: GestureDetector(
              //                     onTap: () {
              //                       // Navigator.of(context).push(
              //                       //   MaterialPageRoute(
              //                       //     builder: (BuildContext context) =>
              //                       //     const forgetpassword(),
              //                       //   ),
              //                       // );
              //                       setState(() {
              //                         selectedMorning = !selectedMorning;
              //                       });
              //                     },
              //                     child: Container(
              //                       height: 76,
              //                       //width: 160,
              //                       padding: EdgeInsets.only(left: 26, right: 26),
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                               color: selectedMorning == true
              //                                   ? const Color(0xff1F75EC)
              //                                   : const Color(0xffDBDBDA),
              //                               width: 1),
              //                           borderRadius: BorderRadius.circular(12),
              //                           color: selectedMorning == true
              //                               ? Color(0xffF0F5FF)
              //                               : Colors.transparent),
              //                       child: Padding(
              //                         padding: const EdgeInsets.only(
              //                           top: 10,
              //                           bottom: 8,
              //                         ),
              //                         child: Column(
              //                           //mainAxisAlignment: MainAxisAlignment.center,
              //                           children: [
              //                             SizedBox(
              //                               height: 24,
              //                               width: 24,
              //                               child:
              //                                   Image.asset('assets/sunrise.png'),
              //                             ),
              //                             const Text(
              //                               'Morning',
              //                               style: TextStyle(
              //                                   fontSize: 14,
              //                                   fontWeight: FontWeight.w400),
              //                             ),
              //                             const SizedBox(
              //                               height: 2,
              //                             ),
              //                             const Text(
              //                               '(12:00am - 4:59pm)',
              //                               style: TextStyle(
              //                                 fontSize: 11,
              //                                 fontWeight: FontWeight.w400,
              //                                 color: Color(0xff9299A0),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: 144,
              //                   width: 23,
              //                   top: 4,
              //                   child: selectedMorning == true
              //                       ? const CircleAvatar(
              //                           radius: 11.5,
              //                           backgroundColor: Color(0xff1F75EC),
              //                           child: Icon(
              //                             Icons.check,
              //                             color: Colors.white,
              //                             size: 12,
              //                           ), //Text
              //                         )
              //                       : const SizedBox.shrink(),
              //                 ),
              //               ],
              //             ),
              //             Stack(
              //               children: [
              //                 Container(
              //                   padding: EdgeInsets.all(10),
              //                  // height: 100,
              //                   // width: 170,
              //                   //color: Colors.amberAccent,
              //                   alignment: Alignment.center,
              //                   child: GestureDetector(
              //                     onTap: () {
              //                       setState(() {
              //                         selectednoon = !selectednoon;
              //                       });
              //                     },
              //                     child: (Container(
              //                       height: 76,
              //                       //width: 160,
              //                       padding: EdgeInsets.only(left: 26, right: 26),
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                               color: selectednoon == true
              //                                   ? const Color(0xff1F75EC)
              //                                   : const Color(0xffDBDBDA),
              //                               width: 1),
              //                           borderRadius: BorderRadius.circular(12),
              //                           color: selectednoon == true
              //                               ? const Color(0xffF0F5FF)
              //                               : Colors.transparent),
              //                       child: Padding(
              //                         padding: const EdgeInsets.only(
              //                           top: 10,
              //                           bottom: 8,
              //                         ),
              //                         child: Column(
              //                           //mainAxisAlignment: MainAxisAlignment.center,
              //                           children: [
              //                             SizedBox(
              //                               height: 24,
              //                               width: 24,
              //                               child: Image.asset('assets/sun.png'),
              //                             ),
              //                             const Text(
              //                               'Noon',
              //                               style: TextStyle(
              //                                   fontSize: 14,
              //                                   fontWeight: FontWeight.w400),
              //                             ),
              //                             const SizedBox(
              //                               height: 2,
              //                             ),
              //                             const Expanded(
              //                               child: Text(
              //                                 '(12:00am - 4:59pm)',
              //                                 style: TextStyle(
              //                                   fontSize: 11,
              //                                   fontWeight: FontWeight.w400,
              //                                   color: Color(0xff9299A0),
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     )),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: 144,
              //                   width: 23,
              //                   top: 4,
              //                   child: selectednoon == true
              //                       ? const CircleAvatar(
              //                           radius: 12,
              //                           backgroundColor: Color(0xff1F75EC),
              //                           child: Icon(
              //                             Icons.check,
              //                             color: Colors.white,
              //                             size: 12,
              //                           ), //Text
              //                         )
              //                       : const SizedBox.shrink(),
              //                 ),
              //               ],
              //             ),
              //             // SizedBox(height: 15),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             Stack(
              //               children: [
              //                 Container(
              //                   padding: EdgeInsets.all(10),
              //                   // height: 100,
              //                   // width: 170,
              //                   //color: Colors.amberAccent,
              //                   alignment: Alignment.center,
              //                   child: GestureDetector(
              //                     onTap: () {
              //                       setState(() {
              //                         selectednight = !selectednight;
              //                       });
              //                     },
              //                     child: (
              //                         Container(
              //                       height: 76,
              //                       //width: 160,
              //                       padding: EdgeInsets.only(left: 26, right: 26),
              //                       decoration: BoxDecoration(
              //                           border: Border.all(
              //                               color: selectednight == true
              //                                   ? const Color(0xff1F75EC)
              //                                   : const Color(0xffDBDBDA),
              //                               width: 1),
              //                           borderRadius: BorderRadius.circular(12),
              //                           color: selectednight == true
              //                               ? const Color(0xffF0F5FF)
              //                               : Colors.transparent),
              //                       child: Padding(
              //                         padding: const EdgeInsets.only(
              //                           top: 10,
              //                           bottom: 8,
              //                         ),
              //                         child: Column(
              //                           //mainAxisAlignment: MainAxisAlignment.center,
              //                           children: [
              //                             Transform.rotate(
              //                                 angle: -7.0,
              //                                 child: const Icon(
              //                                     Icons.nightlight_outlined,color: Color(0xff0F182E),)),
              //                             const Text(
              //                               'Night',
              //                               style: TextStyle(
              //                                   fontSize: 14,
              //                                   fontWeight: FontWeight.w400),
              //                             ),
              //                             const SizedBox(
              //                               height: 2,
              //                             ),
              //                             const Expanded(
              //                               child: Text(
              //                                 '(10:00am - 11:59pm)',
              //                                 style: TextStyle(
              //                                   fontSize: 11,
              //                                   fontWeight: FontWeight.w400,
              //                                   color: Color(0xff9299A0),
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     )),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   left: 148,
              //                   width: 23,
              //                   top:4,
              //                   child: selectednight == true
              //                       ? const CircleAvatar(
              //                           radius: 11.5,
              //                           backgroundColor: Color(0xff1F75EC),
              //                           child: Icon(
              //                             Icons.check,
              //                             color: Colors.white,
              //                             size: 12,
              //                           ), //Text
              //                         )
              //                       : const SizedBox.shrink(),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                //height: 251,
                margin: const EdgeInsets.only(top: 32),
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  //border: Border.all(color: notifire.backbuttonborderColor),
                  color: notifire.notificationbackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Text(
                              'Departure time',
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 170,
                                alignment: Alignment.center,
                                // padding: EdgeInsets.only(top: 10,right: 10),
                                //color: Colors.amberAccent,
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (BuildContext context) =>
                                    //     const forgetpassword(),
                                    //   ),
                                    // );
                                    setState(() {
                                      selectedMorning = !selectedMorning;
                                    });
                                  },
                                  child: Container(
                                    height: 77,
                                    //width: 160,
                                    padding: const EdgeInsets.only(
                                        left: 26, right: 26),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: selectedMorning == true
                                                ? const Color(0xff1F75EC)
                                                : const Color(0xffDBDBDA),
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(12),
                                        color: selectedMorning == true
                                            ? const Color(0xffFFFFFF)
                                            : Colors.transparent),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 8,
                                      ),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Image.asset(
                                                'assets/sunrise.png',
                                                color: notifire
                                                    .filterandshortmainColor),
                                          ),
                                          Text(
                                            'Morning',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: notifire.getdarkscolor,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Gilroy'),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          const Text(
                                            '(12:00am - 4:59pm)',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff9299A0),
                                                fontFamily: 'Gilroy'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 145,
                                width: 23,
                                top: 6,
                                child: selectedMorning == true
                                    ? const CircleAvatar(
                                        radius: 11.5,
                                        backgroundColor: Color(0xff1F75EC),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        ), //Text
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 170,
                                //color: Colors.amberAccent,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectednoon = !selectednoon;
                                    });
                                  },
                                  child: (Container(
                                    height: 77,
                                    //width: 160,
                                    padding: const EdgeInsets.only(
                                        left: 26, right: 26),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: selectednoon == true
                                                ? const Color(0xff1F75EC)
                                                : const Color(0xffDBDBDA),
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(12),
                                        color: selectednoon == true
                                            ? const Color(0xffFFFFFF)
                                            : Colors.transparent),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 8,
                                      ),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Image.asset(
                                              'assets/sun.png',
                                              color: notifire
                                                  .filterandshortmainColor,
                                            ),
                                          ),
                                          Text(
                                            'Noon',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: notifire.getdarkscolor,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Gilroy'),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              '(12:00am - 4:59pm)',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff9299A0),
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                              Positioned(
                                left: 145,
                                width: 23,
                                top: 6,
                                child: selectednoon == true
                                    ? const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Color(0xff1F75EC),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        ), //Text
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          // SizedBox(height: 15),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 170,
                                  //color: Colors.amberAccent,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectednight = !selectednight;
                                      });
                                    },
                                    child: (Container(
                                      height: 77,
                                      //width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 26, right: 26),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: selectednight == true
                                                  ? const Color(0xff1F75EC)
                                                  : const Color(0xffDBDBDA),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: selectednight == true
                                              ? const Color(0xffFFFFFF)
                                              : Colors.transparent),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 8,
                                        ),
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 1),
                                              child: Image.asset(
                                                "assets/moon.png",
                                                color: notifire
                                                    .filterandshortmainColor,
                                                scale: 4,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              'Night',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Gilroy',
                                                  color:
                                                      notifire.getdarkscolor),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            const Expanded(
                                              child: Text(
                                                '(10:00am - 11:59pm)',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff9299A0),
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                                Positioned(
                                  left: 145,
                                  width: 23,
                                  top: 6,
                                  child: selectednight == true
                                      ? const CircleAvatar(
                                          radius: 11.5,
                                          backgroundColor: Color(0xff1F75EC),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 12,
                                          ), //Text
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                //height: 251,
                margin: const EdgeInsets.only(top: 32),
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: notifire.notificationbackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Text(
                              'Arrival time',
                              style: TextStyle(
                                fontFamily: "gilroy",
                                color: notifire.getdarkscolor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 170,
                                alignment: Alignment.center,
                                // padding: EdgeInsets.only(top: 10,right: 10),
                                //color: Colors.amberAccent,
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (BuildContext context) =>
                                    //     const forgetpassword(),
                                    //   ),
                                    // );
                                    setState(() {
                                      selectedMorning1 = !selectedMorning1;
                                    });
                                  },
                                  child: Container(
                                    height: 76,
                                    //width: 160,
                                    padding: const EdgeInsets.only(
                                        left: 26, right: 26),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: selectedMorning1 == true
                                                ? const Color(0xff1F75EC)
                                                : const Color(0xffDBDBDA),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                        color: selectedMorning1 == true
                                            ? const Color(0xffFFFFFF)
                                            : Colors.transparent),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 8,
                                      ),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Image.asset(
                                                'assets/sunrise.png',
                                                color: notifire
                                                    .filterandshortmainColor),
                                          ),
                                          Text(
                                            'Morning',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: notifire.getdarkscolor,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Gilroy'),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          const Text(
                                            '(12:00am - 4:59pm)',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff9299A0),
                                                fontFamily: 'Gilroy'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 144,
                                width: 23,
                                top: 6,
                                child: selectedMorning1 == true
                                    ? const CircleAvatar(
                                        radius: 11.5,
                                        backgroundColor: Color(0xff1F75EC),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        ), //Text
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 170,
                                //color: Colors.amberAccent,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectednoon1 = !selectednoon1;
                                    });
                                  },
                                  child: (Container(
                                    height: 76,
                                    //width: 160,
                                    padding: const EdgeInsets.only(
                                        left: 26, right: 26),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: selectednoon1 == true
                                                ? const Color(0xff1F75EC)
                                                : const Color(0xffDBDBDA),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                        color: selectednoon1 == true
                                            ? const Color(0xffFFFFFF)
                                            : Colors.transparent),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 8,
                                      ),
                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Image.asset('assets/sun.png',
                                                color: notifire
                                                    .filterandshortmainColor),
                                          ),
                                          Text(
                                            'Noon',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Gilroy',
                                                color: notifire.getdarkscolor),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              '(12:00am - 4:59pm)',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff9299A0),
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                              Positioned(
                                left: 144,
                                width: 23,
                                top: 6,
                                child: selectednoon1 == true
                                    ? const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Color(0xff1F75EC),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 12,
                                        ), //Text
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                          // SizedBox(height: 15),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 170,
                                  //color: Colors.amberAccent,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectednight1 = !selectednight1;
                                      });
                                    },
                                    child: (Container(
                                      height: 76,
                                      //width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 26, right: 26),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: selectednight1 == true
                                                  ? const Color(0xff1F75EC)
                                                  : const Color(0xffDBDBDA),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: selectednight1 == true
                                              ? const Color(0xffFFFFFF)
                                              : Colors.transparent),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 8,
                                        ),
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 1),
                                              child: Image.asset(
                                                "assets/moon.png",
                                                color: notifire
                                                    .filterandshortmainColor,
                                                scale: 4,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              'Night',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Gilroy',
                                                  color:
                                                      notifire.getdarkscolor),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            const Expanded(
                                              child: Text(
                                                '(10:00am - 11:59pm)',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff9299A0),
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                                Positioned(
                                  left: 144,
                                  width: 23,
                                  top: 6,
                                  child: selectednight1 == true
                                      ? const CircleAvatar(
                                          radius: 11.5,
                                          backgroundColor: Color(0xff1F75EC),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 12,
                                          ), //Text
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
