import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/common/widgets/error.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/features/chat/widgets/contacts_list.dart';
import 'package:test/features/select_contacts/controller/select_contact_controller.dart';

// final selectedGroupContacts = StateProvider<List<Contact>>((ref) => []);

// class SelectContactsGroup extends ConsumerStatefulWidget {
//   const SelectContactsGroup({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _SelectContactsGroupState();
// }

// class _SelectContactsGroupState extends ConsumerState<SelectContactsGroup> {
//   List<int> selectedContactsIndex = [];

//   // void selectContact(int index, Contact contact) {
//   //   if (selectedContactsIndex.contains(index)) {
//   //     selectedContactsIndex.removeAt(index);
//   //   } else {
//   //     selectedContactsIndex.add(index);
//   //   }
//   //   setState(() {});
//   //   ref
//   //       .read(selectedGroupContacts.state)
//   //       .update((state) => [...state, contact]);
//   // }

//   void selectContact(int index, Contact contact) {
//     if (selectedContactsIndex.contains(index)) {
//       selectedContactsIndex.remove(index);
//       ref
//           .read(selectedGroupContacts.state)
//           .update((state) => state.where((c) => c.id != contact.id).toList());
//     } else {
//       selectedContactsIndex.add(index);
//       ref
//           .read(selectedGroupContacts.state)
//           .update((state) => [...state, contact]);
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ref
//         .watch(getContactsProvider)
//         .when(
//           data:
//               (contactList) => Expanded(
//                 child: ListView.builder(
//                   itemCount: contactList.length,
//                   itemBuilder: (context, index) {
//                     final contact = contactList[index];
//                     return InkWell(
//                       onTap: () => selectContact(index, contact),
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: ListTile(
//                           title: Text(
//                             contact.displayName,
//                             style: const TextStyle(fontSize: 18),
//                           ),
//                           leading:
//                               selectedContactsIndex.contains(index)
//                                   ? IconButton(
//                                     onPressed: () {},
//                                     icon: const Icon(Icons.done),
//                                   )
//                                   : null,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           error: (err, trace) => ErrorScreen(error: err.toString()),
//           loading: () => const Loader(),
//         );
//   }
// }


final selectedGroupContacts = StateProvider<List<Contact>>((ref) => []);

class SelectContactsGroup extends ConsumerStatefulWidget {
  const SelectContactsGroup({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectContactsGroupState();
}

class _SelectContactsGroupState extends ConsumerState<SelectContactsGroup> {
  List<int> selectedContactsIndex = [];

  void selectContact(int index, Contact contact) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.removeAt(index);
    } else {
      selectedContactsIndex.add(index);
    }
    setState(() {});
    ref
        .read(selectedGroupContacts.state)
        .update((state) => [...state, contact]);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getContactsProvider).when(
          data: (contactList) => Expanded(
            child: ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  return InkWell(
                    onTap: () => selectContact(index, contact),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(
                          contact.displayName,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        leading: selectedContactsIndex.contains(index)
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.done),
                              )
                            : null,
                      ),
                    ),
                  );
                }),
          ),
          error: (err, trace) => ErrorScreen(
            error: err.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}