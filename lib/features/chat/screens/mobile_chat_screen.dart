import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/colors.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/features/auth/controller/auth_controller.dart';
import 'package:test/features/chat/widgets/bottom_chat_field.dart';
import 'package:test/models/user_model.dart';
import 'package:test/features/chat/widgets/chat_list.dart';
import 'package:test/features/call/screens/call_pickup_screen.dart';
import 'package:test/features/call/controller/call_controller.dart';
// class MobileChatScreen extends ConsumerWidget {
//   static const String routeName = '/mobile-chat-screen';
//   final String name;
//   final String uid;
//   final bool isGroupChat;

//   const MobileChatScreen({super.key, required this.name, required this.uid,required this.isGroupChat});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         scrolledUnderElevation: 0,
//         title:isGroupChat? Text(name): StreamBuilder<UserModel>(
//           stream: ref.read(authControllerProvider).userDataById(uid),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Loader();
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name),
//                 Text(snapshot.data!.isOnline ? 'online' : 'offline',style: const TextStyle(fontSize: 13),),
//               ],
//             );
//           },
//         ),
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
//           IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
//           IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
//         ],
        
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(child: ChatList(recieverUserId: uid,isGroupChat:isGroupChat)),
//             BottomChatField(recieverUserId:uid,isGroupChat:isGroupChat),
//             //  IconButton(onPressed: (){}, icon: Icon(Icons.mic))
//           ],
//         ),
//       ),
//     );
//   }
// }


class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);

  void makeCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).makeCall(
          context,
          name,
          uid,
          profilePic,
          isGroupChat,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: isGroupChat
              ? Text(name)
              : StreamBuilder<UserModel>(
                  stream: ref.read(authControllerProvider).userDataById(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    return Column(
                      children: [
                        Text(name),
                        Text(
                          snapshot.data!.isOnline ? 'online' : 'offline',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => makeCall(ref, context),
              icon: const Icon(Icons.video_call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ],
        ),
      ),
    );
  }
}