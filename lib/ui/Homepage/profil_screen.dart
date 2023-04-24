import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({Key? key}) : super(key: key);

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  User? _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user=FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome Back ${_user!.displayName?? ''}")),
    );
  }
}
