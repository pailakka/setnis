import 'package:flutter/material.dart';

import 'domain/item.dart';

class ItemHandlingRoute extends StatelessWidget {
  final Item item;
  const ItemHandlingRoute({this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.uid),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
