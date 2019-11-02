import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setnis/domain/event.dart';
import 'package:setnis/model/appstate.dart';

class AvailableEventsWidget extends StatelessWidget {
  AvailableEventsWidget({Key key, this.events}) : super(key: key);
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    final currentEvent = Provider.of<AppStateModel>(context).currentEvent;
    final currentNetwork = Provider.of<AppStateModel>(context).currentNetwork;
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              events != null
                  ? DropdownButton<String>(
                      hint: Text("Valitse tapahtuma"),
                      value: currentEvent != null ? currentEvent.name : null,
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
            ],
          ),
          Row(
            children: <Widget>[
              currentEvent != null
                  ? DropdownButton<String>(
                      hint: Text("Valitse verkko"),
                      value: currentNetwork != null ? currentNetwork.name : null,
                      onChanged: (String newCurrentNetwork) {
                        Provider.of<AppStateModel>(context)
                            .setCurrentNetwork(newCurrentNetwork);
                      },
                      items: currentEvent.networks
                          .map((Network net) => net.name)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  : Text("Ei tapahtumaa valittu"),
            ],
          ),
        ],
      ),
    );
  }
}
