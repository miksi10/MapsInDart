import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_flutter/location.dart';

import '../screens/login_screen.dart';

class tag{

  static void getDataFromTags() async {
    final tagovi = await LoginScreen.firestore.collection("tags").get();
    for(var mess in tagovi.docs){
      print('citanje iz baze ' + mess["sport"]);
      locations.add(Location(LatLng(mess["latitude"],mess["longitude"]), mess["sport"], Colors.green, mess["number"]));
    }
  }

}
