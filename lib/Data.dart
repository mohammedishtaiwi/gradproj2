// ignore_for_file: file_names

class Data {
  Data({
    required this.name,
    required this.email,
    required this.mobile,
    required this.ccode,
    required this.password,
    required this.refercode,
   });

  Data.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    ccode = json['ccode'];
    password = json['password'];
    refercode = json['refercode'];
  }

  late String name;
  late String email;
  late String mobile;
  late String ccode;
  late String password;
  late String refercode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['ccode'] = ccode;
    map['password'] = password;
    map['refercode'] = refercode;
    return map;
  }
}
