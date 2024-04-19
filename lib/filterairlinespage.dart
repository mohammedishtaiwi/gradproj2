import 'package:flutter/material.dart';
import 'package:gradproj2/selectflightfilterandshort.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filtershortdetailpage.dart';

// import 'package:flutter_listtile_demo/model/listtilemodel.dart';
// ignore: camel_case_types
class airlinesfilter extends StatefulWidget {
  const airlinesfilter({Key? key}) : super(key: key);

  @override
  State<airlinesfilter> createState() => _airlinesfilterState();
}

// ignore: camel_case_types
class _airlinesfilterState extends State<airlinesfilter> {
  //  bool value = false;
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
              child: Container(
                height: 616,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 16, top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: notifire.notificationbackground),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Airlines',
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.builder(
                          itemCount: checkBoxListTileModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                CheckboxListTile(
                                  dense: true,
                                  autofocus: true,
                                  side: const BorderSide(color: Colors.grey),
                                  contentPadding: EdgeInsets.zero,
                                  checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -2),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      checkBoxListTileModel[index].title,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: notifire.getdarkscolor,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ),
                                  value: checkBoxListTileModel[index].isCheck,
                                  secondary: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                      checkBoxListTileModel[index].img,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "\$4,985",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xff9299A0),
                                        fontFamily: 'Gilroy'),
                                  ),
                                  onChanged: (bool? val) {
                                    itemChange(val!, index);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Divider(
                                      thickness: 1,
                                      color: notifire.backbuttonborderColor),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Container(
            //   height: 56,
            //   width: double.infinity,
            //   margin: const EdgeInsets.only(top: 45),
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
            //       //       builder: (BuildContext context) => ()),
            //       // );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
    });
  }
}

class CheckBoxListTileModel {
  int userId;
  String img;
  String title;
  String subtitle;
  bool isCheck;

  CheckBoxListTileModel(
      {required this.userId,
      required this.img,
      required this.title,
      required this.subtitle,
      required this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          userId: 1,
          img: 'assets/Air_France-Logo-PNG1.png',
          title: "Air France",
          subtitle: "\$4,985",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 2,
          img: 'assets/Qatar_Airways-Logo-PNG3.png',
          title: "Qatar Airways",
          subtitle: "\$4,985",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 3,
          img: 'assets/American_Airlines_(3).png',
          title: "American Airlines",
          subtitle: "\$4,985",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 4,
          img: 'assets/Airbus-Logo-PNG1.png',
          title: "Airbus",
          subtitle: "\$4,985",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 5,
          img: 'assets/United_Airlines_(1).png',
          title: "United Airlines",
          subtitle: "\$4,985",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 6,
          img: 'assets/Emirates-Logo-PNG1) 1.png',
          title: "Fly Emirates",
          subtitle: "\$4,985",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 7,
          img: 'assets/Lufthansa-Logo-PNG2 1.png',
          title: "Luftahansa",
          subtitle: "\$4,985",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 5,
          img: 'assets/Turkish_Airlines-Logo-PNG1 1.png',
          title: "Turkish Airlines",
          subtitle: "\$4,985",
          isCheck: false),
    ];
  }
}
