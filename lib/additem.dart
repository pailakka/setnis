import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:setnis/model/itemsmodel.dart';
import 'package:setnis/model/positionmodel.dart';

import 'dart:developer' as developer;

final BASE_LAYER_TEMPLATES = {
  'peruskartta':
      'https://avoin-karttakuva.maanmittauslaitos.fi/avoin/wmts/1.0.0/maastokartta/default/WGS84_Pseudo-Mercator/{z}/{y}/{x}.png',
  'ortokuva': 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}',
};

class AddItemRoute extends StatefulWidget {
  String title;

  AddItemRoute({Key key, this.title}) : super(key: key);

  @override
  AddItemState createState() => AddItemState();
}

class AddItemState extends State<AddItemRoute> {
  MapController mapController;
  bool isFollowing = true;
  bool zoomChanged = false;
  LatLng itemPosition;
  String baseLayer = 'peruskartta';
  MapPosition mapCenter;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void toggleIsFollowing() {
    setState(() {
      this.isFollowing = !isFollowing;
    });
  }

  void setBaseLayer(String newBaseLayer) {
    setState(() {
      this.baseLayer = newBaseLayer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<PositionModel>(context).currentPosition;
    if (mapController != null && mapController.ready && isFollowing) {
      itemPosition =
          LatLng(currentPosition.latitude, currentPosition.longitude);
      mapController.move(itemPosition, zoomChanged ? mapController.zoom : 15);
    }

    var mapMarkers = [
      Marker(
        width: 40.0,
        height: 40.0,
        point: mapCenter != null ? mapCenter.center : LatLng(65, 27),
        builder: (ctx) => Container(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onDoubleTap: () {
              print("Center onDoubleTap");
              toggleIsFollowing();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                isFollowing ? Icons.gps_fixed : Icons.gps_not_fixed,
                color: isFollowing ? Colors.purple : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    ];

    mapMarkers.addAll(Provider.of<ItemsModel>(context)
        .items
        .where((item) => item.lat != null && item.lon != null)
        .map((item) => Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(item.lat, item.lon),
              builder: (ctx) => Container(
                child: Icon(Icons.center_focus_strong, color: Colors.red),
              ),
            ))
        .toList());

    return Scaffold(
      appBar: AppBar(
        title: Text("Lisää kohde"),
      ),
      body: Center(
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: LatLng(65, 27),
            zoom: 8.0,
            onPositionChanged: (pos, hasGesture) {
              if (mapCenter != null && pos.zoom != mapCenter.zoom) {
                zoomChanged = true;
              }
              mapCenter = pos;
            },
          ),
          layers: [
            TileLayerOptions(urlTemplate: BASE_LAYER_TEMPLATES[baseLayer]),
            MarkerLayerOptions(
              markers: mapMarkers,
            ),
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        RaisedButton(
          child: Icon(baseLayer == 'ortokuva' ? Icons.map : Icons.satellite),
          onPressed: () {
            if (baseLayer == 'ortokuva') {
              setBaseLayer('peruskartta');
            } else {
              setBaseLayer('ortokuva');
            }
          },
        ),
        RaisedButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('mapCenter: ' + mapCenter.center.toString());
            Navigator.pushNamed(context, '/additem/details',
                arguments: mapCenter.center);
          },
        )
      ]),
    );
  }
}
