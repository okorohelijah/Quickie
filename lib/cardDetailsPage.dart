// main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// payment_screen.dart
class CardDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Text('Card');
          },
        ),
      ),
    );
  }
}
