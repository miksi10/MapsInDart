
import 'dart:typed_data';
import 'package:maps_flutter/screens/login_screen.dart';
import 'package:maps_flutter/services/tags.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:maps_flutter/custom_tag.dart';
import 'package:maps_flutter/location.dart';
import 'package:maps_flutter/markergenerator.dart';

User logged;
//final _firestore = FirebaseFirestore.instance;


class MapSample extends StatefulWidget {

  static const String id = 'map_screen';



  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  String currentUserName="";

  /////custom marker part
  GoogleMapController mapController;

  final LatLng _center = const LatLng(44.83107879082054, 20.433483856048934);
  List<MapMarker> mapMarkers = [];
  List<Marker> customMarkers  = [];

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
  */

  /*
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

  /*
  List<Location> locations = [
    Location(LatLng(44.790742120042886, 20.40901182544574), "Football"),
    Location(LatLng(44.875878556519886, 20.451822821921752), "Basketball")
  ];
  */

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    bitmaps.asMap().forEach((i, bmp) {
      customMarkers.add(Marker(
        markerId: MarkerId('$i'),
        position: locations[i].coordinates,
        //infoWindow: InfoWindow(title: 'Click for more information'),
        onTap: (){
          showDialog(context: context,
              builder: (context) => AlertDialog(
                title: Text(locations[i].name),
                content: Text('You have successfully joined a group of '+ locations[i].players.toString() +' people playing '+ locations[i].name + '.\n\nGet ready to play!'),
                actions: [
                  TextButton(onPressed: (){
                    setState(() {
                      locations[i].addPlayer();
                      customMarkers.clear();
                      initState();
                    });
                    print(i);
                    print(locations[i].players);
                    Navigator.pop(context);
                  }, child: Text('OK'))
                ],
              ));
          print('Tag $i is pressed');
        },
        icon: BitmapDescriptor.fromBytes(bmp),
      ));
    });
  }

  // can not be async!
  @override
  void initState(){
    //tag.getSnapshotsTags();
    getCurrentUser();
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }

  void reloadMap(){
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }

  /*
  void getDataFromTags() async {
    final tagovi = await _firestore.collection("tags").get();
    for(var mess in tagovi.docs){
      print('citanje iz baze ' + mess["sport"]);
      locations.add(Location(LatLng(mess["latitude"],mess["longitude"]), mess["sport"], Colors.green, mess["number"]));
    }
  }
  */

  void wait() async{
    //tag.getSnapshotsTags();
    print("waiting started");
    await Future.delayed(Duration(seconds: 10));
    print("waiting ended");
  }

  void getCurrentUser() async {
    if(_auth != null){
      final user = await _auth.currentUser;
      if(user != null){
        logged = user;
        print(user.email);
        currentUserName = logged.email.split("@")[0].trim();
      }
      else{
        currentUserName = "Not logged";
      }
    }
  }

  //Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();
  //Location _location = Location();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(44.790742120042886, 20.40901182544574),
    zoom: 18,
  );
  /*
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
*/
  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  String help = '';

  int selected_index = 0;

  void _onTapBottomBar(int i)
  {
    setState(() {
      if(i==4){
        showDialog(context: context, builder: (context) => AlertDialog(
            title: Text('Adding tag'),
            content: Text('Everything you need to do is to press on a map at location'
                ' where you want to tag youself and to add information about your activity '),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('OK'))]
        ));
      }
      else if(i>0){
        showDialog(context: context, builder: (context) => AlertDialog(
            title: Text('Be patient'),
            content: Text('This feature will come soon :)'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('OK'))]
        ));
      }
      selected_index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUserName),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.menu),
          onTap: (){
            print("Menu button pressed");
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Icon(Icons.logout),
              onTap: () async {
                print("logout button pressed");
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          )
        ],
      ),
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
              TextButton(onPressed: (){}, child: Text('Filters')),
              TextButton(onPressed: (){
                setState(() {
                  reloadMap();
                });

              }, child: Text('Refresh'))
            ],
          ),
          Expanded(
            child: GoogleMap (
                markers: customMarkers.toSet(),//{_kLakeMarker,_kGooglePlexMarker},
                //mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: _onMapCreated/*(GoogleMapController controller) {
                _controller.complete(controller);
                //addTag();
              }*/,
                onTap: (loc){
                  showDialog(context: context, builder: (context) => AlertDialog(
                    title: Text('Add information'),
                    content: TextField(
                      decoration: InputDecoration(
                          hintText: "Sport name"
                      ),
                      autofocus: true,
                      textAlign: TextAlign.center,
                      onChanged: (inp){
                        help = inp;
                      },
                    ),
                    actions: [
                      TextButton(onPressed: () async {
                        tag.addNewTag(loc.latitude, loc.longitude, help);
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {
                          //locations.add(Location(LatLng(loc.latitude, loc.longitude), help, Colors.purple, 1));
                          customMarkers.clear();//
                          reloadMap();
                          //initState();
                        });
                        print(help);
                        Navigator.pop(context);
                      }, child: Text('Add tag'))
                    ],
                  ));
                  print('google map pressed on ' + loc.latitude.toString() + ' ' + loc.longitude.toString());
                }
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            reloadMap();
          });
        },
        label: Text('Refresh'),
        icon: Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Buddies',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_rounded),
              label: 'Settings',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add tag',
              backgroundColor: Colors.white),
        ],
        currentIndex: selected_index,
        selectedItemColor: Colors.blueGrey,
        onTap: _onTapBottomBar,
        unselectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        unselectedFontSize: 14.0,
        selectedFontSize: 16.0,
      ),
    );
  }

  List<Widget> markerWidgets() {
    return locations.map((l) => MapMarker(l, l.color, l.players)).toList();
  }

  Widget modificateTag(int i){
    return MapMarker(locations[i], locations[i].color, locations[i].players);
  }



/*
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  */
}