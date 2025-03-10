import 'package:buga/constant/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EmergencyContactForm extends StatefulWidget {
  const EmergencyContactForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmergencyContactFormState createState() => _EmergencyContactFormState();
}

class _EmergencyContactFormState extends State<EmergencyContactForm> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _emergencyContacts = [
    {
      'nameController': TextEditingController(),
      'relationshipController': TextEditingController(),
      'phoneController': TextEditingController(),
      'altPhoneController': TextEditingController(),
    }
  ];

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    for (var contact in _emergencyContacts) {
      contact['nameController']?.addListener(_onInputChanged);
      contact['relationshipController']?.addListener(_onInputChanged);
      contact['phoneController']?.addListener(_onInputChanged);
      contact['altPhoneController']?.addListener(_onInputChanged);
    }
  }

  @override
  void dispose() {
    for (var contact in _emergencyContacts) {
      contact['nameController']?.removeListener(_onInputChanged);
      contact['relationshipController']?.removeListener(_onInputChanged);
      contact['phoneController']?.removeListener(_onInputChanged);
      contact['altPhoneController']?.removeListener(_onInputChanged);
      contact['nameController']?.dispose();
      contact['relationshipController']?.dispose();
      contact['phoneController']?.dispose();
      contact['altPhoneController']?.dispose();
    }
    super.dispose();
  }

  void _onInputChanged() {
    final isAllFilled = _emergencyContacts.every((contact) =>
        contact['nameController']?.text.trim().isNotEmpty == true &&
        contact['relationshipController']?.text.trim().isNotEmpty == true &&
        contact['phoneController']?.text.trim().isNotEmpty == true &&
        contact['altPhoneController']?.text.trim().isNotEmpty == true);

    setState(() {
      isButtonEnabled = isAllFilled;
    });
  }

  void _addEmergencyContact() {
    setState(() {
      final newContact = {
        'nameController': TextEditingController(),
        'relationshipController': TextEditingController(),
        'phoneController': TextEditingController(),
        'altPhoneController': TextEditingController(),
      };
      newContact['nameController']?.addListener(_onInputChanged);
      newContact['relationshipController']?.addListener(_onInputChanged);
      newContact['phoneController']?.addListener(_onInputChanged);
      newContact['altPhoneController']?.addListener(_onInputChanged);
      _emergencyContacts.add(newContact);
    });
  }

  void _removeEmergencyContact(int index) {
    setState(() {
      _emergencyContacts[index]['nameController']
          ?.removeListener(_onInputChanged);
      _emergencyContacts[index]['relationshipController']
          ?.removeListener(_onInputChanged);
      _emergencyContacts[index]['phoneController']
          ?.removeListener(_onInputChanged);
      _emergencyContacts[index]['altPhoneController']
          ?.removeListener(_onInputChanged);
      _emergencyContacts[index]['nameController']?.dispose();
      _emergencyContacts[index]['relationshipController']?.dispose();
      _emergencyContacts[index]['phoneController']?.dispose();
      _emergencyContacts[index]['altPhoneController']?.dispose();
      _emergencyContacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    return Consumer(builder: (context, ref, _) {
      provider = ref;
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16.0 : 32.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(height: 15.0),
                      Expanded(
                        child: Text(
                          'Who would you like us to reach in case of an emergency?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Your emergency contact',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _emergencyContacts.length,
                    itemBuilder: (context, index) {
                      final contact = _emergencyContacts[index];
                      return Column(
                        children: [
                          _buildInputField(
                            label: "Contact's Name",
                            hintText: 'Name',
                            prefixIcon: Icons.person,
                            controller: contact['nameController'],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Name is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          _buildInputField(
                            label: 'Relationship with contact',
                            hintText: 'E.g Father, Mother',
                            prefixIcon: Icons.person,
                            controller: contact['relationshipController'],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Relationship is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          _buildInputField(
                            label: "Contact's Phone Number",
                            hintText: '+2340000004200',
                            prefixIcon: Icons.phone,
                            controller: contact['phoneController'],
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Phone number is required";
                              }
                              if (!RegExp(r'^\+?\d{10,15}$')
                                  .hasMatch(value.trim())) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(Icons.contacts, size: 16.0),
                              const SizedBox(width: 4.0),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Select from contacts'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          _buildInputField(
                            label: 'An alternative phone number',
                            hintText: '+2340000004200',
                            prefixIcon: Icons.phone,
                            controller: contact['altPhoneController'],
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Alternative phone number is required";
                              }
                              if (!RegExp(r'^\+?\d{10,15}$')
                                  .hasMatch(value.trim())) {
                                return "Enter a valid alternative phone number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(Icons.contacts, size: 16.0),
                              const SizedBox(width: 4.0),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Select from contacts'),
                              ),
                            ],
                          ),
                          if (index > 0) ...[
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => _removeEmergencyContact(index),
                                child: const Text('Remove contact'),
                              ),
                            ),
                          ],
                          const Divider(),
                          const SizedBox(height: 16.0),
                        ],
                      );
                    },
                  ),
                  TextButton.icon(
                    onPressed: _addEmergencyContact,
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Add another emergency contact'),
                  ),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    width: double.infinity,
                    height: 7.h,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              if (_formKey.currentState?.validate() ?? false) {}
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonEnabled
                            ? Colors.yellow[700]
                            : Colors.grey[400],
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Let's go!",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              fontWeight: FontWeight.bold,
                              color: isButtonEnabled
                                  ? Colors.black
                                  : Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Icon(
                            Icons.arrow_forward,
                            color: isButtonEnabled
                                ? Colors.black
                                : Colors.grey[700],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    IconData? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const Text(
              '*',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
