// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gradproj2/addbags.dart';
import 'package:gradproj2/filtershortdetailpage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class selectseats extends StatefulWidget {
  const selectseats({Key? key}) : super(key: key);

  @override
  State<selectseats> createState() => _selectseatsState();
}

class _selectseatsState extends State<selectseats> {
  // bool value1 = false;
  // bool value2 = false;
  // bool value3 = false;
  List<String> seatsA = [
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
  ];
  List<String> seatsB = [
    'B1',
    'B2',
    'B3',
    'B4',
    'B5',
  ];
  List<String> seatsC = [
    'C1',
    'C2',
    'C3',
    'C4',
    'C5',
  ];
  List<String> seatsD = [
    'D1',
    'D2',
    'D3',
    'D4',
    'D5',
  ];

  // void getSelectedSeats() {
  //   var _selectedSeatsText = "";
  //   var _selectedItems;
  //   _selectedItems.forEach((element) {
  //     if (_selectedSeatsText != "") _selectedSeatsText += " , ";
  //     _selectedSeatsText += (seats[element]);
  //   });
  // }

  //final List<int> _selectedItems = [];

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
                  borderRadius: BorderRadius.circular(16),
                ),
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
          "Select seats",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FloatingActionButton.extended(
            label: const Text(
              "NEXT",
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
                  builder: (BuildContext context) => const addbags(),
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
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DEA',
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy'),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          height: 35,
                          width: 112,
                          child: Image.asset('assets/selectflight.png')),
                      const Text(
                        '1h 30 Min',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontFamily: 'Gilroy'),
                      ),
                    ],
                  ),
                  Text(
                    'LAH',
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Dubai',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontFamily: 'Gilroy'),
                  ),
                  Text(
                    'Lahore',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 41.53,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 62),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 51,
                        width: 51,
                        child: Image.asset('assets/Emirates_Airlines 2.png'),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Feb 04, 8:30 AM',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff848D94),
                            fontFamily: 'Gilroy'),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Seat',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff9299A0),
                            fontFamily: 'Gilroy'),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'D3',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 28,
                            color: Color(0xff1F75EC),
                            fontFamily: 'Gilroy'),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Flight no',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff9299A0),
                            fontFamily: 'Gilroy'),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'AD3',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 28,
                            color: Color(0xff1F75EC),
                            fontFamily: 'Gilroy'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 29,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      //height:425,
                      padding: const EdgeInsets.only(left: 12, top: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: notifire.backgroundallscreenColor,
                        border: Border.all(
                          width: 1.5,
                          color: notifire.backbuttonborderColor,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      'A',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Color(0xff9299A0),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    SizedBox(width: 55),
                                    Text(
                                      'B',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Color(0xff9299A0),
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 35),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'C',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Color(0xff9299A0),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    SizedBox(width: 55),
                                    Text(
                                      'D',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Color(0xff9299A0),
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: seatsA.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Container(
                                            padding: const EdgeInsets.all(18),
                                            decoration: BoxDecoration(
                                              color: notifire.selectseats2,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            // height: 52,
                                            // width: 52,
                                            child: Center(
                                              child: Text(
                                                // ignore: unnecessary_string_interpolations
                                                "${seatsA[index]}",
                                                style: const TextStyle(
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: seatsB.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // height: 52,
                                            // width: 52,
                                            padding: const EdgeInsets.all(18),
                                            decoration: BoxDecoration(
                                              color: notifire.selectseats2,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                                child: Text(
                                              // ignore: unnecessary_string_interpolations
                                              "${seatsB[index]}",
                                              style: const TextStyle(
                                                  fontFamily: 'Gilroy'),
                                            )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: seatsC.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // height: 52,
                                            // width: 52,
                                            padding: const EdgeInsets.all(18),
                                            decoration: BoxDecoration(
                                              color: notifire.selectseats2,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                                child: Text(
                                              // ignore: unnecessary_string_interpolations
                                              "${seatsC[index]}",
                                              style: const TextStyle(
                                                  fontFamily: 'Gilroy'),
                                            )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: seatsD.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(18),
                                            decoration: BoxDecoration(
                                              color: notifire.selectseats2,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            // height: 52,
                                            // width: 52,
                                            //  color: notifire.selectseats2,
                                            child: Center(
                                                child: Text(
                                              // ignore: unnecessary_string_interpolations
                                              "${seatsD[index]}",
                                              style: const TextStyle(
                                                  fontFamily: 'Gilroy'),
                                            )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          // GridView.count(
                          //   crossAxisCount: 4,
                          //   childAspectRatio: 1,
                          //   crossAxisSpacing: 15,
                          //   mainAxisSpacing: 10,
                          //   shrinkWrap: true,
                          //   scrollDirection:Axis.vertical,
                          //   padding: const EdgeInsets.only(left: 16, right: 16),
                          //   controller:
                          //       ScrollController(keepScrollOffset: false),
                          //   children:List.generate(seats.length, (index) {
                          //     return Center(
                          //       child: Container(
                          //         height: 42,
                          //         width: 42,
                          //         child: RaisedButton(
                          //           onPressed: (){
                          //           },
                          //           color: Color(0xff828EFB),
                          //           child: Text(
                          //             seats[index] , style: TextStyle(fontSize: 12),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   }),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      'Economy',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9299A0),
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 61),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffB2B2B2),
                            ),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(width: 4),
                      // Checkbox(
                      //   visualDensity:
                      //       VisualDensity(horizontal: -4, vertical: -4),
                      //   checkColor: Colors.transparent,
                      //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(5))),
                      //   value: this.value1,
                      //   onChanged: (bool? value) {
                      //     setState(() {
                      //       this.value1 = value!;
                      //     });
                      //   },
                      // ),
                      Text(
                        "Available",
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'Gilroy'),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                            color: const Color(0xff3DB2FF),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      // Checkbox(
                      //   visualDensity:
                      //       VisualDensity(horizontal: -4, vertical: -4),
                      //   // visualDensity: ,
                      //   checkColor: Colors.transparent,
                      //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(5))),
                      //   value: this.value2,
                      //   onChanged: (bool? value) {
                      //     setState(() {
                      //       this.value2 = value!;
                      //     });
                      //   },
                      // ),
                      const SizedBox(width: 4),
                      Text(
                        "Selected",
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'Gilroy'),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                            color: notifire.selectseats2,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(width: 4),
                      // Checkbox(
                      //   visualDensity:
                      //       const VisualDensity(horizontal: -4, vertical: -4),
                      //   checkColor: Colors.transparent,
                      //   materialTapTargetSize:
                      //       MaterialTapTargetSize.shrinkWrap,
                      //   shape: const RoundedRectangleBorder(
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(5))),
                      //   value: value3,
                      //   onChanged: (bool? value) {s
                      //     setState(() {
                      //       this.value3 = value!;
                      //     });
                      //   },
                      // ),
                      Text(
                        "Unavailable",
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'Gilroy'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 200),
            // Container(
            //   padding: const EdgeInsets.only(right: 24, left: 24),
            //   width: double.infinity,
            //   child: FloatingActionButton(
            //     elevation: 0,
            //     splashColor: Colors.transparent,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12)),
            //     // ignore: sort_child_properties_last
            //     child: const Text('NEXT',
            //         style:
            //             TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
            //     backgroundColor: Colors.blueAccent.shade400,
            //     onPressed: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //             builder: (BuildContext context) => addbags()),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
