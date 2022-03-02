import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final LatLng coordinates;
  final String name;
  final Color color;
  final int players;
  Location(this.coordinates, this.name, this.color, this.players);
}

List<Location> locations = [
  Location(LatLng(44.790742120042886, 20.40901182544574), "Football", Colors.green, 5),
  Location(LatLng(44.875878556519886, 20.451822821921752), "Basketball", Colors.orange, 4)
];