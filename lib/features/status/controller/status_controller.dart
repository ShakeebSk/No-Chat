import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/features/auth/controller/auth_controller.dart';
import 'package:test/features/status/repository/status_repository.dart';
import 'package:test/models/status_model.dart';

// final statusControllerProvider = Provider((ref) {
//   final statusRepository = ref.read(statusRepositoryProvider);
//   return StatusController(
//     statusRepository: statusRepository,
//     ref: ref
//     );
// });

// class StatusController {
//   final StatusRepository statusRepository;
//   final ProviderRef ref;

//   StatusController({required this.statusRepository, required this.ref});

//   void addStatus(File file, BuildContext context) {
//     ref.watch(userDataAuthProvider).whenData((value) {
//       statusRepository.uploadStatus(
//         username: value!.name,
//         profilePic: value.profilePic,
//         phoneNumber: value.phoneNumber,
//         statusImage: file,
//         context: context,
//       );
//     });
//   }
// }


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:test/features/auth/controller/auth_controller.dart';
// import 'package:test/features/status/repository/status_repository.dart';

// final statusControllerProvider = Provider((ref) {
//   final statusRepository = ref.read(statusRepositoryProvider);
//   return StatusController(
//     statusRepository: statusRepository,
//     ref: ref,
//   );
// });

// class StatusController {
//   final StatusRepository statusRepository;
//   final ProviderRef ref;

//   StatusController({
//     required this.statusRepository,
//     required this.ref,
//   });

//   Future<void> addStatus(File file, BuildContext context) async {
//     try {
//       final userData = await ref.read(userDataAuthProvider.future);
//       if (userData == null) {
//         _showError(context, 'User not authenticated');
//         return;
//       }

//       await statusRepository.uploadStatus(
//         username: userData.name,
//         profilePic: userData.profilePic,
//         phoneNumber: userData.phoneNumber,
//         statusImage: file,
//       );

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Status uploaded successfully')),
//       );
//     } catch (e) {
//       _showError(context, 'Failed to upload status: ${e.toString()}');
//     }
//   }

//   void _showError(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
// }

final statusControllerProvider = Provider((ref) {
  final statusRepository = ref.read(statusRepositoryProvider);
  return StatusController(
    statusRepository: statusRepository,
    ref: ref,
  );
});

class StatusController {
  final StatusRepository statusRepository;
  final ProviderRef ref;
  StatusController({
    required this.statusRepository,
    required this.ref,
  });

  void addStatus(File file, BuildContext context) {
    ref.watch(userDataAuthProvider).whenData((value) {
      statusRepository.uploadStatus(
        username: value!.name,
        profilePic: value.profilePic,
        phoneNumber: value.phoneNumber,
        statusImage: file,
        context: context,
      );
    });
  }

  Future<List<Status>> getStatus(BuildContext context) async {
    List<Status> statuses = await statusRepository.getStatus(context);
    return statuses;
  }
}