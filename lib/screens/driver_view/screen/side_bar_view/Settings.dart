
import 'package:buga/constant/images.dart';
import 'package:buga/driver/onboarding/screen/side_bar_view/vehicle.dart' as bg;
import 'package:buga/route/navigation.dart';
import 'package:buga/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';





class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(color
          : AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              const SizedBox(height: 20),
              _buildSettingsOption(
                icon: Icons.insert_drive_file,
                title: 'Documents',
                onTap: () {},
              ),
              _buildSettingsOption(
                icon: Icons.directions_car,
                title: 'Vehicles',
                onTap: () {
                  navigateTo(bg.VehiclesScreen());
                },
              ),
              _buildSettingsOption(
                icon: Icons.payment,
                title: 'Payment',
                onTap: () {},
              ),
              _buildSettingsOption(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              _buildSettingsOption(
                icon: Icons.tune,
                title: 'Driver Preferences',
                onTap: () {},
              ),
              _buildSettingsOption(
                icon: Icons.delete,
                title: 'Delete Account',
                onTap: () {},
                iconColor: Colors.red,
              ),
              _buildSettingsOption(
                icon: Icons.logout,
                title: 'Log Out',
                onTap: () {},
                iconColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Oreoluwa Okunade',
              style: TextStyle(color: Colors.black,
               fontSize: 20, 
               fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'View Profile',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 40,
          child: Image.asset(
                    appLogo,
                  ),
        ),
      ],
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black),
      onTap: onTap,
    );
  }
}
