// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    uid: json['uid'] as String,
    parentNetwork: json['parentNetwork'] as String,
    lat: (json['lat'] as num).toDouble(),
    lon: (json['lon'] as num).toDouble(),
    notes: json['notes'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'uid': instance.uid,
      'parentNetwork': instance.parentNetwork,
      'lat': instance.lat,
      'lon': instance.lon,
      'notes': instance.notes,
    };

LineItem _$LineItemFromJson(Map<String, dynamic> json) {
  return LineItem(
    fromNode: Item.fromJson(json['fromNode'] as Map<String, dynamic>),
    toNode: Item.fromJson(json['toNode'] as Map<String, dynamic>),
  )
    ..uid = json['uid'] as String
    ..parentNetwork = json['parentNetwork'] as String
    ..lat = (json['lat'] as num).toDouble()
    ..lon = (json['lon'] as num).toDouble()
    ..notes = json['notes'] as String;
}

Map<String, dynamic> _$LineItemToJson(LineItem instance) => <String, dynamic>{
      'uid': instance.uid,
      'parentNetwork': instance.parentNetwork,
      'lat': instance.lat,
      'lon': instance.lon,
      'notes': instance.notes,
      'fromNode': instance.fromNode,
      'toNode': instance.toNode,
    };
