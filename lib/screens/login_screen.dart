// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallyapp/screens/home_screen.dart';
import 'package:wallyapp/style/costants.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/bg.jpg",
                fit: BoxFit.cover,
              )),
          Container(
              margin: EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(
                "assets/logo_rounded.png",
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF000000),
              Color(0x00000000),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            kPrimaryColor,
                            kSecondaryColor,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton.icon(
                    onPressed: () {
                      signInWithGoogle().then((value) {
                        final user = value.user;
                        _db.collection("users").doc(value.user!.uid).set(
                          {
                            "name": user!.displayName,
                            "email": user.email,
                            "photoUrl": user.photoURL,
                            "lastseen": DateTime.now(),
                          },
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomeScreen())));
                        print("User Email " + value.user!.email!);
                        print("UserId " + value.user!.uid);
                      }).catchError((e) {
                        print(e.toString());
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Text(
                      "Continue with Google",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "ProductSans",
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            kPrimaryColor,
                            kSecondaryColor,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Continue with Facebook",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "ProductSans",
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    setState(() {});
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
