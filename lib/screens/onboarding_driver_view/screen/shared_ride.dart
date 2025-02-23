import 'package:flutter/material.dart';

class SharedRideScreen extends StatefulWidget {
  const SharedRideScreen({super.key, required String rideType});

  @override
  State<SharedRideScreen> createState() => _SharedRideScreenState();
}

class _SharedRideScreenState extends State<SharedRideScreen> {
  bool isBookRealtimeSelected = true;

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
            placeholder: 'Covenant University',
          ),
          const SizedBox(height: 8),
          _RideFormField(
            label: 'To',
            icon: Icons.location_on,
            placeholder: '46, Osapa London, Lekki, Lagos',
            hasPlusIcon: true,
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
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _SavedPlaceItem(
            icon: Icons.home,
            title: 'Home',
            subtitle: 'Lekki, Lagos',
          ),
          const Divider(),
          _SavedPlaceItem(
            icon: Icons.school,
            title: 'School',
            subtitle: 'Covenant University',
          ),
          const Divider(),
          _SavedPlaceItem(
            icon: Icons.work,
            title: 'Work',
            subtitle: 'KPMG, Victoria Island, Lagos',
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.black),
            title: const Text(
              'Add Saved Place',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Add functionality to save a new place
            },
          ),
        ],
      ),
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
  final bool hasPlusIcon;

  const _RideFormField({
    required this.label,
    required this.icon,
    required this.placeholder,
    this.hasPlusIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Icon(icon, size: 20, color: Colors.grey),
            if (label == 'From')
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: SizedBox(
                  height: 20,
                  child: VerticalDivider(color: Colors.grey, thickness: 1),
                ),
              ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              suffixIcon: hasPlusIcon
                  ? IconButton(
                      icon: const Icon(Icons.add, color: Colors.black),
                      onPressed: () {
                        // Add functionality for the "+" button
                      },
                    )
                  : null,
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

class _SavedPlaceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SavedPlaceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
    );
  }
}
