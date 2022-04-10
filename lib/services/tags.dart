import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_flutter/location.dart';

import '../screens/login_screen.dart';

class tag{

  static void getDataFromTags() async {
    final tagovi = await LoginScreen.firestore.collection("tags").get();
    for(var mess in tagovi.docs){
      print('regulatno citanje iz baze ' + mess["sport"]);
      locations.add(Location(LatLng(mess["latitude"],mess["longitude"]), mess["sport"], Colors.green, mess["number"]));
    }
  }

  //function for listening firebase
  static void getSnapshotsTags() async{
    int i = 0;
    await for (var snap in LoginScreen.firestore.collection("tags").snapshots()){
      locations.clear();
      for(var mess in snap.docs){
        print("snapshot citanje: " + mess["sport"] + " " + mess["number"].toString());
        locations.add(Location(LatLng(mess["latitude"],mess["longitude"]), mess["sport"], Colors.green, mess["number"]));
      }
      i++;
      print("novi krug citanja: " + i.toString());
    }
  }

  static void addNewTag(double latitude, double longitude, String sport) async {

    LoginScreen.firestore.collection("tags").add({
      'latitude': latitude,
      'longitude': longitude,
      'number': 1,
      'sport': sport
    });
  }


}
