import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/great_places.dart';
import '../screens/maps_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName ='/place-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 10),
          FlatButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapsScreen(
                  initialLocation: selectedPlace.location,
                  isSelecting: false,
                ),
              ),
            ),
            icon: Icon(Icons.map),
            label: Text('View on Map'),
            textColor: Colors.deepPurpleAccent,
          ),
        ],
      ),
    );
  }
}
