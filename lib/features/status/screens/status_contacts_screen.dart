import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/colors.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/features/status/controller/status_controller.dart';
import 'package:test/features/status/screens/status_screen.dart';
import 'package:test/models/status_model.dart';

// class StatusContactsScreen extends ConsumerWidget {
//   const StatusContactsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return FutureBuilder<List<Status>>(
//       future: ref.read(statusControllerProvider).getStatus(context),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Loader();
//         }
//         return Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               var statusData = snapshot.data![index];
//               return Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         StatusScreen.routeName,
//                         arguments: statusData,
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 8.0),
//                       child: ListTile(
//                         title: Text(statusData.username),
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(statusData.profilePic),
//                           radius: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Divider(color: dividerColor, indent: 00),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }


class StatusContactsScreen extends ConsumerWidget {
  const StatusContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Status>>(
      future: ref.read(statusControllerProvider).getStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var statusData = snapshot.data![index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      StatusScreen.routeName,
                      arguments: statusData,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        statusData.username,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          statusData.profilePic,
                        ),
                        radius: 30,
                      ),
                    ),
                  ),
                ),
                const Divider(color: dividerColor, indent: 85),
              ],
            );
          },
        );
      },
    );
  }
}