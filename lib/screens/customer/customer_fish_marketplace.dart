import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FishMarketplace extends StatefulWidget {
  @override
  _FishMarketplaceState createState() => _FishMarketplaceState();
}

class _FishMarketplaceState extends State<FishMarketplace> {
  List<Map<String, dynamic>> _fishData = [];
  final List<String> _fishImages = [
    'https://images.hindustantimes.com/rf/image_size_960x540/HT/p2/2019/05/04/Pictures/_4e9bb3b6-6e70-11e9-be3c-d387070551cb.jpg',
    'https://i.ytimg.com/vi/a963RVz8gWk/maxresdefault.jpg',
    'https://i.ytimg.com/vi/_toEoqgYZcU/maxresdefault.jpg',
    'https://media.istockphoto.com/id/157771610/photo/fish-market.jpg?s=612x612&w=0&k=20&c=QuSghlOz6_UqmmfyVbGLLzXv9je460IZwXid9jHh-lM=',
    'https://ak.picdn.net/offset/photos/5de8082a469b183482a27fcf/medium/offset_883288.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _loadFishData();
  }

  void _loadFishData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('fishes').get();
    final data = snapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      _fishData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 36),
            Text(
              "Fish Availability",
              style: TextStyle(
                color: Color(0xff757575),
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 56,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search local fishes',
                    hintStyle: TextStyle(
                      color: Color(0xffd0d0d0),
                      fontSize: 12,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color(0xffe7e7e7),
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xfffafafa),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                children: _fishData.map((fish) {
                  final randomIndex = Random().nextInt(_fishImages.length);
                  final randomImageUrl = _fishImages[randomIndex];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Color(0xffdddddd),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 156,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x0c000000),
                                        blurRadius: 32.31,
                                        offset: Offset(0, 18.46),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      width: 200,
                                      height: 108,
                                      child: Image.network(
                                        randomImageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  fish['fishName'],
                                  style: TextStyle(
                                    color: Color(0xff002c53),
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 48),
                                Text(
                                  '₹${fish['ratePerKg']}/kg',
                                  style: TextStyle(
                                    color: Color(0xff4264ec),
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Available Time: " + fish['availableTime'],
                              style: TextStyle(
                                color: Color(0xff1bb788),
                                fontSize: 10,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Location: ",
                                  style: TextStyle(
                                    color: Color(0xff4264ec),
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  fish['location'],
                                  style: TextStyle(
                                    color: Color(0xff5D5D5D),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
