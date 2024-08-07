import 'package:flutter/material.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
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
    fetchTotalAmount();
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (BuildContext context) => const BookedTicketsPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 8),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                    iconSize: 14,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BookedTicketsPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Checkout",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
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
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  color: Colors.black),
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color.fromARGB(255, 114, 151, 172),
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
              const Text(
                "Select your payment method",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
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
                          activeColor: const Color.fromARGB(255, 63, 88, 112),
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
                        activeColor: const Color.fromARGB(255, 63, 88, 112),
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
                        activeColor: const Color.fromARGB(255, 63, 88, 112),
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
                  const Text('Total Amount',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy')),
                  Text('$totalAmount JOD',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy')),
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
              var ticketPrice = ticketSnapshot['Ticket_crown_price'];
              if (ticketPrice is int) {
                total += ticketPrice;
              } else if (ticketPrice is num) {
                total += ticketPrice.toInt();
              }
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
