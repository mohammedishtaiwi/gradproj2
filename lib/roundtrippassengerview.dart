import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class roundtrippassenger extends StatefulWidget {
  const roundtrippassenger({Key? key}) : super(key: key);

  @override
  State<roundtrippassenger> createState() => _roundtrippassengerState();
}

// ignore: camel_case_types
class _roundtrippassengerState extends State<roundtrippassenger> {
  int _currentIntValue1 = 0;
  int _currentIntValue2 = 0;
  int _currentIntValue3 = 0;

  //int _currentHorizontalIntValue = 10;
  int index = 2;

  // final ScrollController1 = FixedExtentScrollController();
  // final ScrollController2 = FixedExtentScrollController();
  // final ScrollController3 = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
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
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 32.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 22.88,
                  width: 23.99,
                  child: Image.asset('assets/Group.png'),
                ),
                const SizedBox(
                  height: 12.62,
                ),
                Text(
                  "$_currentIntValue1 Adults",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "gilroy",
                      color: notifire.getdarkscolor),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  '>12 years',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: "gilroy",
                      color: Colors.grey),
                ),
                // CupertinoPicker(
                //   backgroundColor: Colors.white,
                //   itemExtent: 30,
                //   scrollController: FixedExtentScrollController(initialItem: 1),
                //   children: [
                //     Text('0'),
                //     Text('1'),
                //     Text('2'),
                //   ],
                //   onSelectedItemChanged: (value) {
                //     setState(() {
                //       _currentIntValue = value;
                //     });
                //   },
                // ),
                const SizedBox(
                  height: 30,
                ),
                NumberPicker(
                  value: _currentIntValue1,
                  minValue: 0,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "gilroy",
                      color: notifire.greytextColor),
                  selectedTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: "gilroy",
                    color: Colors.blue,
                  ),
                  maxValue: 100,
                  step: 1,
                  itemHeight: 55,
                  axis: Axis.vertical,
                  onChanged: (value) {
                    setState(() {});
                    _currentIntValue1 = value;
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: notifire.backbuttonborderColor),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 22.88,
                  width: 23.99,
                  child: Image.asset('assets/group1.png'),
                ),
                const SizedBox(
                  height: 12.62,
                ),
                Text(
                  '$_currentIntValue2 Childrens',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "gilroy",
                      color: notifire.getdarkscolor),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  '2-12 years',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: "gilroy",
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                NumberPicker(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "gilroy",
                      color: notifire.greytextColor),
                  selectedTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: "gilroy",
                    color: Colors.blue,
                  ),
                  value: _currentIntValue2,
                  minValue: 0,
                  maxValue: 100,
                  itemHeight: 55,
                  axis: Axis.vertical,
                  onChanged: (value) =>
                      setState(() => _currentIntValue2 = value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: notifire.backbuttonborderColor),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 22.88,
                  width: 23.99,
                  child: Image.asset("assets/group00.png"),
                ),
                const SizedBox(
                  height: 12.62,
                ),
                Text(
                  '$_currentIntValue3 Infant',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "gilroy",
                      color: notifire.getdarkscolor),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  '<2 years',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                NumberPicker(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "gilroy",
                      color: notifire.greytextColor),
                  selectedTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: "gilroy",
                    color: Colors.blue,
                  ),
                  value: _currentIntValue3,
                  minValue: 0,
                  maxValue: 100,
                  step: 1,
                  itemHeight: 55,
                  axis: Axis.vertical,
                  onChanged: (value) =>
                      setState(() => _currentIntValue3 = value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: notifire.backbuttonborderColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
