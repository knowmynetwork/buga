import 'package:buga/screens/onboarding_driver_view/screen/find_driver.dart';
import 'package:flutter/material.dart';

class SharedRideScreen extends StatefulWidget {
  const SharedRideScreen({super.key, required String rideType});

  @override
  State<SharedRideScreen> createState() => _SharedRideScreenState();
}

class _SharedRideScreenState extends State<SharedRideScreen> {
  bool isBookRealtimeSelected = true;
  final List<Map<String, String>> savedPlaces =
      []; // To store "From" and "To" locations
  String fromLocation = '';
  String toLocation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD700),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Shared Ride',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTabSection(),
          const SizedBox(height: 16),
          _buildFormSection(),
          const Divider(),
          _buildSavedPlacesSection(),
          _buildProceedButton(context),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      color: const Color(0xFFFFD700),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _RideOptionButton(
            label: 'Book Realtime',
            isSelected: isBookRealtimeSelected,
            onTap: () {
              setState(() {
                isBookRealtimeSelected = true;
              });
            },
          ),
          _RideOptionButton(
            label: 'Schedule Trip',
            isSelected: !isBookRealtimeSelected,
            onTap: () {
              setState(() {
                isBookRealtimeSelected = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _RideFormField(
            label: 'From',
            icon: Icons.circle_outlined,
            placeholder:
                fromLocation.isEmpty ? 'Enter Starting Point' : fromLocation,
            isEditable: true,
            onChanged: (value) {
              setState(() {
                fromLocation = value;
              });
            },
          ),
          const SizedBox(height: 8),
          _RideFormField(
            label: 'To',
            icon: Icons.location_on,
            placeholder: toLocation.isEmpty ? 'Enter Destination' : toLocation,
            isEditable: true,
            onChanged: (value) {
              setState(() {
                toLocation = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '2 Passengers',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '4 Luggage',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavedPlacesSection() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: savedPlaces.length + 1,
        itemBuilder: (context, index) {
          if (index < savedPlaces.length) {
            final location = savedPlaces[index];
            return Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.location_pin, color: Colors.black),
                  title: Text(
                    '${location['from']} → ${location['to']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        savedPlaces.removeAt(index);
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      fromLocation = location['from']!;
                      toLocation = location['to']!;
                    });
                  },
                ),
                const Divider(),
              ],
            );
          } else {
            return ListTile(
              leading: const Icon(Icons.add, color: Colors.black),
              title: const Text(
                'Add Save Place',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: _showLocationBottomSheet,
            );
          }
        },
      ),
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the next page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const RideDetailsScreen(), // Replace with your target screen
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Proceed',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8), // Add space between text and icon
            Icon(Icons.arrow_forward, color: Colors.black),
          ],
        ),
      ),
    );
  }

  void _showLocationBottomSheet() {
    final locations = [
      'Covenant University',
      'Lekki, Lagos',
      'Victoria Island',
      'Yaba, Lagos',
      'Ikoyi, Lagos',
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(locations[index]),
                onTap: () {
                  setState(() {
                    if (fromLocation.isEmpty) {
                      fromLocation = locations[index];
                    } else if (toLocation.isEmpty) {
                      toLocation = locations[index];
                    }

                    if (fromLocation.isNotEmpty && toLocation.isNotEmpty) {
                      savedPlaces.add({'from': fromLocation, 'to': toLocation});
                      fromLocation = '';
                      toLocation = '';
                    }
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _RideOptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RideOptionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _RideFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String placeholder;
  final bool isEditable;
  final Function(String)? onChanged;

  const _RideFormField({
    required this.label,
    required this.icon,
    required this.placeholder,
    this.isEditable = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            readOnly: !isEditable,
            onChanged: isEditable ? onChanged : null,
            decoration: InputDecoration(
              hintText: placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class SummaryPage extends StatelessWidget {
  final List<Map<String, String>> savedPlaces;

  const SummaryPage({super.key, required this.savedPlaces});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: ListView.builder(
        itemCount: savedPlaces.length,
        itemBuilder: (context, index) {
          final location = savedPlaces[index];
          return ListTile(
            title: Text('${location['from']} → ${location['to']}'),
          );
        },
      ),
    );
  }
}
