// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:flutter_contacts/contact.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:test/common/repositories/common_firebase_storage_repository.dart';
// import 'package:test/common/utils/utils.dart';
// import 'package:test/models/status_model.dart';
// import 'package:test/models/user_model.dart';
// import 'package:uuid/uuid.dart';

// final statusRepositoryProvider = Provider(
//   (ref) => StatusRepository(
//     firestore: FirebaseFirestore.instance,
//     auth: FirebaseAuth.instance,
//     ref: ref,
//   ),
// );

// class StatusRepository {
//   final FirebaseFirestore firestore;
//   final FirebaseAuth auth;
//   final ProviderRef ref;

//   StatusRepository({
//     required this.firestore,
//     required this.auth,
//     required this.ref,
//   });

//   void uploadStatus({
//     required String username,
//     required String profilePic,
//     required String phoneNumber,
//     required File statusImage,
//     required BuildContext context,
//   }) async {
//     try {
//       var statusId = Uuid().v1();
//       String uid = auth.currentUser!.uid;
//       String imageUrl = await ref
//           .read(commonFirebaseStorageRepositoryProvider)
//           .storeFileToFirebase('/status/$statusId$uid', statusImage);
//       List<Contact> contacts = [];
//       if (await FlutterContacts.requestPermission()) {
//         contacts = await FlutterContacts.getContacts(withProperties: true);
//       }

//       List<String> uidWhoCanSee = [];
//       for (int i = 0; i < contacts.length; i++) {
//         var userDataFirebase =
//             await firestore
//                 .collection('users')
//                 .where(
//                   'phoneNumber',
//                   isEqualTo: contacts[i].phones[0].number.replaceAll(' ', ''),
//                 )
//                 .get();

//         if (userDataFirebase.docs.isEmpty) {
//           var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
//           uidWhoCanSee.add(userData.uid);
//         }
//       }
//       List<String> statusImageUrls = [];
//       var statusesSnapshot =
//           await firestore
//               .collection('status')
//               .where('uid', isEqualTo: auth.currentUser!.uid)
//               .where(
//                 'createdAt',
//                 isLessThan: DateTime.now().subtract(Duration(hours: 24)),
//               )
//               .get();
//       if (statusesSnapshot.docs.isNotEmpty) {
//         Status status = Status.fromMap(statusesSnapshot.docs[0].data());
//         statusImageUrls = status.photoUrl;
//         statusImageUrls.add(imageUrl);
//         await firestore
//             .collection('status')
//             .doc(statusesSnapshot.docs[0].id)
//             .update({'photoUrl': statusImageUrls});
//         return;
//       } else {
//         statusImageUrls = [imageUrl];
//       }

//       Status status = Status(
//         uid: uid,
//         username: username,
//         phoneNumber: phoneNumber,
//         photoUrl: statusImageUrls,
//         createdAt: DateTime.now(),
//         profilePic: profilePic,
//         statusId: statusId,
//         whoCanSee: uidWhoCanSee,
//       );

//       await firestore.collection('status').doc(statusId).set(status.toMap());
//     } catch (e) {
//       showSnackBar(context: context, content: e.toString());
//     }
//   }
// }

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:test/common/repositories/common_firebase_storage_repository.dart';
// import 'package:test/models/status_model.dart';
// import 'package:test/models/user_model.dart';
// import 'package:uuid/uuid.dart';

// final statusRepositoryProvider = Provider(
//   (ref) => StatusRepository(
//     firestore: FirebaseFirestore.instance,
//     auth: FirebaseAuth.instance,
//     ref: ref,
//   ),
// );

// class StatusRepository {
//   final FirebaseFirestore firestore;
//   final FirebaseAuth auth;
//   final ProviderRef ref;

//   StatusRepository({
//     required this.firestore,
//     required this.auth,
//     required this.ref,
//   });

