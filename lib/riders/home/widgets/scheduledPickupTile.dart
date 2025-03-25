import 'package:flutter/material.dart';

class ScheduledPickupTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String price;

  const ScheduledPickupTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Fixed width for horizontal scrolling
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(subtitle, style: const TextStyle(color: Colors.black54)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 16, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(time, style: const TextStyle(fontSize: 14)),
                ],
              ),
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
