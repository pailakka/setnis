import 'package:flutter/material.dart';

import 'package:setnis/domain/event.dart';
import 'package:setnis/services/eventservice.dart';

class AppStateModel with ChangeNotifier {
  final EventService eventService = getEventService();

  bool _isLoggedIn = true;
  String _currentEvent = "Tapahtuma 1";
  List<Event> _events;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;

  String get currentEvent => _currentEvent;

  List<Event> get events => _events;

  bool get isLoading => _isLoading;

  void setIsloggedIn(bool loginState) {
    _isLoggedIn = loginState;
    notifyListeners();
  }

  void setCurrentEvent(String newCurrentEvent) {
    _currentEvent = newCurrentEvent;
    notifyListeners();
  }

  Future getCurrentEvents() async {
    _isLoading = true;
    List<Event> eventsData = await eventService.getEvents();

    _events = List<Event>.from(eventsData.where((event) => event.isActive));

    notifyListeners();
  }

}