//   Future<void> uploadStatus({
//     required String username,
//     required String profilePic,
//     required String phoneNumber,
//     required File statusImage,
//   }) async {
//     try {
//       final user = auth.currentUser;
//       if (user == null) throw Exception('User not authenticated');

//       // Generate unique ID for status
//       final statusId = const Uuid().v1();
      
//       // Upload image to storage
//       final imageUrl = await ref
//           .read(commonFirebaseStorageRepositoryProvider)
//           .storeFileToFirebase('/status/$statusId${user.uid}', statusImage);

//       // Get contacts with permission handling
//       final contacts = await _getContactsWithPermission();

//       // Get UIDs of users who can see the status
//       final uidWhoCanSee = await _getVisibleUsersUids(contacts);

//       // Handle status updates or creation
//       await _handleStatusCreation(
//         userId: user.uid,
//         username: username,
//         profilePic: profilePic,
//         phoneNumber: phoneNumber,
//         imageUrl: imageUrl,
//         statusId: statusId,
//         uidWhoCanSee: uidWhoCanSee,
//       );

//     } on FirebaseException catch (e) {
//       if (e.code == 'too-many-requests') {
//         await Future.delayed(const Duration(seconds: 2));
//         return uploadStatus(
//           username: username,
//           profilePic: profilePic,
//           phoneNumber: phoneNumber,
//           statusImage: statusImage,
//         );
//       }
//       rethrow;
//     } catch (e) {
//       throw Exception('Failed to upload status: ${e.toString()}');
//     }
//   }

//   Future<List<Contact>> _getContactsWithPermission() async {
//     try {
//       if (!await FlutterContacts.requestPermission()) {
//         return [];
//       }
//       return await FlutterContacts.getContacts(withProperties: true);
//     } catch (e) {
//       return [];
//     }
//   }

//   Future<List<String>> _getVisibleUsersUids(List<Contact> contacts) async {
//     final List<String> uidWhoCanSee = [];
    
//     for (final contact in contacts) {
//       if (contact.phones.isEmpty) continue;
      
//       final phoneNumber = contact.phones.first.number.replaceAll(' ', '');
//       try {
//         final querySnapshot = await firestore
//             .collection('users')
//             .where('phoneNumber', isEqualTo: phoneNumber)
//             .limit(1)
//             .get();

//         if (querySnapshot.docs.isNotEmpty) {
//           final userData = UserModel.fromMap(querySnapshot.docs.first.data());
//           uidWhoCanSee.add(userData.uid);
//         }
//       } catch (e) {
//         continue;
//       }
//     }
//     return uidWhoCanSee;
//   }

//   Future<void> _handleStatusCreation({
//     required String userId,
//     required String username,
//     required String profilePic,
//     required String phoneNumber,
//     required String imageUrl,
//     required String statusId,
//     required List<String> uidWhoCanSee,
//   }) async {
//     // Check for existing status within 24 hours
//     final statusesSnapshot = await firestore
//         .collection('status')
//         .where('uid', isEqualTo: userId)
//         .where('createdAt', isGreaterThan: DateTime.now().subtract(const Duration(hours: 24)))
//         .limit(1)
//         .get();

//     if (statusesSnapshot.docs.isNotEmpty) {
//       // Update existing status
//       final existingStatus = Status.fromMap(statusesSnapshot.docs.first.data());
//       final updatedPhotoUrls = [...existingStatus.photoUrl, imageUrl];
      
//       await firestore
//           .collection('status')
//           .doc(statusesSnapshot.docs.first.id)
//           .update({'photoUrl': updatedPhotoUrls});
//     } else {
//       // Create new status
//       final status = Status(
//         uid: userId,
//         username: username,
//         phoneNumber: phoneNumber,
//         photoUrl: [imageUrl],
//         createdAt: DateTime.now(),
//         profilePic: profilePic,
//         statusId: statusId,
//         whoCanSee: uidWhoCanSee,
//       );
      
