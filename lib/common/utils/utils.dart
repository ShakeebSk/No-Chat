import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

// void showSnackBar({required BuildContext context, required String content}) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
// }

// Future<File?> pickImageFromGallery(BuildContext context) async {
//   File? image;
//   try {
//     final pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedImage != null) {
//       image = File(pickedImage.path);
//     }
//   } catch (e) {
//     showSnackBar(context: context, content: e.toString());
//   }
//   return image;
// }

// Future<File?> pickVideoFromGallery(BuildContext context) async {
//   try {
//     final pickedVideo = await ImagePicker().pickVideo(
//       source: ImageSource.gallery,
//       maxDuration: const Duration(
//         minutes: 10,
//       ), // Optional: limit video duration
//     );

//     if (pickedVideo == null) return null; // User canceled the picker

//     final videoFile = File(pickedVideo.path);

//     // Optional: Verify the file exists and is readable
//     if (await videoFile.exists()) {
//       return videoFile;
//     } else {
//       throw Exception('Selected video file not found');
//     }
//   } on PlatformException catch (e) {
//     // Handle platform-specific exceptions (e.g., permission denied)
//     showSnackBar(
//       context: context,
//       content: 'Failed to pick video: ${e.message}',
//     );
//   } catch (e) {
//     // Handle other exceptions
//     showSnackBar(
//       context: context,
//       content: 'Error selecting video: ${e.toString()}',
//     );
//   }
//   return null;
// }

// Future<GiphyGif?> pickGIF(BuildContext context) async {
//   GiphyGif? gif;
//   try {
//     // 7nlDjkTBMeStaMhfdcmSyMdjl6PRf5lj
//     gif = await Giphy.getGif(
//       context: context,
//       apiKey: '7nlDjkTBMeStaMhfdcmSyMdjl6PRf5lj',
//     );
//   } catch (e) {
//     showSnackBar(context: context, content: e.toString());
//   }
//   return gif;
// }

// Future<File?> pickImageFromGallery(BuildContext context) async {
//   try {
//     // Check and request permission
//     if (await Permission.photos.request().isGranted || 
//         await Permission.storage.request().isGranted) {
//       final pickedImage = await ImagePicker().pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 70,
//       );
//       if (pickedImage != null) {
//         return File(pickedImage.path);
//       }
//     } else {
//       showSnackBar(context: context, content: 'Permission denied');
//     }
//   } catch (e) {
//     showSnackBar(context: context, content: 'Failed to pick image: $e');
//     debugPrint('Image picker error: $e');
//   }
//   return null;
// }



void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}

Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await Giphy.getGif(
      context: context,
      apiKey: 'pwXu0t7iuNVm8VO5bgND2NzwCpVH9S0F',
    );
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return gif;
}