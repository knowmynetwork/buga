import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddDriverRoute extends StatefulWidget {
  const AddDriverRoute({super.key});

  @override
  _AddDriverRouteState createState() => _AddDriverRouteState();
}

class _AddDriverRouteState extends State<AddDriverRoute> {
  final List<String> daysOfWeek = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  List<String> selectedDaysTab1 = [];
  List<String> selectedDaysTab2 = [];
  String? fromAddressId;
  String? toAddressId;
  double amount = 0;
  double price = 0;

  Map<String, dynamic>? startLocation;
  Map<String, dynamic>? endLocation;

  void submitTabOne() {
    final data = {
      "fromAddressId": fromAddressId,
      "toAddressId": toAddressId,
      "amount": amount,
      "daysOfTravel": selectedDaysTab1
    };
    print(data); // Replace with API call
  }

  void submitTabTwo() {
    final data = {
      "startLocation": startLocation,
      "endLocation": endLocation,
      "price": price,
      "daysOfWeek": selectedDaysTab2
    };
    print(data); // Replace with API call
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Driver Route"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Saved Places"),
              Tab(text: "Custom Route"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab One
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose From Saved Places',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: fromAddressId,
                    hint: Text("Select From Address"),
                    onChanged: (value) => setState(() => fromAddressId = value),
                    items: [
                      DropdownMenuItem(value: "id1", child: Text("Place 1"))
                    ], // Replace with API data
                  ),
                  DropdownButton<String>(
                    isExpanded: true,

                    value: toAddressId,
                    hint: Text("Select To Address"),
                    onChanged: (value) => setState(() => toAddressId = value),
                    items: [
                      DropdownMenuItem(value: "id2", child: Text("Place 2"))
                    ], // Replace with API data
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => amount = double.tryParse(val) ?? 0,
                  ),
                  MultiSelectDialogField(
                    items:
                        daysOfWeek.map((e) => MultiSelectItem(e, e)).toList(),
                    title: Text("Days of Travel"),
                    onConfirm: (values) =>
                        setState(() => selectedDaysTab1 = values),
                  ),
                  ElevatedButton(onPressed: submitTabOne, child: Text("Submit"))
                ],
              ),
            ),

            // Tab Two
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Select Start Location"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Select End Location"),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => price = double.tryParse(val) ?? 0,
                  ),
                  MultiSelectDialogField(
                    items:
                        daysOfWeek.map((e) => MultiSelectItem(e, e)).toList(),
                    title: Text("Days of Travel"),
                    onConfirm: (values) =>
                        setState(() => selectedDaysTab2 = values),
                  ),
                  ElevatedButton(onPressed: submitTabTwo, child: Text("Submit"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
