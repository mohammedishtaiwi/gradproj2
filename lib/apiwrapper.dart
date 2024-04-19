// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore: camel_case_types
class apiwrapper {
  static datapost(body) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'PHPSESSID=oonu3ro0agbeiik4t0l6egt8ab'
    };
    try {
      var url = Uri.parse('http://15.207.163.218/event/eapi/e_reg_user.php');
      print('1$url');
      print('1$body');
      var request =
          await http.post(url, headers: headers, body: jsonEncode(body));
      print('2-----------------------------');
      var response = jsonDecode(request.body);
      print('3-----------------------------${request.statusCode}');
      print(request.statusCode);
      if (request.statusCode == 200) {
        print('5$response');
        return response.show;
      } else {
        print('4$response');
        return response;
      }
    } catch (e) {
      print('Exception------$e');
    }
  }

  static userlogin(body) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'PHPSESSID=4pm95v3eemofqlltrg5aaj0uf2'
    };
    var request = http.Request(
      'POST',
      Uri.parse('http://15.207.163.218/event/eapi/e_login_user.php?'),
    );
    // request.body = json.encode({
    //   "mobile": "7041494088",
    //   "password": "1233",
    //   "email": "kalsariya@gmail.com"
    // });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