//       await firestore.collection('status').doc(statusId).set(status.toMap());
//     }
//   }
// }

//RR code

// final statusRepositoryProvider = Provider(
//   (ref) => StatusRepository(
//     firestore: FirebaseFirestore.instance,
//     auth: FirebaseAuth.instance,
//     ref: ref,
//   ),
// );

// class StatusRepository {
//   final FirebaseFirestore firestore;
//   final FirebaseAuth auth;
//   final ProviderRef ref;
//   StatusRepository({
//     required this.firestore,
//     required this.auth,
//     required this.ref,
//   });

//   void uploadStatus({
//     required String username,
//     required String profilePic,
//     required String phoneNumber,
//     required File statusImage,
//     required BuildContext context,
//   }) async {
//     try {
//       var statusId = const Uuid().v1();
//       String uid = auth.currentUser!.uid;
//       String imageurl = await ref
//           .read(commonFirebaseStorageRepositoryProvider)
//           .storeFileToFirebase(
//             '/status/$statusId$uid',
//             statusImage,
//           );
//       List<Contact> contacts = [];
//       if (await FlutterContacts.requestPermission()) {
//         contacts = await FlutterContacts.getContacts(withProperties: true);
//       }

//       List<String> uidWhoCanSee = [];

//       for (int i = 0; i < contacts.length; i++) {
//         var userDataFirebase = await firestore
//             .collection('users')
//             .where(
//               'phoneNumber',
//               isEqualTo: contacts[i].phones[0].number.replaceAll(
//                     ' ',
//                     '',
//                   ),
//             )
//             .get();

//         if (userDataFirebase.docs.isNotEmpty) {
//           var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
//           uidWhoCanSee.add(userData.uid);
//         }
//       }

//       List<String> statusImageUrls = [];
//       var statusesSnapshot = await firestore
//           .collection('status')
//           .where(
//             'uid',
//             isEqualTo: auth.currentUser!.uid,
//           )
//           .get();

//       if (statusesSnapshot.docs.isNotEmpty) {
//         Status status = Status.fromMap(statusesSnapshot.docs[0].data());
//         statusImageUrls = status.photoUrl;
//         statusImageUrls.add(imageurl);
//         await firestore
//             .collection('status')
//             .doc(statusesSnapshot.docs[0].id)
//             .update({
//           'photoUrl': statusImageUrls,
//         });
//         return;
//       } else {
//         statusImageUrls = [imageurl];
//       }

//       Status status = Status(
//         uid: uid,
//         username: username,
//         phoneNumber: phoneNumber,
//         photoUrl: statusImageUrls,
//         createdAt: DateTime.now(),
//         profilePic: profilePic,
//         statusId: statusId,
//         whoCanSee: uidWhoCanSee,
//       );

//       await firestore.collection('status').doc(statusId).set(status.toMap());
//     } catch (e) {
//       showSnackBar(context: context, content: e.toString());
//     }
//   }

//   Future<List<Status>> getStatus(BuildContext context) async {
//     List<Status> statusData = [];
//     try {
//       List<Contact> contacts = [];
//       if (await FlutterContacts.requestPermission()) {
//         contacts = await FlutterContacts.getContacts(withProperties: true);
//       }
//       for (int i = 0; i < contacts.length; i++) {
//         var statusesSnapshot = await firestore
//             .collection('status')
//             .where(
//               'phoneNumber',
//               isEqualTo: contacts[i].phones[0].number.replaceAll(
//                     ' ',
//                     '',
//                   ),
//             )
//             .where(
//               'createdAt',
//               isGreaterThan: DateTime.now()
//                   .subtract(const Duration(hours: 24))
//                   .millisecondsSinceEpoch,
//             )
//             .get();
//         for (var tempData in statusesSnapshot.docs) {
//           Status tempStatus = Status.fromMap(tempData.data());
//           if (tempStatus.whoCanSee.contains(auth.currentUser!.uid)) {
//             statusData.add(tempStatus);
//           }
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) print(e);
//       showSnackBar(context: context, content: e.toString());
//     }
//     return statusData;
//   }
// }

