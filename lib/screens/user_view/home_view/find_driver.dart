import 'package:buga/screens/user_view/home_view/bottom_sheet_views/input_price_bottom_sheet.dart';
import 'home_export.dart';
import 'map/map_view.dart';

class RideDetailsScreen extends ConsumerWidget {
  const RideDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Map layout
            SizedBox(width: double.infinity, height: 55.h, child: MapLayOut()),
            Positioned(
              top: 3.h,
              left: 5.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  popScreen();
                },
              ),
            ),
            // Bottom Sheet for input price
            InputPriceView()
          ],
        ),
      ),
    );
  }
}
