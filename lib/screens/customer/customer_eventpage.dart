import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class UserEventsPage extends StatefulWidget {
  const UserEventsPage({Key? key}) : super(key: key);

  @override
  _UserEventsPageState createState() => _UserEventsPageState();
}

class _UserEventsPageState extends State<UserEventsPage> {
  late Stream<QuerySnapshot> _eventsStream;
  TextEditingController _searchController = TextEditingController();
  final List<String> _surfingImages = [
    'https://i.guim.co.uk/img/media/00b982cef963949df14ea3c7b846de7ca329ac75/337_755_5344_3209/master/5344.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=9a41d90b04c5a08544ccae5ed1dd0d0a',
    'https://www.redstarsurf.com/wp-content/uploads/2022/03/The-essential-surfing-equipment.png',
    'https://www.surfnsoul.com/grafik/fotos/martin-surf-foto-inigo-oriol.jpg',
    // 'https://images.pexels.com/photos/416676/pexels-photo-416676.jpeg?cs=srgb&dl=pexels-pixabay-416676.jpg&fm=jpg'
  ];
  @override
  void initState() {
    super.initState();
    _eventsStream = FirebaseFirestore.instance.collection('events').snapshots();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _eventsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return SafeArea(
            child: Column(
              children: [
                SizedBox(height: 36),
                Center(
                  child: Text(
                    "Tourist Guide ",
                    style: TextStyle(
                      color: Color(0xff757575),
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 56,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Events',
                        hintStyle: TextStyle(
                          color: Color(0xffd0d0d0),
                          fontSize: 12,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xffe8e8e8),
                            )),
                        filled: true,
                        fillColor: Color(0xfffafafa),
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _eventsStream = FirebaseFirestore.instance
                              .collection('events')
                              .where('name', isGreaterThanOrEqualTo: value)
                              .snapshots();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 36),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final event = snapshot.data!.docs[index];
                      final randomIndex =
                          Random().nextInt(_surfingImages.length);
                      final randomImageUrl = _surfingImages[randomIndex];

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Color(0xffe7e7e7), width: 1),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 140,
                              height: 122,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.15),
                                image: DecorationImage(
                                  image: NetworkImage(randomImageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 19),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event['name'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '₹' + event['costPerPerson'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff4264ec),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    event['location'],
                                    style: TextStyle(
                                      color: Color(0xff686868),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    event['description'],
                                    style: TextStyle(
                                      color: Color(0xff686868),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
