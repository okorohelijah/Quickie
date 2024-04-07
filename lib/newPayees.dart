import 'package:flutter/material.dart';

// Example mapping. You should expand this according to your requirements and possibly fetch from your backend.
final Map<String, List<String>> countryPaymentMethods = {
  'USA': ['Credit Card', 'Bank Transfer'],
  'Germany': ['SEPA', 'Credit Card'],
  'Nigeria': ['Bank Transfer'],
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewPayees(),
    );
  }
}

class NewPayees extends StatefulWidget {
  @override
  _NewPayeesState createState() => _NewPayeesState();
}

class _NewPayeesState extends State<NewPayees> {
  String? _selectedCountry;
  String? _selectedPaymentMethod;
  List<String> _availablePaymentMethods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Country'),
              value: _selectedCountry,
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                  _selectedPaymentMethod = null; // Reset payment method on country change
                  _availablePaymentMethods = value != null ? countryPaymentMethods[value] ?? [] : [];
                });
              },
              items: countryPaymentMethods.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            if (_availablePaymentMethods.isNotEmpty) ...[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Payment Method'),
                value: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                    // Based on the payment method, you might want to adjust the form fields dynamically
                  });
                },
                items: _availablePaymentMethods.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              // Here, add additional fields based on the selected payment method
              // For Stripe, ensure you follow their best practices for collecting payment information securely
            ],
          ],
        ),
      ),
    );
  }
}
