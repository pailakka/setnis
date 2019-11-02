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
        ?.map((e) =>
            e == null ? null : Network.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bbox: (json['bbox'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
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

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) {
  return InventoryItem(
    itemtype: _$enumDecodeNullable(_$ItemTypeEnumMap, json['itemtype']),
    vendor: json['vendor'] as String,
    type: json['type'] as String,
    model: json['model'] as String,
  );
}

Map<String, dynamic> _$InventoryItemToJson(InventoryItem instance) =>
    <String, dynamic>{
      'itemtype': _$ItemTypeEnumMap[instance.itemtype],
      'vendor': instance.vendor,
      'type': instance.type,
      'model': instance.model,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ItemTypeEnumMap = {
  ItemType.POINT: 'POINT',
  ItemType.LINE: 'LINE',
};

Network _$NetworkFromJson(Map<String, dynamic> json) {
  return Network(
    uid: json['uid'] as String,
    name: json['name'] as String,
    inventory: (json['inventory'] as List)
        ?.map((e) => e == null
            ? null
            : InventoryItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'inventory': instance.inventory,
    };
