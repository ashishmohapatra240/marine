import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:marine/auth/login.dart';
import 'package:marine/auth/registration.dart';
import 'package:marine/screens/admin/admin_add_event.dart';
import 'package:marine/screens/admin/admin_dashboard.dart';
import 'package:marine/screens/admin/admin_homepage.dart';
import 'package:marine/screens/customer/customer_dashboard.dart';
import 'package:marine/screens/customer/customer_eventpage.dart';
import 'package:marine/screens/customer/customer_fish_marketplace.dart';
import 'package:marine/screens/small_fishery/fishery_dashboard.dart';
import 'package:marine/screens/small_fishery/small_fishery_grant.dart';
import 'package:marine/screens/small_fishery/small_fishery_homepage.dart';
import 'package:marine/screens/super_admin/super_admin_dashboard.dart';
import 'package:marine/screens/super_admin/super_admin_grantpage.dart';
import 'package:marine/screens/super_admin/super_admin_homepage.dart';

import 'screens/small_fishery/add_fishpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fisheries Registration',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF4264EC, {
          50: Color(0xFFE8EAF6),
          100: Color(0xFFC5CAE9),
          200: Color(0xFF9FA8DA),
          300: Color(0xFF7986CB),
          400: Color(0xFF5C6BC0),
          500: Color(0xFF4264EC),
          600: Color(0xFF3C5BDC),
          700: Color(0xFF2F51B5),
          800: Color(0xFF283593),
          900: Color(0xFF1A237E),
        }),
        primaryColor: Color(0xFF4264EC),
      ),
      routes: {
        '/': (context) => RegistrationPage().p16(),
        '/admin-home': (context) => AdminHomePage().p16(),
        '/user-events': (context) => UserEventsPage().p16(),
        '/add-event': (context) => AdminAddEventPage().p16(),
        '/fish-marketplace': (context) => FishMarketplace().p16(),
        '/add-fish': (context) => AddFishPage().p16(),
        '/fishery-dashboard': (context) => FisheryDashboard().p16(),
        '/admin-dashboard': (context) => AdminDashboard().p16(),
        '/superadmin-dashboard': (context) => SuperAdminDashboard().p16(),
        '/dashboard': (context) => UserDashboard().p16(),
        '/small-fishery-grant': (context) =>
            SmallFisheryGrantApplicationPage().p16(),
        '/superadmin-grant': (context) => SuperAdminGrantPage().p16(),
      },
      initialRoute: _auth.currentUser != null ? '/dashboard' : '/',
    );
  }
}
