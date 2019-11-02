import 'package:json_annotation/json_annotation.dart';

import 'event.dart';

part 'item.g.dart';

@JsonSerializable(nullable: false)
class Item {
  String uid;
  Network parentNetwork;
  double lat;
  double lon;
  String notes;

  Item({this.uid, this.parentNetwork, this.lat, this.lon, this.notes});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(nullable: false)
class LineItem extends Item {
  Item fromNode;
  Item toNode;

  LineItem({this.fromNode, this.toNode});

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);

  Map<String, dynamic> toJson() => _$LineItemToJson(this);
}
