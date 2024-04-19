import 'dart:ui';

import 'package:flutter/material.dart';

import 'explorepageofnavigationbar.dart';

// ignore: camel_case_types
class bestdeals2 extends StatefulWidget {
  const bestdeals2({Key? key}) : super(key: key);

  @override
  State<bestdeals2> createState() => _bestdeals2State();
}

// ignore: camel_case_types
class _bestdeals2State extends State<bestdeals2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 301,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image.asset("assets/palmjumirah.png",
                              fit: BoxFit.cover),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    const explorepageofnavigationbar(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                margin: const EdgeInsets.only(top:35,left: 14,right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white54,
                                  image: const DecorationImage(
                                    image: AssetImage("assets/backwhite.png"),
                                    scale: 32,
                                  ),
                                ),
                                child: ClipRRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 52,
                              width: 52,
                              margin: const EdgeInsets.only(top:35,right:14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200.withOpacity(0.5),
                                image: const DecorationImage(
                                  image: AssetImage("assets/Heart.png"),
                                  scale: 26,
                                ),
                              ),
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
