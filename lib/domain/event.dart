import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

enum ItemType { POINT, LINE }

@JsonSerializable(nullable: true)
class Event {
  final String uid;
  final String name;
  final List<Network> networks;
  final List<double> bbox;
  final bool isActive;

  Event({this.uid, this.name, this.networks, this.bbox, this.isActive});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable(nullable: true)
class InventoryItem {
  final ItemType itemtype;
  final String vendor;
  final String type;
  final String model;

  InventoryItem({this.itemtype, this.vendor, this.type, this.model});

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return "InventoryItem: itemtype: $itemtype, vendor: $vendor, type: $type, model: $model";
  }
}

@JsonSerializable(nullable: true)
class Network {
  final String uid;
  final String name;
  final List<InventoryItem> inventory;

  Network({this.uid, this.name, this.inventory});

  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkToJson(this);
}
