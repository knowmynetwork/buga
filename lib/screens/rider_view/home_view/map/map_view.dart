import 'package:buga/screens/rider_view/home_view/home_export.dart';

class MapLayOut extends ConsumerWidget {
  const MapLayOut({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideDetails = ref.watch(rideDetailsProvider);
    provider = ref;
    return Stack(
      children: [
        // Map Placeholder
        Positioned.fill(
          child: Container(
            color: Colors.grey[200], // Replace with a map widget later
            child: const Center(
              child: Text(
                'Map Placeholder',
              ),
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: 50,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        // Map Markers
        Positioned(
          top: 120,
          left: 80,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.pin_drop, color: AppColors.white),
              ),
              const SizedBox(height: 4),
              Text(
                rideDetails.fromLocation,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Address Pin
        Positioned(
          bottom: 180,
          right: 60,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              rideDetails.toLocation,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
