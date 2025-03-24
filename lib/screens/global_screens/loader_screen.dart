import 'package:buga/screens/rider_view/auth_views/login_view.dart';
import 'screen_export.dart';


class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (ref.read(GetOtpService.isRiderAccountClick)) {
        // rider
        pushReplacementScreen(const RiderLoginView());
      } else {
        // driver
        pushReplacementScreen(const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightYellow,
      body: SafeArea(
        child: Container(
          color: AppColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpinKitWaveSpinner(
                color: AppColors.lightYellow,
              ),
              SizedBox(height: 3.h),
              Text(
                'Just a sec',
                style: AppTextStyle.bold(
                  FontWeight.w700,
                  fontSize: FontSize.font24,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Setting you up...',
                style: AppTextStyle.medium(
                  FontWeight.w500,
                  color: AppColors.gray,
                  fontSize: FontSize.font18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
