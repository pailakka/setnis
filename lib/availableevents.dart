import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setnis/domain/event.dart';
import 'package:setnis/model/appstate.dart';

var dropdownValue = "One";

class AvailableEventsWidget extends StatelessWidget {
  AvailableEventsWidget({Key key, this.events}) : super(key: key);
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: events != null
          ? DropdownButton<String>(
              hint: Text("Valitse tapahtuma"),
              value: Provider.of<AppStateModel>(context).currentEvent,
              icon: Flexible(child: Icon(Icons.arrow_downward)),
              iconSize: 24,
              elevation: 16,
              isDense: true,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              onChanged: (String newCurrentEvent) {
                Provider.of<AppStateModel>(context)
                    .setCurrentEvent(newCurrentEvent);
              },
              items: events
                  .map((event) => event.name)
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          : Text("Ei tapahtumia"),
    );
  }
}
