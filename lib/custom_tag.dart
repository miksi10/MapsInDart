import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagMap extends StatelessWidget{

  final String name;

  TagMap(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(name),
          Text('4 players available'),
          TextButton(onPressed: (){
            print('join pressed');
          },
              child: Text('JOIN'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.yellow
          ),)
        ],
      ),
    );
  }
  
}