import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerHomePage extends StatelessWidget {
  CustomerHomePage({Key? key}) : super(key: key);
  final List<String> _waterSportsImages = [
    'https://images.hindustantimes.com/rf/image_size_960x540/HT/p2/2019/05/04/Pictures/_4e9bb3b6-6e70-11e9-be3c-d387070551cb.jpg',
    'https://i.ytimg.com/vi/a963RVz8gWk/maxresdefault.jpg',
    'https://i.ytimg.com/vi/_toEoqgYZcU/maxresdefault.jpg',
    'https://media.istockphoto.com/id/157771610/photo/fish-market.jpg?s=612x612&w=0&k=20&c=QuSghlOz6_UqmmfyVbGLLzXv9je460IZwXid9jHh-lM=',
    'https://ak.picdn.net/offset/photos/5de8082a469b183482a27fcf/medium/offset_883288.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.0),
              Center(
                  child: Text(
                "Tourist Guide ",
                style: TextStyle(
                  color: Color(0xff757575),
                  fontSize: 20,
                ),
              )),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 56,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Destination',
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
              SizedBox(height: 16.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Welcome ",
                          style: TextStyle(
                            color: Color(0xff4264ec),
                          ),
                        ),
                        TextSpan(
                          text: "Monku,",
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 16.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: 368,
                    child: Text(
                      "“ Explore from the plethora of options to make the most of your trip and don‘t miss to check out the famous water sport and shop the best variety of local fishes from the vendors ! “",
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 12,
                      ),
                    ),
                  )),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Water Sport",
                      style: TextStyle(
                        color: Color(0xff002c53),
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See more",
                        style: TextStyle(
                          color: Color(0xff929292),
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                  height: 200.0,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('events')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      List<Widget> waterSportsWidgets = [];

                      snapshot.data!.docs.forEach((document) {
                        String? eventName =
                            document.get('eventType') as String?;
                        String? eventLocation =
                            document.get('location') as String?;
                        String? eventDate =
                            document.get('availableTime') as String?;

                        Widget eventWidget = Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 300,
                              height: 158,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'https://img.olympicchannel.com/images/image/private/t_s_pog_staticContent_hero_lg_2x/f_auto/primary/ojpcg2xlihwx84ipvrcw',
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(18),
                                color: Color(0xffd9d9d9),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            eventName!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 128),
                                          Text(
                                            eventLocation!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: 263,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              eventDate!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));

                        waterSportsWidgets.add(eventWidget);
                      });

                      return Container(
                        height: 200.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: waterSportsWidgets,
                        ),
                      );
                    },
                  )),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Local Popular Fishes",
                    style: TextStyle(
                      color: Color(0xff002c53),
                      fontSize: 20,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              SizedBox(height: 8.0),
              Container(
                height: 200.0,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('fishes')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 178.15,
                                        height: 104,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 178.15,
                                              height: 168,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x0c000000),
                                                    blurRadius: 32.31,
                                                    offset: Offset(0, 18.46),
                                                  ),
                                                ],
                                                color: Color(0xff9e9e9e),
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  width: 267.44,
                                                  height: 168,
                                                  color: Color(0xff9e9e9e),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 178.15,
                                              height: 168,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://media.istockphoto.com/id/535412961/photo/great-white-sea-bream-many-saltwater-fish.jpg?b=1&s=170667a&w=0&k=20&c=WaB5-r7DpTus7l_5D3ZX0qd3KhB0KbMVc24wSkvXBDM='),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                document['fishName'],
                                                style: TextStyle(
                                                  color: Color(0xff002c53),
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(width: 108),
                                              Text(
                                                "₹" +
                                                    document['ratePerKg']
                                                        .toString(),
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
                                          Row(
                                            children: [
                                              Text(
                                                'Available Time: ',
                                                style: TextStyle(
                                                  color: Color(0xff1bb788),
                                                  fontSize: 10,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                document['availableTime'],
                                                style: TextStyle(
                                                  color: Color(0xff5c5c5c),
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "Location: Khandagiri Fish market",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
