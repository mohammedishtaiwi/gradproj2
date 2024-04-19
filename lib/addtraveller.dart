// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gradproj2/contactinfo.dart';
import 'package:gradproj2/filtershortdetailpage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class addtraveller extends StatefulWidget {
  const addtraveller({Key? key}) : super(key: key);

  @override
  State<addtraveller> createState() => _addtravellerState();
}

// ignore: camel_case_types
class _addtravellerState extends State<addtraveller>
    with SingleTickerProviderStateMixin {
  final first_name = TextEditingController();

  final last_name = TextEditingController();
  final nationality = TextEditingController();
  final passport = TextEditingController();
  final date_of_birth = TextEditingController();
  final firstdate = DateTime(1900, 1);
  final lastdate = DateTime(2050, 12);
  DateTime selectedDate = DateTime.now();

  List<String> items = [
    'England',
    'USA',
    'India',
    'Pakistan',
    'Canada',
    'Germany',
    'Afghanistan',
    'South Africa',
  ];

  String? selectedValue;

  // List _cities = [
  //   "Cluj-Napoca",
  //   "Bucuresti",
  //   "Timisoara",
  //   "Brasov",
  //   "Constanta"
  // ];
  //
  // late List<DropdownMenuItem<String>> _dropDownMenuItems;
  // late String _currentCity;
  //
  // @override
  // void initState() {
  //   _dropDownMenuItems = getDropDownMenuItems();
  //   _currentCity = _dropDownMenuItems[0].value!;
  //   super.initState();
  // }
  //
  // List<DropdownMenuItem<String>> getDropDownMenuItems() {
  //   List<DropdownMenuItem<String>> items = [];
  //   for (String city in _cities) {
  //     items.add(
  //       DropdownMenuItem(value: city, child: Text(city)),
  //     );
  //   }
  //   return items;
  // }
  @override
  void initState() {
    // TODO: implement initState
    selectedValue = items.first;
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
          "Add travellers",
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
                  builder: (BuildContext context) => const contactinfo(),
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 37),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: first_name,
                style: TextStyle(
                    color: notifire.getgreycolor, fontFamily: "gilroy"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  hintStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                  fillColor: Colors.white,
                  hintText: 'Enter Your First Name',
                  labelText: "FIRST NAME",
                  labelStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              TextField(
                controller: last_name,
                style: TextStyle(
                    color: notifire.getgreycolor, fontFamily: "gilroy"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  hintStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                  fillColor: Colors.white,
                  hintText: 'Enter Your Last Name',
                  labelText: "LAST NAME",
                  labelStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              TextField(
                style: TextStyle(
                    fontFamily: "gilroy", color: notifire.getdarkscolor),
                controller: date_of_birth,
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: firstdate,
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: lastdate,
                  );
                  if (selectedDate != null) {
                    // ignore: avoid_print
                    print(selectedDate);
                    String formattedDate =
                        DateFormat.yMd().format(selectedDate);
                    // ignore: avoid_print
                    print(formattedDate);
                    setState(
                      () {
                        date_of_birth.text = formattedDate;
                      },
                    );
                  } else {
                    // ignore: avoid_print
                    print("Date is not selected");
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  suffixIcon: Image.asset("assets/calendar07.png", scale: 3.5),
                  hintText: 'DATE OF BIRTH',
                  hintStyle: TextStyle(
                      fontFamily: "gilroy", color: notifire.getdarkscolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 5.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      label: Text('NATIONALITY',
                          style: TextStyle(
                              fontFamily: "gilroy",
                              color: notifire.getdarkscolor)),
                      //labelText: "items",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 16.0),
                      hintText: 'Select Your Country',
                      hintStyle: TextStyle(
                          fontFamily: "gilroy", color: notifire.getdarkscolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    //isEmpty: _SelectedValue! == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedValue,
                        isDense: true,
                        isExpanded: true,
                        dropdownColor: notifire.notificationbackground,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: items.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(
                              items,
                              style: TextStyle(
                                  color: notifire.greytextColor,
                                  fontFamily: "gilroy"),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              // TextFormField(
              //   key:,
              //   controller: nationality,
              //   decoration: InputDecoration(
              //     suffixIcon: IconButton(
              //       onPressed: () {
              //         setState(
              //           () {
              //             Container(
              //               height: 100,
              //               width: 100,
              //               child: DropdownButtonHideUnderline(
              //                 child: DropdownButton2(
              //                   items: items
              //                       .map((item) => DropdownMenuItem<String>(
              //                     value: item,
              //                     child: Text(
              //                       item,
              //                       style: const TextStyle(
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.white,
              //                       ),
              //                       overflow: TextOverflow.ellipsis,
              //                     ),
              //                   ))
              //                       .toList(),
              //                   value: selectedValue,
              //                   onChanged: (value) {
              //                     setState(() {
              //                       selectedValue = value.toString();
              //                     });
              //                   },
              //                   icon: const Icon(
              //                     Icons.arrow_forward_ios_outlined,
              //                   ),
              //                   iconSize: 14,
              //                   iconEnabledColor: Colors.yellow,
              //                   iconDisabledColor: Colors.grey,
              //                   buttonHeight: 50,
              //                   buttonWidth: 160,
              //                   buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              //                   buttonDecoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(14),
              //                     border: Border.all(
              //                       color: Colors.black26,
              //                     ),
              //                     color: Colors.redAccent,
              //                   ),
              //                   dropdownMaxHeight: 200,
              //                   dropdownWidth: 200,
              //                   dropdownElevation: 8,
              //                   scrollbarRadius: const Radius.circular(40),
              //                   scrollbarThickness: 6,
              //                   scrollbarAlwaysShow: true,
              //                   offset: const Offset(-20, 0),
              //                   buttonElevation: 2,
              //                   itemHeight: 40,
              //                   itemPadding: const EdgeInsets.only(left: 14, right: 14),
              //                   dropdownPadding: null,
              //                   dropdownDecoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(14),
              //                     color: Colors.redAccent,
              //                   ),
              //                 ),
              //
              //               ),
              //             );
              //             // showCountryPicker(
              //             //   context: context,
              //             //   showPhoneCode: false,
              //             //   countryListTheme: CountryListThemeData(
              //             //     flagSize: 25,
              //             //     backgroundColor: Colors.white,
              //             //     textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              //             //     bottomSheetHeight: 500, // Optional. Country list modal height
              //             //     //Optional. Sets the border radius for the bottomsheet.
              //             //     borderRadius: const BorderRadius.only(
              //             //       topLeft: Radius.circular(20.0),
              //             //       topRight: Radius.circular(20.0),
              //             //     ),
              //             //     //Optional. Styles the search field.
              //             //     inputDecoration: InputDecoration(
              //             //       labelText: 'Search',
              //             //       hintText: 'Start typing to search',
              //             //       prefixIcon: const Icon(Icons.search),
              //             //       border: OutlineInputBorder(
              //             //         borderRadius: BorderRadius.circular(16),
              //             //         borderSide: BorderSide(
              //             //           color: const Color(0xFF8C98A8).withOpacity(0.2),
              //             //         ),
              //             //       ),
              //             //     ),
              //             //   ),
              //             //   onSelect: (Country country) => print('Select country: ${country.displayName}'),
              //             // );
              //           },
              //         );
              //       },
              //       icon: const Icon(
              //         Icons.keyboard_arrow_down_sharp,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     //hintText: 'ENTER YOUR FIRST NAME',
              //     labelText: "NATIONALITY",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 28,
              ),
              TextField(
                controller: passport,
                style: TextStyle(
                    color: notifire.getgreycolor, fontFamily: "gilroy"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  hintStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                  fillColor: Colors.white,
                  hintText: 'Enter Your Id',
                  labelText: "PASSPORT",
                  labelStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              // SizedBox(
              //   width: double.infinity,
              //   child: FloatingActionButton(
              //     elevation: 0,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12)),
              //     backgroundColor: Colors.blueAccent.shade400,
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (BuildContext context) => const contactinfo(),
              //         ),
              //       );
              //     },
              //     child: const Text(
              //       'NEXT',
              //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

// changedDropDownItem(String selectedCity) async {
//   setState(
//     () {
//       _currentCity = selectedCity;
//     },
//   );
// }
}
