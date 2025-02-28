import 'package:flutter/material.dart';

class RideOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const RideOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Theme.of(context).primaryColor),
          const SizedBox(height: 10),
          Text(title,),
          const SizedBox(height: 5),
          Text(subtitle,),
        ],
      ),
    );
  }
}
