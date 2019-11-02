import 'package:flutter/material.dart';
import 'package:setnis/domain/event.dart';
import 'package:setnis/domain/item.dart';

class ItemsModel with ChangeNotifier {
  List<Item> _items = List<Item>();
  bool _isLoading = false;
  List<Item> get items => _items;

  bool get isLoading => _isLoading;

  void addItems(List<Item> newItems) {
    newItems.forEach((item) {
      if (!_items.contains(item)) {
        items.add(item);
      }
    });
    notifyListeners();
  }
}
