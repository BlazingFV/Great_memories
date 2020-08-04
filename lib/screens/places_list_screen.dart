import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:great_memories/provider/great_places.dart';
import 'package:great_memories/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Your Memories'),
        trailing: CupertinoButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, dataSnapShot) => dataSnapShot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                  ),
                )
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: Text('Got no places yet,start adding some!'),
                  ),
                  builder: (ctx, greatPlacesData, ch) => greatPlacesData
                              .items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          itemCount: greatPlacesData.items.length,
                          itemBuilder: (ctx, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlacesData.items[index].image),
                            ),
                            title: Text(greatPlacesData.items[index].title),
                            subtitle: Text(
                                greatPlacesData.items[index].location.address),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PlaceDetailScreen.routeName,
                                arguments: greatPlacesData.items[index].id,
                              );
                            },
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
