import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marine/auth/registration.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> loginUser(String email, String password) async {
    print(email);
    print(password);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String role = await getUserRole(userCredential.user!.uid);
      print('User ${userCredential.user!.uid} logged in with role $role');
      // Navigate to the appropriate page based on user role
      if (role == 'Admin') {
        Navigator.pushNamed(context, '/admin-dashboard');
      } else if (role == 'User') {
        Navigator.pushNamed(context, '/dashboard');
      } else if (role == 'Fishery') {
        Navigator.pushNamed(context, '/fishery-dashboard');
      } else if (role == 'SuperAdmin') {
        Navigator.pushNamed(context, '/superadmin-dashboard');
      } else {
        // Default role or invalid role
        print('Invalid role: $role');
      }
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  Future<String> getUserRole(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        String? role = data?['role'] as String?;
        return role ?? 'default role';
      } else {
        // User document doesn't exist
        throw Exception('User document does not exist');
      }
    } catch (e) {
      // Error fetching user document
      print('Error fetching user document: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xff757575),
                      fontSize: 20,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Color(0xFF4264EC),
                  ),
                  child: Text('Login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      loginUser(
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                ),
                Center(
                  child: Row(
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()),
                          );
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
