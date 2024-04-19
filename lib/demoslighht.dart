import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: passengerbuttonclick(),
  ));
}

// ignore: camel_case_types
class passengerbuttonclick extends StatefulWidget {
  const passengerbuttonclick({Key? key}) : super(key: key);

  @override
  State<passengerbuttonclick> createState() => _passengerbuttonclickState();
}

// ignore: camel_case_types
class _passengerbuttonclickState extends State<passengerbuttonclick>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = const Color(0xff1a73e8);
  //final _unselectedColor = Color(0xff5f6368);
  final _tabs = [
    const Tab(text: 'Passengers'),
    const Tab(text: 'Cabin class'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctxt) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: SizedBox(
                      height: 409,
                      width: 349,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TabBar(
                                controller: _tabController,
                                tabs: _tabs,
                                unselectedLabelColor: Colors.black,
                                isScrollable: true,
                                labelColor: _selectedColor,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  color: _selectedColor.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
