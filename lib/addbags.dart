import 'package:flutter/material.dart';
import 'package:gradproj2/filtershortdetailpage.dart';
import 'package:gradproj2/paymentinfo.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

// ignore: camel_case_types
class addbags extends StatefulWidget {
  const addbags({Key? key}) : super(key: key);

  @override
  State<addbags> createState() => _addbagsState();
}

// ignore: camel_case_types
class _addbagsState extends State<addbags> {
  late final WeightSliderController _controller;
  double _weight = 100.0;
  bool _selectednobag = false;

  bool _selectedfree = false;

  bool _selectedpremium = false;

  @override
  void initState() {
    super.initState();
    _controller = WeightSliderController(
        initialWeight: _weight, minWeight: 0, interval: 0.1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                alignment: Alignment.center,
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
              ),
            ),
          ),
        ),
        title: Text(
          "Add Bags",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontFamily: 'gilroy',
              fontSize: 18),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 103,
      //   padding: const EdgeInsets.all(24),
      //   decoration: BoxDecoration(
      //       color: const Color(0xff0F182E),
      //       border: Border.all(color: Color(0xff0F182E),),),
      //   child: Center(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: const [
      //             Text(
      //               "Total",
      //               style: TextStyle(
      //                   color: Color(0xff717171),
      //                   fontSize: 14,
      //                   fontWeight: FontWeight.w400),
      //             ),
      //             Text(
      //               "\$450",
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 30,
      //                   fontWeight: FontWeight.w600),
      //             ),
      //           ],
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const paymentinfopage(),
      //               ),
      //             );
      //           },
      //           child: Container(
      //             width: 173,
      //             height: 56,
      //             decoration: BoxDecoration(
      //               color: Color(0xff1F75EC),
      //               borderRadius: BorderRadius.circular(14),
      //             ),
      //             alignment: Alignment.center,
      //             child: const Text(
      //               "CONFIRM",
      //               style: TextStyle(
      //                 fontWeight: FontWeight.w600,
      //                 fontSize: 16,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Select Bag Weight',
                style: TextStyle(
                    color: notifire.getdarkscolor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy'),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Select your bag weight what you want\ntake with you.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff768089),
                    fontFamily: 'Gilroy'),
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         const forgetpassword(),
                      //   ),
                      // );
                      setState(() {
                        _selectednobag = !_selectednobag;
                      });
                    },
                    child: Container(
                      // width: 95,
                      // height: 130,
                      padding: const EdgeInsets.only(
                          left: 10, right: 25, top: 10, bottom: 35),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5,
                            color: _selectednobag == true
                                ? const Color(0xff3DB2FF)
                                : Colors.transparent),
                        color: notifire.notificationbackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: notifire.backgroundallscreenColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 6.0, top: 6.0),
                                    child: SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: _selectednobag == true
                                            ? Image.asset('assets/x-circle.png',
                                                color: Colors.blue.shade900)
                                            : Image.asset('assets/x-circle.png',
                                                color: Colors.grey)),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                      height: 21,
                                      width: 21,
                                      child: _selectednobag == true
                                          ? Image.asset('assets/addbags.png',
                                              color: Colors.blue.shade900)
                                          : Image.asset('assets/addbags.png',
                                              color: Colors.grey)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          Text(
                            'No Bag',
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         const forgetpassword(),
                      //   ),
                      // );
                      setState(() {
                        _selectedfree = !_selectednobag;
                      });
                    },
                    child: Container(
                      // width: 130,
                      // height: 130,
                      padding: const EdgeInsets.only(
                          left: 8, right: 20, top: 10, bottom: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: _selectedfree == true
                                ? const Color(0xff3DB2FF)
                                : Colors.transparent,
                            width: 1.5),
                        color: notifire.notificationbackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: notifire.backgroundallscreenColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: SizedBox(
                                  height: 21,
                                  width: 21,
                                  child: _selectedfree == true
                                      ? Image.asset('assets/freeadd.png',
                                          color: Colors.blue.shade900)
                                      : Image.asset('assets/freeadd.png',
                                          color: Colors.grey)),
                            ),
                          ),
                          const SizedBox(height: 13),
                          Text(
                            'Free',
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontFamily: 'Gilroy'),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '1-10Kg is free',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color(0xff909CA7),
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         const forgetpassword(),
                      //   ),
                      // );
                      setState(() {
                        _selectedpremium = !_selectedpremium;
                      });
                    },
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: _selectedpremium == true
                                ? const Color(0xff3DB2FF)
                                : Colors.transparent,
                            width: 1.5),
                        color: notifire.notificationbackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: notifire.backgroundallscreenColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: SizedBox(
                                    height: 21,
                                    width: 21,
                                    child: _selectedpremium == true
                                        ? Image.asset('assets/dollaradd.png',
                                            color: Colors.blue.shade900)
                                        : Image.asset('assets/dollaradd.png',
                                            color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Text(
                              'Premium',
                              style: TextStyle(
                                  color: notifire.getdarkscolor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  fontFamily: 'Gilroy'),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Up to 15 kg',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff909CA7),
                                  fontFamily: 'Gilroy'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            //Expanded(child: SizedBox(height: 75)),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  //height: 100,
                  decoration: BoxDecoration(
                    color: notifire.notificationbackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '10',
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gilroy',
                                      fontSize: 60),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'kg',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Color(0xff909CA7),
                                        fontFamily: 'Gilroy'),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Charge:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff909CA7),
                                        fontFamily: 'Gilroy'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Free',
                                    style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gilroy',
                                        fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 270,
                        //padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: notifire.addbagsdecoration,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //SizedBox(height: 35),
                            Expanded(
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: SizedBox(
                                  height: double.infinity,
                                  //width: double.infinity,
                                  child: VerticalWeightSlider(
                                    controller: _controller,
                                    decoration: const PointerDecoration(
                                      width: 70.0,
                                      height: 3,
                                      largeColor: Color(0xFF898989),
                                      mediumColor: Color(0xFFC5C5C5),
                                      smallColor: Color(0xFFF0F0F0),
                                      gap: 30.0,
                                    ),
                                    onChanged: (double value) {
                                      setState(() {
                                        _weight = value;
                                      });
                                    },
                                    indicator: Container(
                                      height: 3.0,
                                      width: 100,
                                      //alignment: Alignment.centerLeft,
                                      color: Colors.red[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 29, bottom: 20),
                              child: SizedBox(
                                //height: ,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(right: 42),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total",
                                                style: TextStyle(
                                                    color: Color(0xff717171),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              '\$650',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 30,
                                                  color: Color(0xffFFFFFF),
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 56,
                                      width: 173,
                                      child: FloatingActionButton(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        // ignore: sort_child_properties_last
                                        child: const Text('CONFIRM',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                fontFamily: 'Gilroy')),
                                        backgroundColor:
                                            Colors.blueAccent.shade400,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const paymentinfopage(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
