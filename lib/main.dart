import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'custom_tag.dart';
import 'location.dart';
import 'markergenerator.dart';
//import 'custom_google_map_marker'

//import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  /////custom marker part
/*
  List<Marker> customMarkers  = [];
  List<TagMap> mapMarkers = [];
/*
  Future<Uint8List> getBytesFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 120);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void addTag() async {

    Uint8List iconData = await getBytesFromAsset('lib/images/tag.png');

    final Marker help = Marker(
        markerId: MarkerId('_kLake'),
        infoWindow: InfoWindow(title: 'Info window'),
        icon: BitmapDescriptor.fromBytes(iconData),
        position: LatLng(44.8764008222759, 20.452664509665105)
    );

    setState(() {
      _markers.add(help);
      _markers.add(_kLakeMarker);
      _markers.add(_kGooglePlexMarker);
    });
    
  }
*/
  ////////////////

  List<Location> locations = [
    Location(LatLng(44.790742120042886, 20.40901182544574), "Football"),
    Location(LatLng(44.875878556519886, 20.451822821921752), "Basketball")
  ];


  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    bitmaps.asMap().forEach((i, bmp) {
      customMarkers.add(Marker(
        markerId: MarkerId('_kLake'),
        position: locations[i].coordinates,
        icon: BitmapDescriptor.fromBytes(bmp),
      ));
    });
  }

  @override
  void initState(){
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);


  }
*/
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();
  //Location _location = Location();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(44.790742120042886, 20.40901182544574),
    zoom: 18,
  );

  static final Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'Sport: Football', snippet: ' 3 players available'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(44.790742120042886, 20.40901182544574)
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(44.875878556519886, 20.451822821921752),
      tilt: 59.440717697143555,
      zoom: 20);

  static final Marker _kLakeMarker = Marker(
      markerId: MarkerId('_kLake'),
      infoWindow: InfoWindow(title: 'Sport: Basketball', snippet: '5 players available'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: LatLng(44.875878556519886, 20.451822821921752)
  );


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('SportUp'), centerTitle: true,),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: 'Search map'),
                textAlign: TextAlign.center,
                onChanged: (value){
                  print(value);
                },
              )),
              IconButton(onPressed: (){}, icon: Icon(Icons.search)),
              TextButton(onPressed: (){}, child: Text('Filters'))
            ],
          ),
          Expanded(
            child: GoogleMap (
              markers: {_kLakeMarker,_kGooglePlexMarker},
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                //addTag();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Chat :)'),
        icon: Icon(Icons.chat),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
/*
  List<Widget> markerWidgets() {
    return locations.map((l) => TagMap(l.name)).toList();
  }
*/
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}