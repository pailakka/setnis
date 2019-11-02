// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    uid: json['uid'] as String,
    name: json['name'] as String,
    networks: (json['networks'] as List)
        .map((e) => Network.fromJson(e as Map<String, dynamic>))
        .toList(),
    bbox: (json['bbox'] as List).map((e) => (e as num).toDouble()).toList(),
    isActive: json['isActive'] as bool,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'networks': instance.networks,
      'bbox': instance.bbox,
      'isActive': instance.isActive,
    };

Network _$NetworkFromJson(Map<String, dynamic> json) {
  return Network(
    uid: json['uid'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
    };
