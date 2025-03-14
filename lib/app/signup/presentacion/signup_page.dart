import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getRandomImage() {
  List<String> futuramaImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiF8fk0RT3kTqKdDr0Q2jOumAiZuYruwJMlw&s',
    'https://m.media-amazon.com/images/M/MV5BMTkwNDE4OTUxN15BMl5BanBnXkFtZTYwNzMyMjA0._V1_FMjpg_UX1000_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZURY573HtvWYcxr7duqhqMq1hy-u6a1gG5A&s',
    'https://c.files.bbci.co.uk/B14C/production/_96288354_gettyimages-673439146.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0IH2xK5Km-rr2rksgCGnQwX1Sif_Vh32AxA&s'
  ];

  final random = Random();
  return futuramaImages[random.nextInt(futuramaImages.length)];
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'createdAt': Timestamp.now(),
        'name': nameController.text.trim(),
        'photoURL': getRandomImage()
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("login", true);

      // Navigate to Home Screen after successful signup
      GoRouter.of(context).pushNamed("home");
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-up failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            const HeaderSignUpWidget(),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: const Icon(Icons.person),
                hintText: "Escriba su nombre",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email),
                hintText: "Escriba su email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock),
                hintText: "Escriba su contraseña",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: signUp,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.orange,
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSignUpWidget extends StatelessWidget {
  const HeaderSignUpWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://s3.amazonaws.com/cdn.hotglue.xyz/images/logos/firebase-auth.png",
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.contain,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Registro",
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
