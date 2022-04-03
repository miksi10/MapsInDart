import 'dart:ui' as ui;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_flutter/screens/login_screen.dart';
import 'package:maps_flutter/screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'custom_google_map_marker'
//import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      //home: MapSample(),
      initialRoute: LoginScreen.id,
      routes: {
        MapSample.id: (context) => MapSample(),
        LoginScreen.id: (context) => LoginScreen()
      },
    );
  }
}
