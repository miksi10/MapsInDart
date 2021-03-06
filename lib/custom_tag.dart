import 'package:flutter/material.dart';

import 'location.dart';

class MapMarker extends StatefulWidget {
  final Location location;
  final Color color;
  final int players;
  MapMarker(this.location, this.color, this.players);

  @override
  _MapMarkerState createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 55.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 3.0, color: Colors.black),
                  top: BorderSide(width: 3.0, color: Colors.black),
                  right: BorderSide(width: 3.0, color: Colors.black),
                  left: BorderSide(width: 3.0, color: Colors.black),
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
                  decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  child: Text(
                    widget.location.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        //backgroundColor: widget.color,
                        color: Colors.white,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: 3.0, color: Colors.black),
                  left: BorderSide(width: 3.0, color: Colors.black),
                )
              ),
              child: Center(
                child: Text(
                  widget.players.toString() + ' players',
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    color: widget.color,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )),
          Container(
              child: TextButton(
                onPressed: (){
                  print(widget.location.name);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
                  decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  child: Text(
                    'JOIN',
                    style: TextStyle(
                        //backgroundColor: widget.color,
                        color: Colors.white,
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0
                  ),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14)))),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 36.0,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 3, 0.0);
    path.lineTo(size.width / 2, size.height / 3);
    path.lineTo(size.width - size.width / 3, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
