import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class explorepageofnavigationbar extends StatefulWidget {
  const explorepageofnavigationbar({Key? key}) : super(key: key);

  @override
  State<explorepageofnavigationbar> createState() =>
      _explorepageofnavigationbarState();
}

// ignore: camel_case_types
class _explorepageofnavigationbarState
    extends State<explorepageofnavigationbar> {
  final search = TextEditingController();
  List<List1> bestdestinations = [
    List1(
        image:
            "https://images.unsplash.com/photo-1569165003085-e8a1066f1cb8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2371&q=80",
        name: "Family Trip"),
    List1(
        image:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg",
        name: "Longer Trip"),
    List1(
        image:
            "https://images.unsplash.com/photo-1580837119756-563d608dd119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name: "Shorter Trip"),
    List1(
        image:
            "https://images.unsplash.com/photo-1523978591478-c753949ff840?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name: "Norway"),
    List1(
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU",
        name: "England"),
    List1(
        image:
            "https://images.unsplash.com/photo-1548678967-f1aec58f6fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZWNlJTIwd2FsbHBhcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        name: "Greece"),
  ];
  List<List2> bestdeals = [
    List2(
        image1:
            "https://images.unsplash.com/photo-1569165003085-e8a1066f1cb8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2371&q=80",
        name1: "Family Trip"),
    List2(
        image1:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg",
        name1: "Longer Trip"),
    List2(
        image1:
            "https://images.unsplash.com/photo-1580837119756-563d608dd119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name1: "Shorter Trip"),
    List2(
        image1:
            "https://images.unsplash.com/photo-1523978591478-c753949ff840?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name1: "Norway"),
    List2(
        image1:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU",
        name1: "England"),
    List2(
        image1:
            "https://images.unsplash.com/photo-1548678967-f1aec58f6fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZWNlJTIwd2FsbHBhcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        name1: "Greece"),
  ];

  List<List3> dealsbymonth = [
    List3(
        image2:
            "https://images.unsplash.com/photo-1569165003085-e8a1066f1cb8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2371&q=80",
        name2: "January"),
    List3(
        image2:
            "https://media.cntraveler.com/photos/5cc2336031a2ae73ce6fb4df/master/w_4000,h_2667,c_limit/New-York_GettyImages-688899871.jpg",
        name2: "Fabruary"),
    List3(
        image2:
            "https://images.unsplash.com/photo-1580837119756-563d608dd119?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name2: "March"),
    List3(
        image2:
            "https://images.unsplash.com/photo-1523978591478-c753949ff840?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
        name2: "April"),
    List3(
        image2:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1-beyvRXZ5BAncq7fLvfxVSzuux-gYaeT91aX7UpfN7JwILtx9-G8Ze6dPnSAhq8eD4&usqp=CAU",
        name2: "May"),
    List3(
        image2:
            "https://images.unsplash.com/photo-1548678967-f1aec58f6fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZWNlJTIwd2FsbHBhcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        name2: "June"),
    List3(
        image2:
            "https://images.unsplash.com/photo-1503152394-c571994fd383?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540&q=80",
        name2: "July"),
    List3(
        image2:
            "https://media.istockphoto.com/photos/london-in-autumn-time-concept-with-a-person-holding-a-british-in-picture-id1348042661?s=612x612",
        name2: "August"),
    List3(
        image2:
            "https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3383&q=80",
        name2: "September"),
    List3(
        image2:
            "https://images.unsplash.com/photo-1533105079780-92b9be482077?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80",
        name2: "October"),
    List3(
        image2:
            "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80",
        name2: "November"),
    List3(
        image2:
            "https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHRyYXZlbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60",
        name2: "December"),
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
    );
  }
}

class List1 {
  String? image;
  String? name;

  List1({this.image, this.name});
}

class List2 {
  String? image1;
  String? name1;

  List2({this.image1, this.name1});
}

class List3 {
  String? image2;
  String? name2;

  List3({this.image2, this.name2});
}
