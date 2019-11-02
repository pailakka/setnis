import 'dart:convert';
import 'dart:math';

import 'package:setnis/domain/event.dart';

const EVENTS_MOCK_JSON = '''[{
		"uid": "e1",
		"name": "Tapahtuma 1",
		"isActive": true,
		"networks": [{
			"uid": "n1",
			"name": "Sähköverkko"
		}, {
			"uid": "n2",
			"name": "ICT"
		}],
		"bbox": [25, 60, 27, 61]
	},
	{
		"uid": "e2",
		"name": "Tapahtuma 2",
		"isActive": true,
		"networks": [{
			"uid": "n3",
			"name": "Sähköverkko"
		}],
		"bbox": [26, 61, 28, 62]
	},
	{
		"uid": "e3",
		"name": "Tapahtuma 3",
		"isActive": false,
		"networks": [{
			"uid": "n4",
			"name": "Sähköverkko"
		}],
		"bbox": [0, 0, 1, 1]
	}
]''';

class EventService {
  Future<List<Event>> getEvents() {
    throw UnimplementedError("Login service not yet implemented");
  }
}

class MockEventService implements EventService {
  Random rand = Random.secure();

  @override
  Future<List<Event>> getEvents() {
    return Future.delayed(
        Duration(milliseconds: (rand.nextDouble() * 500).truncate()), () {
      List<dynamic> l = json.decode(EVENTS_MOCK_JSON);
      return l.map((o) => Event.fromJson(o)).toList();
    });
  }
}

EventService getEventService() {
  return MockEventService();
}
