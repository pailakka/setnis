import 'dart:convert';
import 'dart:math';

import 'package:setnis/domain/event.dart';

const EVENTS_MOCK_JSON = '''[{
		"uid": "e1",
		"name": "Tapahtuma 1",
		"isActive": true,
		"networks": [{
			"uid": "n1",
			"name": "SähköverkkoA",
			"inventory":[
				{
			    "itemtype":"POINT",
			    "vendor":"PV",
			    "type":"SVK",
			    "model":"SVK 0.9"
			  },
			  {
			    "itemtype":"POINT",
			    "vendor":"PV",
			    "type":"SVK",
			    "model":"SVK 4.0"
			  },
			  {
			    "itemtype":"POINT",
			    "vendor":"PV",
			    "type":"Keskus",
			    "model":"HK"
			  },
			  {
			    "itemtype":"LINE",
			    "vendor":"PV",
			    "type":"Jatkojohto",
			    "model":"32A 50m"
			  },
			  {
			    "itemtype":"LINE",
			    "vendor":"PV",
			    "type":"Jatkojohto",
			    "model":"32A 25m"
			  },
			  {
			    "itemtype":"LINE",
			    "vendor":"SP",
			    "type":"Jatkojohto",
			    "model":"16A 10m"
			  },
			  {
			    "itemtype":"LINE",
			    "vendor":"SP",
			    "type":"Jatkojohto",
			    "model":"16A 20m"
			  },
			  {
			    "itemtype":"POINT",
			    "vendor":"SP",
			    "type":"Keskus",
			    "model":"2x16A 1x32A"
			  }
			]
		}, {
			"uid": "n2",
			"name": "ICTA"
		}],
		"bbox": [25, 60, 27, 61]
	},
	{
		"uid": "e2",
		"name": "Tapahtuma 2",
		"isActive": true,
		"networks": [{
			"uid": "n3",
			"name": "SähköverkkoB",
			"inventory": []
		}],
		"bbox": [26, 61, 28, 62]
	},
	{
		"uid": "e3",
		"name": "Tapahtuma 3",
		"isActive": false,
		"networks": [{
			"uid": "n4",
			"name": "SähköverkkoC",
			"inventory": []
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
