import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(nullable: false)
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

@JsonSerializable(nullable: false)
class Network {
  final String uid;
  final String name;

  Network({this.uid, this.name});

  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkToJson(this);
}
