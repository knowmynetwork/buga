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
            MapLayOut(),
            // Bottom Sheet for input price
            InputPriceView()
          ],
        ),
      ),
    );
  }
}
