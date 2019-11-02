import 'package:flutter/material.dart';

import 'package:setnis/domain/event.dart';
import 'package:setnis/services/eventservice.dart';

class AppStateModel with ChangeNotifier {
  final EventService eventService = getEventService();

  bool _isLoggedIn = false;
  String _currentEvent;
  String _currentNetwork;
  List<Event> _events;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;

  Event get currentEvent => events != null
      ? events.firstWhere((Event e) => e.name == _currentEvent, orElse: () => null)
      : null;

  Network get currentNetwork => currentEvent != null
      ? currentEvent.networks
          .firstWhere((Network n) => n.name == _currentNetwork, orElse: () => null)
      : null;

  List<Event> get events => _events;

  bool get isLoading => _isLoading;

  void setIsloggedIn(bool loginState) {
    _isLoggedIn = loginState;
    notifyListeners();
  }

  void setCurrentEvent(String newCurrentEvent) {
    _currentEvent = newCurrentEvent;
    _currentNetwork = null;
    notifyListeners();
  }

  void setCurrentNetwork(String newCurrentNetwork) {
    _currentNetwork = newCurrentNetwork;
    notifyListeners();
  }

  Future getCurrentEvents() async {
    _isLoading = true;
    List<Event> eventsData = await eventService.getEvents();

    _events = List<Event>.from(eventsData.where((event) => event.isActive));

    notifyListeners();
  }
}
