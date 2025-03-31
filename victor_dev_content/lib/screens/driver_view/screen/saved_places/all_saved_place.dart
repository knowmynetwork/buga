import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buga/screens/global_screens/screen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../Provider/riders/saved_places.dart';
import 'saved_place.dart';

class SavedPlacesListScreen extends ConsumerStatefulWidget {
  const SavedPlacesListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SavedPlacesListScreenState();
}

class _SavedPlacesListScreenState extends ConsumerState<SavedPlacesListScreen> {
  @override
  Widget build(BuildContext context) {
    final savedPlaces = ref.watch(getSavedPlacesProvider);
    final deleteSavedPlace = ref.read(deleteSavedPlaceProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            const Text("Saved Places", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedPlaces()),
              );
            },
          ),
        ],
      ),
      body: savedPlaces.when(
          data: (places) {
            print('here is places : $places....');

            return places.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/driver/empty_state.svg'),
                        SizedBox(height: 10),
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
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.yellow[700]!),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SavedPlaces()),
                              );
                            },
                            child: const Text("Add Place"),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(places[index].title),
                          subtitle: Text(places[index].address),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              
                              // deleteSavedPlace.repository
                              //     .deleteSavedPlace(places[index].id);

                            },
                          ),
                        ),
                      );
                    },
                  );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) {
            return Center(child: Text("Error: $error"));
          }),
    );
  }
}

// class SavedPlacesListScreen extends ConsumerWidget {
//   const SavedPlacesListScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final savedPlaces = ref.watch(getSavedPlacesProvider);
//     final deleteSavedPlace = ref.read(deleteSavedPlaceProvider);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title:
//             const Text("Saved Places", style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.yellow[700],
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () async {},
//           ),
//         ],
//       ),
//       body: savedPlaces.when(
//           data: (places) {
//             return ListView.builder(
//               itemCount: places.length,
//               itemBuilder: (context, index) {
//                 return places[index].title.isNotEmpty
//                     ? Card(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         child: ListTile(
//                           title: Text(places[index].title),
//                           subtitle: Text(places[index].address),
//                           trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {}),
//                         ),
//                       )
//                     : Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                                 'assets/icons/driver/empty_state.svg'),
//                             SizedBox(height: 10),
//                             const Text(
//                               "No saved places found.",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 40),
//                               child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       WidgetStateProperty.all<Color>(
//                                           Colors.yellow[700]!),
//                                 ),
//                                 onPressed: () {},
//                                 child: const Text("Add Place"),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//               },
//             );
//           },
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (error, _) {
//             return Center(child: Text("Error: $error"));
//           }),
//     );
  
  
//   }
// }









// class SavedPlacesListScreen extends StatefulWidget {
//   const SavedPlacesListScreen({super.key});

//   @override
//   _SavedPlacesListScreenState createState() => _SavedPlacesListScreenState();
// }

// class _SavedPlacesListScreenState extends State<SavedPlacesListScreen> {
//   List<Map<String, String>> savedPlaces = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedPlaces();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title:
//             const Text("Saved Places", style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.yellow[700],
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: _navigateToAddPlace,
//           ),
//         ],
//       ),
//       body: savedPlaces.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset('assets/icons/driver/empty_state.svg'),
//                   SizedBox(height: 10),
//                   const Text(
//                     "No saved places found.",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             WidgetStateProperty.all<Color>(Colors.yellow[700]!),
//                       ),
//                       onPressed: _navigateToAddPlace,
//                       child: const Text("Add Place"),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : 
//     );
//   }

//   Future<void> _deletePlace(int index) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> savedPlacesData = prefs.getStringList('saved_places') ?? [];

//     savedPlacesData.removeAt(index);
//     await prefs.setStringList('saved_places', savedPlacesData);

//     setState(() {
//       savedPlaces.removeAt(index);
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Place deleted successfully!")),
//     );
//   }
// }
