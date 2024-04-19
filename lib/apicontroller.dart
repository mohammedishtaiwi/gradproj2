import 'dart:convert';

import 'package:get/get.dart';
import 'package:gradproj2/apiwrapper.dart';
import 'package:gradproj2/bottomnavigationbar.dart';
import 'package:http/http.dart' as http;

class ApiServices extends GetxController {
  static userregister(String? name, email, password) {
    apiwrapper.datapost("http://15.207.163.218/event/eapi/e_reg_user.php").then(
      (val) {
        if ((val != null) && (val.isnotEmpty)) {
          if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
            // Data.fromJson(val["UserLogin"]);
            //log(val.toString() name: "name ==>");
            Get.to(() => const BottomNav(), duration: Duration.zero);
            ApiServices.showToastMessage(val["ResponseMsg"]);
          } else {
            ApiServices.showToastMessage(val["ResponseMsg"]);
          }
        }
      },
    );
  }

  static void showToastMessage(val) {}
}

userlogin() async {
  var headers = {
    'Content-Type': 'application/json',
    'Cookie': 'PHPSESSID=4pm95v3eemofqlltrg5aaj0uf2'
  };
  var request = http.Request(
      'POST', Uri.parse('http://15.207.163.218/event/eapi/e_login_user.php?'));
  request.body = json.encode({"mobile": "9284798223", "password": "123"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // ignore: avoid_print
    print(await response.stream.bytesToString());
  } else {
    // ignore: avoid_print
    print(response.reasonPhrase);
  }
}
