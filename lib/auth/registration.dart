import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marine/auth/login.dart';
import 'package:velocity_x/velocity_x.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _role;

  Future<void> registerUser(String email, String password) async {
    print(email);
    print(password);
    try {
      print('Inside try block');

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User ${userCredential.user!.uid} registered successfully');
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': _nameController.text,
        'role': _role,
      });

      if (_role == 'Admin') {
        Navigator.pushNamed(context, '/admin-dashboard');
      } else if (_role == 'User') {
        Navigator.pushNamed(context, '/dashboard');
      } else if (_role == 'Fishery') {
        Navigator.pushNamed(context, '/fishery-dashboard');
      } else if (_role == 'SuperAdmin') {
        Navigator.pushNamed(context, '/superadmin-dashboard');
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: VStack([
          Spacer(),
          "Register".text.color(Color(0xff757575)).size(20).makeCentered(),
          16.heightBox,
          Form(
            key: _formKey,
            child: VStack([
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
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
              DropdownButtonFormField(
                value: _role,
                items: [
                  DropdownMenuItem(
                    value: 'SuperAdmin',
                    child: Text('SuperAdmin'),
                  ),
                  DropdownMenuItem(
                    value: 'Admin',
                    child: Text('Admin'),
                  ),
                  DropdownMenuItem(
                    value: 'Fishery',
                    child: Text('Fishery'),
                  ),
                  DropdownMenuItem(
                    value: 'User',
                    child: Text('User'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _role = value.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select Role',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your role';
                  }
                  return null;
                },
              ),
              16.heightBox,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registerUser(_emailController.text.trim(),
                        _passwordController.text.trim());
                  }
                },
                child: "Register".text.white.make(),
              ).wFull(context)
            ]),
          ).p16().card.make(),
          SizedBox(
            height: 24,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: "Already have an account?"
                  .richText
                  .semiBold
                  .color(Color(0xff757575))
                  .withTextSpanChildren([
                " Login".textSpan.color(Color(0xff007AFF)).semiBold.make()
              ]).make(),
            ),
          ),
          Spacer(),
        ]),
      ),
    );
  }
}
