import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final LatLng coordinates;
  final String name;
  final Color color;
  int players;
  Location(this.coordinates, this.name, this.color, this.players);

  void addPlayer(){
    this.players++;
  }

}

/*
List<Location> locations = [
  Location(LatLng(44.790742120042886, 20.40901182544574), "Football", Colors.green, 5),
  Location(LatLng(44.875878556519886, 20.451822821921752), "Basketball", Colors.orange, 4),
  Location(LatLng(44.87627640889065, 20.453287152817417), "Volleyball", Colors.yellow, 7),
  Location(LatLng(44.790250893684636, 20.40762728792962), "Tennis", Colors.red, 1),
  Location(LatLng(44.78855882366062, 20.406334846421164), "Running", Colors.blue, 2),
];
*/

List<Location> locations = [
  Location(LatLng(44.790250893684636, 20.40762728792962), "Tennis", Colors.red, 1)
];