// ignore_for_file: unnecessary_null_comparison

//Deepseek 2nd code
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/common/repositories/common_firebase_storage_repository.dart';
import 'package:test/common/utils/utils.dart';
import 'package:test/models/status_model.dart';
import 'package:test/models/user_model.dart';
import 'package:uuid/uuid.dart';

// final statusRepositoryProvider = Provider(
//   (ref) => StatusRepository(
//     firestore: FirebaseFirestore.instance,
//     auth: FirebaseAuth.instance,
//     ref: ref,
//   ),
// );

// class StatusRepository {
//   final FirebaseFirestore firestore;
//   final FirebaseAuth auth;
//   final ProviderRef ref;
  
//   StatusRepository({
//     required this.firestore,
//     required this.auth,
//     required this.ref,
//   });

//   void uploadStatus({
//     required String username,
//     required String profilePic,
//     required String phoneNumber,
//     required File statusImage,
//     required BuildContext context,
//   }) async {
//     try {
//       var statusId = const Uuid().v1();
//       String uid = auth.currentUser!.uid;
//       String imageurl = await ref
//           .read(commonFirebaseStorageRepositoryProvider)
//           .storeFileToFirebase(
//             '/status/$statusId$uid',
//             statusImage,
//           );

//       List<Contact> contacts = [];
//       if (await FlutterContacts.requestPermission()) {
//         contacts = await FlutterContacts.getContacts(withProperties: true);
//       }

//       List<String> uidWhoCanSee = [];

//       for (var contact in contacts) {
//         // Skip contacts without phone numbers
//         if (contact.phones.isEmpty) continue;
        
//         // Get the first phone number and clean it
//         final phone = contact.phones.first.number;
//         if (phone == null || phone.isEmpty) continue;
        
//         final cleanedPhone = phone.replaceAll(' ', '');

//         try {
//           var userDataFirebase = await firestore
//               .collection('users')
//               .where('phoneNumber', isEqualTo: cleanedPhone)
//               .get();

//           if (userDataFirebase.docs.isNotEmpty) {
//             var userData = UserModel.fromMap(userDataFirebase.docs.first.data());
//             uidWhoCanSee.add(userData.uid);
//           }
//         } catch (e) {
//           if (kDebugMode) print('Error processing contact: $e');
//           continue;
//         }
//       }

//       List<String> statusImageUrls = [];
//       var statusesSnapshot = await firestore
//           .collection('status')
//           .where('uid', isEqualTo: uid)
//           .get();

//       if (statusesSnapshot.docs.isNotEmpty) {
//         Status status = Status.fromMap(statusesSnapshot.docs.first.data());
//         statusImageUrls = status.photoUrl;
//         statusImageUrls.add(imageurl);
//         await firestore
//             .collection('status')
//             .doc(statusesSnapshot.docs.first.id)
//             .update({
//           'photoUrl': statusImageUrls,
//         });
//         return;
//       } else {
//         statusImageUrls = [imageurl];
//       }

//       Status status = Status(
//         uid: uid,
//         username: username,
//         phoneNumber: phoneNumber,
//         photoUrl: statusImageUrls,
//         createdAt: DateTime.now(),
//         profilePic: profilePic,
//         statusId: statusId,
//         whoCanSee: uidWhoCanSee,
//       );

//       await firestore.collection('status').doc(statusId).set(status.toMap());
//     } catch (e) {
//       if (kDebugMode) print('Error uploading status: $e');
//       showSnackBar(context: context, content: e.toString());
//     }
//   }

//   Future<List<Status>> getStatus(BuildContext context) async {
//     List<Status> statusData = [];
//     try {
//       List<Contact> contacts = [];
//       if (await FlutterContacts.requestPermission()) {
//         contacts = await FlutterContacts.getContacts(withProperties: true);
//       }

