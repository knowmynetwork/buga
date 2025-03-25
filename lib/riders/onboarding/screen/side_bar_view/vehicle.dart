
import 'package:buga/riders/onboarding/screen/export.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Vehicles',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Saloon"),
            VehicleCard(
              title: "Toyota Camry",
              details: "Black, 2010",
              imagePath: dLogo,
              isSelected: true,
            ),
            VehicleCard(
              title: "Toyota Corolla",
              details: "Silver, 2010",
              imagePath: colollaImg,
              isSelected: false,
            ),
            const AddVehicleButton(),
            const Divider(thickness: 1, height: 40),
            const SectionTitle(title: "Jeeps/SUV/Minibus"),
            VehicleCard(
              title: "Toyota Sienna",
              details: "Black, 2010",
              imagePath: siennaImg ,
              isSelected: true,
            ),
            VehicleCard(
              title: "Toyota Corolla",
              details: "Silver, 2010",
              imagePath: colollaImg ,
              isSelected: false,
            ),
            const AddVehicleButton(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final String title;
  final String details;
  final String imagePath;
  final bool isSelected;

  const VehicleCard({super.key, 
    required this.title,
    required this.details,
    required this.imagePath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isSelected ? Colors.yellow : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          details,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.yellow)
            : null,
      ),
    );
  }
}

class AddVehicleButton extends StatelessWidget {
  const AddVehicleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        // Add vehicle action
      },
      icon: const Icon(Icons.add_circle, color: Colors.black),
      label: const Text(
        "Add Vehicle",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
