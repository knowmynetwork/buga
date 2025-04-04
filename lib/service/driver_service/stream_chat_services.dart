// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

// class StreamChatService {
//   static final client = StreamChatClient('your_api_key', logLevel: Level.INFO);

//   static Future<void> connectUser(String userId, String token) async {
//     await client.connectUser(
//       User(id: userId, extraData: {
//         'name': userId,
//         'image': 'https://getstream.io/random_png/?id=$userId&name=$userId',
//       }),
//       token,
//     );
//   }

//   static Future<void> disconnectUser() async {
//     await client.disconnectUser();
//   }

//   static Future<Channel> createChannel(String channelId, String name) async {
//     final channel = client.channel(
//       'messaging',
//       id: channelId,
//       extraData: {'name': name},
//     );
//     await channel.watch();
//     return channel;
//   }
// }
