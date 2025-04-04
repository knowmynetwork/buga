import 'package:flutter/material.dart';
import 'dart:convert';

class ScheduleRideScreen extends StatefulWidget {
  const ScheduleRideScreen({super.key});

  @override
  _ScheduleRideScreenState createState() => _ScheduleRideScreenState();
}

class _ScheduleRideScreenState extends State<ScheduleRideScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<String> _selectedDays = [];
  List<Map<String, dynamic>> _savedPlaces = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchSavedPlaces();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _fetchSavedPlaces() async {
    // TODO: Implement API call to fetch saved places
    // For now, we'll use dummy data
    _savedPlaces = [
      {"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6", "name": "Home"},
      {"id": "3fa85f64-5717-4562-b3fc-2c963f66afa7", "name": "Work"},
    ];
  }

  void _pickSavedPlace(TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Saved Place"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _savedPlaces.map((place) {
              return ListTile(
                title: Text(place['name']),
                onTap: () {
                  setState(() {
                    controller.text = place['name'];
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _pickDays() {
    List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Days"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: days.map((day) {
                  return CheckboxListTile(
                    title: Text(day),
                    value: _selectedDays.contains(day),
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          _selectedDays.add(day);
                        } else {
                          _selectedDays.remove(day);
                        }
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  void _submitUserSchedule() {
    final fromAddressId = _savedPlaces.firstWhere((place) => place['name'] == _startLocationController.text)['id'];
    final toAddressId = _savedPlaces.firstWhere((place) => place['name'] == _endLocationController.text)['id'];
    final amount = double.tryParse(_amountController.text) ?? 0;

    final scheduleData = {
      "fromAddressId": fromAddressId,
      "toAddressId": toAddressId,
      "amount": amount,
      "daysOfTravel": _selectedDays,
    };

    print(json.encode(scheduleData));
    // TODO: Send this data to the backend
  }

  void _submitDriverSchedule() {
    final startLocation = {
      "title": _startLocationController.text,
      "address": _startLocationController.text,
      // Add other fields as needed
    };

    final endLocation = {
      "title": _endLocationController.text,
      "address": _endLocationController.text,
      // Add other fields as needed
    };

    final price = double.tryParse(_priceController.text) ?? 0;

    final scheduleData = {
      "startLocation": startLocation,
      "endLocation": endLocation,
      "price": price,
      "daysOfWeek": _selectedDays,
    };

    print(json.encode(scheduleData));
    // TODO: Send this data to the backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule a Ride"),
        backgroundColor: Colors.blueAccent,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "User"),
            Tab(text: "Driver"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // User Tab
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("From", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _startLocationController,
                          decoration: const InputDecoration(
                            labelText: "Choose start location",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.place),
                        onPressed: () => _pickSavedPlace(_startLocationController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text("To", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _endLocationController,
                          decoration: const InputDecoration(
                            labelText: "Choose end location",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.place),
                        onPressed: () => _pickSavedPlace(_endLocationController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Text("Days: ${_selectedDays.join(", ")}"),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: _pickDays,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitUserSchedule,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Schedule Ride"),
                  ),
                ],
              ),
            ),
          ),
          // Driver Tab
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("From", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _startLocationController,
                    decoration: const InputDecoration(
                      labelText: "Enter start location",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("To", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _endLocationController,
                    decoration: const InputDecoration(
                      labelText: "Enter end location",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: "Price",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Text("Days: ${_selectedDays.join(", ")}"),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: _pickDays,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitDriverSchedule,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Schedule Ride"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
