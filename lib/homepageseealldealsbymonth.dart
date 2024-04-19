import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage1.dart';

// ignore: camel_case_types
class homepageseealldealsbymonth extends StatefulWidget {
  const homepageseealldealsbymonth({Key? key}) : super(key: key);

  @override
  State<homepageseealldealsbymonth> createState() =>
      _homepageseealldealsbymonthState();
}

// ignore: camel_case_types
class _homepageseealldealsbymonthState
    extends State<homepageseealldealsbymonth> {
  List<List6> dealsbymonth = [
    List6(
        image6:
            "https://images.unsplash.com/photo-1569165003085-e8a1066f1cb8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2371&q=80",
        name6: "January"),
    List6(
        image6:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg",
        name6: "Fabruary"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1580837119756-563d608dd119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name6: "March"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1523978591478-c753949ff840?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name6: "April"),
    List6(
        image6:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU",
        name6: "May"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1548678967-f1aec58f6fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZWNlJTIwd2FsbHBhcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        name6: "June"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1503152394-c571994fd383?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540&q=80",
        name6: "July"),
    List6(
        image6:
            "https://media.istockphoto.com/photos/london-in-autumn-time-concept-with-a-person-holding-a-british-in-picture-id1348042661?s=612x612",
        name6: "August"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3383&q=80",
        name6: "September"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1533105079780-92b9be482077?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80",
        name6: "October"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
        name6: "November"),
    List6(
        image6:
            "https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHRyYXZlbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60",
        name6: "December"),
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
        title: Text(
          "Deals by Month",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(right: 12, left: 12, top: 16, bottom: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 24,
              mainAxisExtent: 132),
          itemCount: dealsbymonth.length,
          addAutomaticKeepAlives: true,
          itemBuilder: (context, index) {
            return Container(
              color: notifire.backgroundallscreenColor,
              child: Column(
                children: [
                  Container(
                    height: 101,
                    width: 108,
                    // ignore: sort_child_properties_last
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        "${dealsbymonth[index].image6}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // image: DecorationImage(
                      //   image: AssetImage(
                      //       '${dealsbymonth[index].image6}',),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "${dealsbymonth[index].name6}",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class List6 {
  String? image6;
  String? name6;

  List6({this.image6, this.name6});
}
