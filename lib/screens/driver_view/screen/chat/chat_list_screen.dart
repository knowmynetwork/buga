// import 'package:flutter/material.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';
// import 'chat_screen.dart';

// class ChatListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chats")),
//       body: ChannelsBloc(
//         child: ChannelListView(
//           filter: Filter.in_('type', ['messaging']),
//           sort: [SortOption('last_message_at')],
//           onChannelTap: (channel, _) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ChatScreen(channel: channel),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
