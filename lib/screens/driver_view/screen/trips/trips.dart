import 'package:flutter/material.dart';

class RideRequestsScreen extends StatefulWidget {
  const RideRequestsScreen({super.key});

  @override
  _RideRequestsScreenState createState() => _RideRequestsScreenState();
}

class _RideRequestsScreenState extends State<RideRequestsScreen> {
  final List<Map<String, dynamic>> upcomingRides = [
    {
      'name': 'Ayomide Shobowale',
      'university': 'Covenant University',
      'location': 'Lekki Phase 1',
      'price': '\u20A612000',
      'solo': true,
      'people': 2,
      'date': '24/03/23',
      'passengerCount': 1,
      'imageUrls': ['assets/images/png/ayo.png', 'assets/images/png/ayo.png'],
    },
    {
      'name': 'AY Fadayiro',
      'university': 'Bells University',
      'location': 'Sangotedo',
      'price': '\u20A612000',
      'solo': true,
      'people': 3,
      'date': '24/03/23',
      'passengerCount': 2,
      'imageUrls': ['assets/images/png/ayo.png', 'assets/images/png/ayo.png'],
    },
  ];

  final List<Map<String, dynamic>> completedRides = [
    {
      'name': 'Ayomide Shobowale',
      'university': 'Babcock University',
      'location': 'Abule Egba',
      'price': '\u20A612000',
      'solo': true,
      'people': 2,
      'date': '24/03/23',
      'passengerCount': 1,
      'imageUrls': ['assets/images/png/ayo.png', 'assets/images/png/ayo.png'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trips'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RideList(rides: upcomingRides),
            RideList(rides: completedRides),
            RideList(rides: completedRides),
          ],
        ),
      ),
    );
  }
}

class RideList extends StatelessWidget {
  final List<Map<String, dynamic>> rides;

  const RideList({super.key, required this.rides});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  height: 52,
                  width: 52,
                  child: Stack(
                    children: List.generate(ride['imageUrls'].length, (i) {
                      return Positioned(
                        left: i * 10.0,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(ride['imageUrls'][i]),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ride['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(ride['university'],
                          style: TextStyle(color: Colors.grey)),
                      Text(ride['location']),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16, color: Colors.amber),
                          SizedBox(width: 5),
                          Text(ride['date']),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          _infoChip('Solo'),
                          _infoChip('${ride['people']}'),
                          _infoChip('5'),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(ride['price'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(fontSize: 12)),
    );
  }
}
