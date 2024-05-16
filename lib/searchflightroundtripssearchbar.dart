import 'package:flutter/material.dart';
// ignore: duplicate_ignore
// ignore_for_file: camel_case_types

import 'package:gradproj2/searchflight.dart';

class searchflightroundtrip extends StatefulWidget {
  const searchflightroundtrip({Key? key}) : super(key: key);

  @override
  State<searchflightroundtrip> createState() => _searchflightroundtripState();
}

class _searchflightroundtripState extends State<searchflightroundtrip> {
  final to = TextEditingController();
  final from = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey)),
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
                iconSize: 20,
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const searchflight(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 98),
            const Text(
              "Search flight",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 44),
          child: Column(
            children: [
              TextField(
                controller: from,
                decoration: InputDecoration(
                  filled: false,
                  fillColor: Colors.blueAccent,
                  hintText: 'FROM',
                  labelText: 'FROM',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close_outlined,
                    ),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              TextField(
                controller: to,
                decoration: InputDecoration(
                  filled: false,
                  fillColor: Colors.blueAccent,
                  hintText: 'TO',
                  labelText: 'TO',
                  // suffixIcon:IconButton(){},
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Suggestions',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 1000,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      // ignore: prefer_const_constructors
                      return ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                          ),
                        ),
                        subtitle: const Text(
                          "hxbcjbcj",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                        title: const Text(
                          "GFG",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: const Text(
                          "SYC",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
