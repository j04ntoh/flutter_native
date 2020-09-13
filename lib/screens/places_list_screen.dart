import 'package:flutter/material.dart';
import 'package:flutter_native/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = '/place-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (context, greatplaces, ch) =>
                    greatplaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: greatplaces.items.length,
                            itemBuilder: (context, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatplaces.items[i].image),
                              ),
                              title: Text(greatplaces.items[i].title),
                              subtitle:
                                  Text(greatplaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatplaces.items[i].id,
                                );
                              },
                            ),
                          ),
                child: Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
              ),
      ),
    );
  }
}
