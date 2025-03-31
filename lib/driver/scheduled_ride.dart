import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class ScheduleRideScreen extends StatefulWidget {
  const ScheduleRideScreen({super.key});

  @override
  _ScheduleRideScreenState createState() => _ScheduleRideScreenState();
}

class _ScheduleRideScreenState extends State<ScheduleRideScreen> {
  final TextEditingController _startLocationController =
      TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  String _selectedTime = "Select Time";
  String _selectedDays = "Everyday";
  String _selectedFrequency = "One-time";
  final List<String> _savedPlaces = [
    "Home",
    "Work",
    "Gym"
  ]; // Example saved places

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime.format(context);
      });
    }
  }

  void _pickDays() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Days"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Everyday"),
                onTap: () {
                  setState(() {
                    _selectedDays = "Everyday";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Custom"),
                onTap: () {
                  _pickCustomDays();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickCustomDays() async {
    List<String> days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    List<String> selected = [];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Days"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: days.map((day) {
              return CheckboxListTile(
                title: Text(day),
                value: selected.contains(day),
                onChanged: (bool? checked) {
                  setState(() {
                    if (checked == true) {
                      selected.add(day);
                    } else {
                      selected.remove(day);
                    }
                  });
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedDays =
                      selected.isEmpty ? "Custom" : selected.join(", ");
                });
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  void _pickFrequency() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Frequency"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("One-time"),
                onTap: () {
                  setState(() {
                    _selectedFrequency = "One-time";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Daily"),
                onTap: () {
                  setState(() {
                    _selectedFrequency = "Daily";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Weekly"),
                onTap: () {
                  setState(() {
                    _selectedFrequency = "Weekly";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _fetchCurrentLocation(TextEditingController controller) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Location permissions are permanently denied.")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      controller.text = "Lat: ${position.latitude}, Lng: ${position.longitude}";
    });
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
                title: Text(place),
                onTap: () {
                  setState(() {
                    controller.text = place;
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

  void _submitSchedule() {
    // Here you would typically send the schedule to your backend
    // For now, we'll just show a snackbar with the details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              "Ride scheduled from ${_startLocationController.text} to ${_endLocationController.text} at $_selectedTime, $_selectedDays, $_selectedFrequency")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule a Ride"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Route Start",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _startLocationController,
                      decoration: const InputDecoration(
                        labelText: "Enter Start Location",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: () =>
                        _fetchCurrentLocation(_startLocationController),
                  ),
                  IconButton(
                    icon: const Icon(Icons.place),
                    onPressed: () => _pickSavedPlace(_startLocationController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Route End",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _endLocationController,
                      decoration: const InputDecoration(
                        labelText: "Enter End Location",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: () =>
                        _fetchCurrentLocation(_endLocationController),
                  ),
                  IconButton(
                    icon: const Icon(Icons.place),
                    onPressed: () => _pickSavedPlace(_endLocationController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text("Time: $_selectedTime"),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              ListTile(
                title: Text("Days: $_selectedDays"),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDays,
              ),
              ListTile(
                title: Text("Frequency: $_selectedFrequency"),
                trailing: const Icon(Icons.repeat),
                onTap: _pickFrequency,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitSchedule,
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
    );
  }
}
