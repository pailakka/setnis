import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setnis/domain/event.dart';
import 'package:setnis/domain/item.dart';
import 'package:setnis/model/appstate.dart';
import "package:collection/collection.dart";

import 'dart:developer' as developer;

class AddItemDetailsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LatLng itemPosition = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kohteen tiedot"),
      ),
      body: ItemDetailsForm(itemPosition),
    );
  }
}

class ItemDetailsForm extends StatefulWidget {
  LatLng itemPosition;

  ItemDetailsForm(this.itemPosition);

  @override
  ItemDetailsFormState createState() {
    return ItemDetailsFormState();
  }
}

String formatToDMM(double coordinate) {
  String degrees = coordinate.truncate().toString();
  String minutes = (((coordinate - coordinate.truncate()) * 60) *
          100.truncateToDouble() /
          100)
      .toStringAsFixed(3);

  return '$degrees° $minutes"';
}

// Define a corresponding State class.
// This class holds data related to the form.
class ItemDetailsFormState extends State<ItemDetailsForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String selectedVendor;
  String selectedType;
  String selectedModel;

  Item _item = Item();

  @override
  void initState() {
    super.initState();
    _item.info = InventoryItem();

  }

  InventoryItem getCurrentSelectedItem() {
    final currentNetwork = Provider.of<AppStateModel>(context).currentNetwork;
    final inventory = currentNetwork.inventory;

    return inventory.firstWhere((item) => item.vendor == selectedVendor && item.type == selectedType && item.model == selectedModel,orElse: () => null);

  }

  bool selectedModelIsLine() {
    var currentSelection = getCurrentSelectedItem();
    return currentSelection != null && currentSelection.itemtype == ItemType.LINE;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    final currentNetwork = Provider.of<AppStateModel>(context).currentNetwork;
    final inventory = currentNetwork.inventory;

    var inventoryByVendor =
        groupBy(inventory, (InventoryItem item) => item.vendor);
    var typesByVendor = mapMap(inventoryByVendor,
        key: (String k, _) => k,
        value: (String k, List<InventoryItem> items) =>
            items.map((item) => item.type).toSet().toList());

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButtonFormField(
            hint: Text("Valitse omistaja"),
            value: selectedVendor,
            items: typesByVendor.keys
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String val) {
              setState(() {
                selectedVendor = val;
                selectedType = null;
                selectedModel = null;
              });
            },
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return "Valitse omistaja";
              }
              return null;
            },
            onSaved: (String val) {
              selectedVendor = val;
            },
          ),
          DropdownButtonFormField(
            hint: Text("Valitse tyyppi"),
            value: selectedType,
            items: selectedVendor != null
                ? typesByVendor[selectedVendor]
                    .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()
                : null,
            onChanged: (String val) {
              setState(() {
                selectedType = val;
                selectedModel = null;
              });
            },
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return "Valitse tyyppi";
              }
              return null;
            },
            onSaved: (String val) {
              selectedType = val;
            },
          ),
          DropdownButtonFormField(
            hint: Text("Valitse malli"),
            value: selectedModel,
            items: selectedVendor != null && selectedType != null
                ? inventoryByVendor[selectedVendor]
                    .where((item) => item.type == selectedType)
                    .map((item) => item.model)
                    .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()
                : null,
            onChanged: (String val) {
              setState(() {
                selectedModel = val;
              });
            },
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return "Valitse malli";
              }
              return null;
            },
            onSaved: (String val) {
              selectedModel = val;
              _item.info = getCurrentSelectedItem();
              _item.lat = widget.itemPosition.latitude;
              _item.lon = widget.itemPosition.longitude;
              _item.parentNetwork = currentNetwork.uid;
            },
          ),
          Text("Kohteen koordinaatit: N" +
              formatToDMM(widget.itemPosition.latitude) +
              " E" +
              formatToDMM(widget.itemPosition.longitude)),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(labelText: 'Muistiinpanot'),
            onSaved: (String val) {
              _item.notes = val;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Tallennetaan')));

                }
              },
              child: Text('Tallenna'),
            ),
          ),
        ],
      ),
    );
  }
}
