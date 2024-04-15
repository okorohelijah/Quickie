import 'package:flutter/material.dart';

class Recipients extends StatefulWidget {
  const Recipients({Key? key}) : super(key: key);

  @override
  State<Recipients> createState() => _RecipientsState();
}

class _RecipientsState extends State<Recipients> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Text(
        'Recipients',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  // Add your stateful logic here
}
