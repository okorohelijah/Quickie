import 'package:flutter/material.dart';
import 'package:quickie/topNavigationBar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PanelController panelController = PanelController();
  bool showSlidingWindow = false;
  final TextEditingController _usdController = TextEditingController();
  final TextEditingController _convertedController = TextEditingController();
  String _convertedAmount = '';

  final List<String> _countries = [
    'Canada',
    'India',
    'Nigeria',
    'UK',
    'Australia'
  ];

  void updateConvertedAmount(String amount) {
    final int usdAmount = int.tryParse(amount) ?? 0;
    final int convertedAmount = usdAmount % 2 == 0 ? 100 : 50;

    // Update the read-only field to show the converted amount.
    setState(() {
      _convertedController.text = convertedAmount.toString();
    });
  }

  // void updateConvertedAmount(String amount) {
  //   final int usdAmount = int.tryParse(amount) ?? 0;
  //   final int convertedAmount = usdAmount % 2 == 0 ? 100 : 50;
  //
  //   // Update the read-only field to show the converted amount.
  //   setState(() {
  //     _convertedController.text = convertedAmount.toString();
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Stack(children: [
            Container(
              alignment: Alignment.center,
              child: OutlinedButton.icon(
                onPressed: () {
                  // make show slidingWindow true
                  setState(() {
                    showSlidingWindow = !showSlidingWindow;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ),
            if (showSlidingWindow) _slidePanel(panelController),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                    child: TextFormField(
                      controller: _convertedController,
                      decoration: const InputDecoration(
                        labelText: 'Amount in NGN',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _usdController,
                      decoration: const InputDecoration(
                        labelText: 'Amount in USD',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      onChanged: convertCurrency,
                    ),
                  ),


                ],
              ),
            )
          ]),
        ));
  }

  dynamic _slidePanel(PanelController panelController) {
    return SlidingUpPanel(
        backdropEnabled: true,
        controller: panelController,
        backdropOpacity: 0.5,
        backdropTapClosesPanel: true,
        minHeight: 50,
        maxHeight: MediaQuery
            .of(context)
            .size
            .height * 0.8,
        collapsed: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(10)),
          ),
          child: const Center(
            child: Text(
              "Recent Receipients",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        panelBuilder: (controller) =>
        const Center(
          child: TopNavigationBar(),
        ),
        body: Stack(children: <Widget>[
          GestureDetector(
            onTap: () {
              showSlidingWindow = false;
              setState(() {
                panelController.close();
              });
            },
          ),
        ]));
  }

  Future<void> convertCurrency(String amount) async {
    const String apiKey = '535c5e53c3ef093674fdcde';
    const String url = 'https://data.fixer.io/api/latest?access_key=$apiKey&base=USD&symbols=NGN,JPY,EUR';
    // 'https://data.fixer.io/api/latest
    // ? access_key = 535c5e53c3ef0087cb0da8ba674fdcde
    // & base = USD
    // & symbols = GBP,JPY,EUR''

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming you're converting to EUR for demonstration
        print(data['rates']);
        double rate = data['rates']['NGN'];
        double usdAmount = double.tryParse(amount) ?? 0.0;
        double converted = usdAmount * rate;

        setState(() {
          _convertedController.text = converted.toStringAsFixed(2);
        });
      } else {
        print('Failed to load exchange rate');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
