import 'package:buga/onboarding/screen/verification_screen.dart';
import 'package:flutter/material.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({Key? key}) : super(key: key);

  @override
  _EmergencyContactScreenState createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  final List<Map<String, TextEditingController>> _emergencyContacts = [
    {
      'name': TextEditingController(),
      'relationship': TextEditingController(),
      'phone': TextEditingController(),
      'alternatePhone': TextEditingController(),
    },
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _addAnotherContact() {
    setState(() {
      _emergencyContacts.add({
        'name': TextEditingController(),
        'relationship': TextEditingController(),
        'phone': TextEditingController(),
        'alternatePhone': TextEditingController(),
      });
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validateRelationship(String? value) {
    if (value == null || value.isEmpty) {
      return 'Relationship is required';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  Widget _buildContactForm(int index) {
    final contact = _emergencyContacts[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        // Contact's Name
        const Text(
          "Contact's Name",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: contact['name'],
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
            hintText: 'Name',
          ),
          validator: _validateName,
        ),

        const SizedBox(height: 16),

        // Relationship with Contact
        const Text(
          'Relationship with Contact',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: contact['relationship'],
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.people_outline),
            border: OutlineInputBorder(),
            hintText: 'E.g. Father, Mother',
          ),
          validator: _validateRelationship,
        ),

        const SizedBox(height: 16),

        // Contact's Phone Number
        const Text(
          "Contact's Phone Number",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: contact['phone'],
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.phone),
            border: const OutlineInputBorder(),
            hintText: '+2340000000000',
          ),
          validator: _validatePhoneNumber,
        ),

        const SizedBox(height: 16),

        // Alternate Phone Number
        const Text(
          'An Alternative Phone Number',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: contact['alternatePhone'],
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.phone_android),
            border: const OutlineInputBorder(),
            hintText: '+2340000000000',
          ),
          validator: _validatePhoneNumber,
        ),

        if (_emergencyContacts.length > 1)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _emergencyContacts.removeAt(index);
                });
              },
              child: const Text(
                'Remove Contact',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        const Divider(thickness: 1, height: 32),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Navigate to the next page if the form is valid
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerificationCodeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Who would you like us to reach in case of an emergency?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your emergency contact',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Emergency Contact Forms
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      _emergencyContacts.length,
                      (index) => _buildContactForm(index),
                    ),
                  ),
                ),
              ),

              // Add Another Emergency Contact Button
              TextButton.icon(
                onPressed: _addAnotherContact,
                icon: const Icon(Icons.add),
                label: const Text('Add another emergency contact'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Let's Go Button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Let's go!",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: EmergencyContactScreen()));
}
