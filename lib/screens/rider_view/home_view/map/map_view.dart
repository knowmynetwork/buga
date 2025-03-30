import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buga/screens/rider_view/home_view/home_export.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'map_model.dart';

class MapLayOut extends ConsumerStatefulWidget {
  const MapLayOut({super.key});

  @override
  ConsumerState<MapLayOut> createState() => _MapLayOutState();
}

class _MapLayOutState extends ConsumerState<MapLayOut> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  CameraPosition? initialPosition;
  bool isMapReady = false;

  // Location related variables
  LocationData? currentPosition;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          isMapReady = false;
        });
        return;
      }
    }

    // Check location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          isMapReady = false;
        });
        return;
      }
    }

    try {
      currentPosition = await location.getLocation();
      debugPrint(
          'User Location - Lat: ${currentPosition!.latitude}, Long: ${currentPosition!.longitude}');
      //update user lat and long model
      ref.read(UserLatLong.userLatLongProvider.notifier).state = UserLatLong(
        userLat: currentPosition!.latitude!,
        userLong: currentPosition!.longitude!,
      );

      // Set up the map with the current location
      setState(() {
        initialPosition = CameraPosition(
          target: LatLng(
            currentPosition!.latitude!,
            currentPosition!.longitude!,
          ),
          zoom: 15,
        );

        markers.add(Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(
            currentPosition!.latitude!,
            currentPosition!.longitude!,
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ));

        isMapReady = true;
      });

      // Listen for location changes
      location.onLocationChanged.listen((LocationData currentLocation) {
        setState(() {
          currentPosition = currentLocation;

          markers.clear();
          markers.add(Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(
              currentPosition!.latitude!,
              currentPosition!.longitude!,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ));

          // Change camera to new position
          if (mapController != null) {
            mapController!.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(
                  currentPosition!.latitude!,
                  currentPosition!.longitude!,
                ),
              ),
            );
          }
        });
      });
    } catch (e) {
      debugPrint('Error getting current location: $e');
      setState(() {
        isMapReady = false;
      });
    }
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });

    // Focus camera on user's location
    if (initialPosition != null) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: initialPosition!.target,
            zoom: 17,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = ref;
    if (!isMapReady || initialPosition == null) {
      return SizedBox(
        width: 50,
        child: Center(
          child: SpinKitWaveSpinner(
            color: AppColors.yellow,
          ),
        ),
      );
    }

    return GoogleMap(
      initialCameraPosition: initialPosition!,
      mapType: MapType.terrain,
      onMapCreated: onMapCreated,
      markers: markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
