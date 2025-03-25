import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'saved_place.dart';

class SavedPlacesListScreen extends StatefulWidget {
  const SavedPlacesListScreen({super.key});

  @override
  _SavedPlacesListScreenState createState() => _SavedPlacesListScreenState();
}

class _SavedPlacesListScreenState extends State<SavedPlacesListScreen> {
  List<Map<String, String>> savedPlaces = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPlaces();
  }

  Future<void> _loadSavedPlaces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedPlacesData = prefs.getStringList('saved_places') ?? [];

    setState(() {
      savedPlaces = savedPlacesData
          .map((place) => Map<String, String>.from(jsonDecode(place)))
          .toList();
    });
  }

  void _navigateToAddPlace() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedPlaces()),
    );

    if (result == true) {
      _loadSavedPlaces();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Saved Places", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddPlace,
          ),
        ],
      ),
      body: savedPlaces.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No saved places found.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.yellow[700]!),
                      ),
                      onPressed: _navigateToAddPlace,
                      child: const Text("Add New Place"),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: savedPlaces.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(savedPlaces[index]["name"]!),
                    subtitle: Text(savedPlaces[index]["address"]!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePlace(index),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _deletePlace(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedPlacesData = prefs.getStringList('saved_places') ?? [];

    savedPlacesData.removeAt(index);
    await prefs.setStringList('saved_places', savedPlacesData);

    setState(() {
      savedPlaces.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Place deleted successfully!")),
    );
  }
}
