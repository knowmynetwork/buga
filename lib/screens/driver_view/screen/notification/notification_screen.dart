import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Rate Your Trip",
      "message": "Thank for riding with Taiwo, Kindly give a rating and feedback to help us serve you better.",
      "time": "Today, 9:14 am",
      "isRead": false
    },
    {
      "title": "Adekoya is bidding for your trip",
      "message": "Thank for riding with Taiwo, Kindly give a rating and feedback to help us serve you better.",
      "time": "Today, 9:14 am",
      "isRead": false
    },
    {
      "title": "Add a Payment Method",
      "message": "Kindly add a payment method to enable you fund your wallet with ease.",
      "time": "2 days ago",
      "isRead": true
    },
    {
      "title": "You have been Matched",
      "message": "You have been successfully matched with a passenger going in your direction.",
      "time": "2 Feb",
      "isRead": true
    },
  ];

   NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: notification["isRead"] ? Colors.grey[200] : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                notification["title"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    notification["message"],
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 6),
                  Text(
                    notification["time"],
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow[700], size: 18),
            ),
          );
        },
      ),
    );
  }
}
