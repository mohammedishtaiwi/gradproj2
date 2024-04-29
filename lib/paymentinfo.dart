import 'package:flutter/material.dart';
import 'package:gradproj2/filtershortdetailpage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum SingingCharacter { card, paypal, applepay, googlepay, citybank }

// ignore: camel_case_types
class paymentinfopage extends StatefulWidget {
  const paymentinfopage({Key? key}) : super(key: key);

  @override
  State<paymentinfopage> createState() => _paymentinfopageState();
}

// ignore: camel_case_types
class _paymentinfopageState extends State<paymentinfopage> {
  bool _selectedcard = false;
  bool _selectedpaypal = false;
  bool _selectedapplepay = false;
  bool _selectedgooglepay = false;
  bool _selectedcitybank = false;

  //int val = -1;
  late SingingCharacter _character = SingingCharacter.card;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchTotalAmount();
  }

  late ColorNotifire notifire;
  int totalAmount = 0;
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
                          builder: (BuildContext context) =>
                              const filtershortdetail(),
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
          "Checkout",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontFamily: 'Gilroy',
              fontSize: 18),
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
              "PAY NOW",
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
              // NAVIGATE
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select your payment method",
                style: TextStyle(
                    color: notifire.getdarkscolor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy',
                    fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    //Navigator.pushNamed(context, '/paymethodpage');
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: notifire.notificationbackground,
                      boxShadow: [
                        _selectedcard == true
                            ? BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                blurRadius: 7,
                                spreadRadius: 2,
                                offset: const Offset(0, 5),
                              )
                            : const BoxShadow(),
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: notifire.greytextColor,
                        ),
                        child: RadioListTile<SingingCharacter>(
                          controlAffinity: ListTileControlAffinity.trailing,
                          secondary: Padding(
                            padding: const EdgeInsets.only(left: 17, top: 4),
                            child: SizedBox(
                              height: 16,
                              width: 24,
                              child: Image.asset("assets/creditdebit1.png"),
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          toggleable: true,
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: 0),
                          groupValue: _character,
                          value: SingingCharacter.card,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value!;
                              _selectedcard = !_selectedcard;
                              _selectedpaypal = false;
                              _selectedapplepay = false;
                              _selectedgooglepay = false;
                              _selectedcitybank = false;
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const paymethodpage()));
                            });
                          },
                          title: Text(
                            "Credit/Debit Card",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      _selectedpaypal == true
                          ? BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 7,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            )
                          : const BoxShadow()
                    ],
                    color: notifire.notificationbackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: notifire.greytextColor,
                      ),
                      child: RadioListTile<SingingCharacter>(
                        controlAffinity: ListTileControlAffinity.trailing,
                        secondary: Padding(
                          padding: const EdgeInsets.only(left: 21, top: 4),
                          child: SizedBox(
                            height: 19,
                            width: 17,
                            child: Image.asset("assets/logos_paypal.png"),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: 0),
                        value: SingingCharacter.paypal,
                        toggleable: true,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value!;
                            _selectedpaypal = !_selectedpaypal;
                            _selectedcard = false;
                            _selectedgooglepay = false;
                            _selectedcitybank = false;
                            _selectedapplepay = false;
                          });
                        },
                        title: Text(
                          "Paypal",
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        _selectedapplepay == true
                            ? BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                blurRadius: 7,
                                spreadRadius: 2,
                                offset: const Offset(0, 5),
                              )
                            : const BoxShadow()
                      ],
                      color: notifire.notificationbackground,
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: notifire.greytextColor,
                      ),
                      child: RadioListTile<SingingCharacter>(
                        value: SingingCharacter.applepay,
                        controlAffinity: ListTileControlAffinity.trailing,
                        secondary: Padding(
                          padding: const EdgeInsets.only(left: 21, top: 1),
                          child: SizedBox(
                            height: 22,
                            width: 21,
                            child: Image.asset("assets/ia.png",
                                color: notifire.apple),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: 0),
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value!;
                            _selectedapplepay = !_selectedapplepay;
                            _selectedpaypal = false;
                            _selectedgooglepay = false;
                            _selectedcitybank = false;
                          });
                        },
                        title: Text(
                          "Apple Pay",
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 1.5),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      // fontFamily: 'Gilroy'
                    ),
                  ),
                  Text(
                    '$totalAmount',
                    style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchTotalAmount() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userSnapshot.exists) {
          List<dynamic> bookedTickets = userSnapshot['bookedTickets'];

          int total = 0;
          for (String ticketId in bookedTickets) {
            DocumentSnapshot ticketSnapshot = await FirebaseFirestore.instance
                .collection('Flights')
                .doc(ticketId)
                .get();

            if (ticketSnapshot.exists) {
              total += int.parse(ticketSnapshot['Ticket_crown_price'] ?? '0');
            }
          }

          setState(() {
            totalAmount = total;
          });
        }
      } catch (error) {
        print('Error fetching total amount: $error');
      }
    }
  }
}
