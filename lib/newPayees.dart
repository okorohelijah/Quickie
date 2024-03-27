import 'package:flutter/material.dart';

class NewPayees extends StatefulWidget {
  const NewPayees({Key? key}) : super(key: key);

  @override
  State<NewPayees> createState() => _NewPayeesState();
}

class _NewPayeesState extends State<NewPayees> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'New Payees',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  //bank info checker

}
