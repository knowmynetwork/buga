import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Provider/driver_provider/routes_provider.dart';
import '../../../Provider/driver_provider/saved_places.dart';
import '../../../constant/snackbar_view.dart';
import '../../../viewmodels/drivermodel/add_route_model.dart';
import 'custom_route.dart';

class AddDriverRoute extends ConsumerStatefulWidget {
  const AddDriverRoute({super.key});

  @override
  _AddDriverRouteState createState() => _AddDriverRouteState();
}

class _AddDriverRouteState extends ConsumerState<AddDriverRoute> {
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

  void submitTabOne() async {
    if (fromAddressId != null && toAddressId != null && amount != 0) {
      final data = RouteModel(
        fromAddressId: fromAddressId ?? '',
        toAddressId: toAddressId ?? '',
        amount: amount,
        daysOfTravel: selectedDaysTab1,
      );
      print(data.toJson());
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: loadingAnimation(),
            );
          });

      await ref.read(addRoutesProvider).call(data).then((val) {
        Navigator.pop(context);
        SnackBarView.showSnackBar('Route Added successfully!');
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all fields."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
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
    final savedPlaces = ref.watch(getSavedPlacesProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Route"),
          bottom: TabBar(
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: "Saved Places"),
              Tab(text: "Choose Location"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab One migrate it to saved places screen later
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
                  SizedBox(height: 7),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.only(left: 5),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: fromAddressId,
                      borderRadius: BorderRadius.circular(10),
                      underline: SizedBox.shrink(),
                      hint: Text(" From "),
                      onChanged: (value) =>
                          setState(() => fromAddressId = value),
                      items: savedPlaces.value
                          ?.where((place) => place.id != toAddressId)
                          .map((place) => DropdownMenuItem(
                              value: place.id, child: Text(place.name)))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.only(left: 5),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: toAddressId,
                      underline: SizedBox.shrink(),
                      hint: Text(" To "),
                      onChanged: (value) => setState(() => toAddressId = value),
                      items: savedPlaces.value
                          ?.where((place) => place.id != fromAddressId)
                          .map((place) => DropdownMenuItem(
                              value: place.id, child: Text(place.name)))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => amount = double.tryParse(val) ?? 0,
                  ),
                  SizedBox(height: 10),
                  MultiSelectDialogField(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    items:
                        daysOfWeek.map((e) => MultiSelectItem(e, e)).toList(),
                    title: Text("Days of Travel"),
                    onConfirm: (values) =>
                        setState(() => selectedDaysTab1 = values),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: submitTabOne,
                    child: Text("Submit"),
                  )
                ],
              ),
            ),

            CustomRoute(),
          ],
        ),
      ),
    );
  }
}
