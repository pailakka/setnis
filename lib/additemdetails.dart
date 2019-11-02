import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';

class AddItemDetailsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LatLng itemPosition = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kohteen tiedot"),
      ),
      body: ItemDetailsForm(),
    );
  }
}

class ItemDetailsForm extends StatefulWidget {
  @override
  ItemDetailsFormState createState() {
    return ItemDetailsFormState();
  }
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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
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
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
