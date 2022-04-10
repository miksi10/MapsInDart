import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_flutter/location.dart';
import 'package:maps_flutter/screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps_flutter/services/tags.dart';



class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';
  static final firestore = FirebaseFirestore.instance; //

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {

/*
  @override
  initState(){
    getDataFromTags();
  }
*/

  bool isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String pass = '';

  final emailController = TextEditingController();
  final passController = TextEditingController();

  void clearInput(){
    emailController.clear();
    passController.clear();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 130.0,
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
                //print(email);
              },
              decoration: InputDecoration(hintText: 'Enter your email')
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                controller: passController,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pass = value;
                  //print(pass);
                },
                decoration: InputDecoration(hintText: 'Enter your password')
            ),
            SizedBox(
              height: 15.0,
            ),
            TextButton(
                onPressed: () async{
                  print("login button pressed");
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: pass);
                    if(user != null){
                      print("znam ko je ovo");
                      setState(() {
                        isLoading = true;
                      });
                      tag.getSnapshotsTags();
                      await Future.delayed(Duration(seconds: 3));
                      Navigator.pushNamed(context, MapSample.id);
                    }
                    else{
                      print("nzm ko je ovo");
                    }
                  }
                  catch(e){
                    print("nzm ko je ovo");
                  }
                  finally{
                    clearInput();
                  }

                  //Navigator.pushNamed(context, MapSample.id);
                },
                child: isLoading ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.black26,)),
                    const SizedBox(width: 25.0,),
                    Text("Wait a second..",
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 16.0
                      ),
                    )
                  ],
                ):
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0
                  ),
                ) ,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreenAccent)
                ),
            ),
            SizedBox(
              height: 4.0,
            ),
            TextButton(
              onPressed: () async{
                print("register button pressed");
                //tag.getSnapshotsTags();
                //await Future.delayed(Duration(seconds: 5));
                //Navigator.pushNamed(context, MapSample.id);
              },
              child: Text(
                "Register",
                style: TextStyle(
                    color: Colors.black54,
                  fontSize: 18.0
                ),),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.lightGreenAccent)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
