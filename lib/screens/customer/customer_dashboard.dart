import 'package:flutter/material.dart';
import 'package:marine/screens/admin/admin_add_event.dart';
import 'package:marine/screens/admin/admin_homepage.dart';
import 'package:marine/screens/customer/customer_eventpage.dart';
import 'package:marine/screens/customer/customer_fish_marketplace.dart';
import 'package:marine/screens/customer/customer_homepage.dart';
import 'package:marine/screens/small_fishery/add_fishpage.dart';
import 'package:marine/screens/small_fishery/small_fishery_homepage.dart';

class UserDashboard extends StatefulWidget {
  String routeName = '/dashboard';
  UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  bool alerted = false;

  int _page = 0;
  List<Widget> pages = [
    CustomerHomePage(),
    UserEventsPage(),
    FishMarketplace()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Color(0xFF4264EC),
        unselectedItemColor: Colors.grey,
        iconSize: 24,
        onTap: updatePage,
        items: [
          //Home
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0 ? Colors.grey : Colors.white,
                  ),
                ),
              ),
              child: Icon(Icons.home_rounded),
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1 ? Colors.grey : Colors.white,
                  ),
                ),
              ),
              child: Icon(Icons.description_rounded),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2 ? Colors.grey : Colors.white,
                  ),
                ),
              ),
              child: Icon(Icons.water),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