//       for (var contact in contacts) {
//         // Skip contacts without phone numbers
//         if (contact.phones.isEmpty) continue;
        
//         // Get the first phone number and clean it
//         final phone = contact.phones.first.number;
//         if (phone == null || phone.isEmpty) continue;
        
//         final cleanedPhone = phone.replaceAll(' ', '');

//         try {
//           var statusesSnapshot = await firestore
//               .collection('status')
//               .where('phoneNumber', isEqualTo: cleanedPhone)
//               .where(
//                 'createdAt',
//                 isGreaterThan: DateTime.now()
//                     .subtract(const Duration(hours: 24))
//                     .millisecondsSinceEpoch,
//               )
//               .get();

//           for (var tempData in statusesSnapshot.docs) {
//             Status tempStatus = Status.fromMap(tempData.data());
//             if (tempStatus.whoCanSee.contains(auth.currentUser!.uid)) {
//               statusData.add(tempStatus);
//             }
//           }
//         } catch (e) {
//           if (kDebugMode) print('Error getting status for contact: $e');
//           continue;
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) print('Error in getStatus: $e');
//       showSnackBar(context: context, content: e.toString());
//     }
//     return statusData;
//   }
// }


final statusRepositoryProvider = Provider(
  (ref) => StatusRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class StatusRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  StatusRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void uploadStatus({
    required String username,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
    required BuildContext context,
  }) async {
    try {
      var statusId = const Uuid().v1();
      String uid = auth.currentUser!.uid;
      String imageurl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            '/status/$statusId$uid',
            statusImage,
          );
      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }

      List<String> uidWhoCanSee = [];

      for (int i = 0; i < contacts.length; i++) {
        var userDataFirebase = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: contacts[i].phones[0].number.replaceAll(
                    ' ',
                    '',
                  ),
            )
            .get();

        if (userDataFirebase.docs.isNotEmpty) {
          var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
          uidWhoCanSee.add(userData.uid);
        }
      }

      List<String> statusImageUrls = [];
      var statusesSnapshot = await firestore
          .collection('status')
          .where(
            'uid',
            isEqualTo: auth.currentUser!.uid,
          )
          .get();

      if (statusesSnapshot.docs.isNotEmpty) {
        Status status = Status.fromMap(statusesSnapshot.docs[0].data());
        statusImageUrls = status.photoUrl;
        statusImageUrls.add(imageurl);
        await firestore
            .collection('status')
            .doc(statusesSnapshot.docs[0].id)
            .update({
          'photoUrl': statusImageUrls,
        });
        return;
      } else {
        statusImageUrls = [imageurl];
      }

      Status status = Status(
        uid: uid,
        username: username,
        phoneNumber: phoneNumber,
        photoUrl: statusImageUrls,
        createdAt: DateTime.now(),
        profilePic: profilePic,
        statusId: statusId,
        whoCanSee: uidWhoCanSee,
      );

      await firestore.collection('status').doc(statusId).set(status.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Future<List<Status>> getStatus(BuildContext context) async {
    List<Status> statusData = [];
    try {
      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
      for (int i = 0; i < contacts.length; i++) {
        var statusesSnapshot = await firestore
            .collection('status')
            .where(
              'phoneNumber',
              isEqualTo: contacts[i].phones[0].number.replaceAll(
                    ' ',
                    '',
                  ),
            )
            .where(
              'createdAt',
              isGreaterThan: DateTime.now()
                  .subtract(const Duration(hours: 24))
                  .millisecondsSinceEpoch,
            )
            .get();
        for (var tempData in statusesSnapshot.docs) {
          Status tempStatus = Status.fromMap(tempData.data());
          if (tempStatus.whoCanSee.contains(auth.currentUser!.uid)) {
            statusData.add(tempStatus);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) print(e);
      showSnackBar(context: context, content: e.toString());
    }
    return statusData;
  }
}