import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/common/utils/utils.dart';
import 'package:test/features/auth/controller/auth_controller.dart';

// class UserInformationScreen extends ConsumerStatefulWidget {
//   static const String routeName = '/user-information';
//   const UserInformationScreen({super.key});

//   @override
//   ConsumerState<UserInformationScreen> createState() =>
//       _UserInformationScreenState();
// }

// class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
//   final TextEditingController nameController = TextEditingController();
//   File? image;
//   @override
//   void dispose() {
//     super.dispose();
//     nameController.dispose();
//   }

//   void selectImage() async {
//     image = await pickImageFromGallery(context);
//     setState(() {});
//   }

//   void storeUserData() async {
//     String name = nameController.text.trim();
//     if (name.isNotEmpty) {
//       ref
//           .read(authControllerProvider)
//           .saveUserDataToFirebase(context, name, image);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   image == null
//                       ? const CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
//                         ),
//                         radius: 64,
//                       )
//                       : CircleAvatar(
//                         backgroundImage: FileImage(image!),
//                         radius: 64,
//                       ),
//                   Positioned(
//                     bottom: -10,
//                     left: 80,
//                     child: IconButton(
//                       onPressed: selectImage,
//                       icon: const Icon(Icons.add_a_photo),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: size.width * 0.85,
//                     padding: const EdgeInsets.all(20),
//                     child: TextField(
//                       controller: nameController,
//                       decoration: const InputDecoration(hintText: 'Enter Your Name'),
//                     ),
//                   ),
//                   IconButton(onPressed: storeUserData, icon: const Icon(Icons.done)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:test/common/utils/utils.dart';

// class UserInformationScreen extends StatefulWidget {
//   static const String routeName = '/user-information';
//   const UserInformationScreen({super.key});

//   @override
//   State<UserInformationScreen> createState() => _UserInformationScreenState();
// }

// class _UserInformationScreenState extends State<UserInformationScreen> {
//   final TextEditingController nameController = TextEditingController();
//   File? image;

//   @override
//   void dispose() {
//     nameController.dispose();
//     super.dispose();
//   }

//   Future<void> selectImage() async {
//     image = await pickImageFromGallery(context);
//     setState(() {});
//   }

//   void saveUserData() {
//     if (nameController.text.trim().isEmpty) {
//       showSnackBar(context: context, content: 'Please enter your name');
//       return;
//     }

//     // TODO: Implement saving user data to Firebase
//     // You would typically:
//     // 1. Upload image to storage
//     // 2. Save user data to Firestore
//     // 3. Navigate to home screen

//     print('Name: ${nameController.text}');
//     if (image != null) {
//       print('Image selected: ${image!.path}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),
//               const Text(
//                 'Profile Info',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Please provide your name and an optional profile photo',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(height: 40),
//               Stack(
//                 children: [
//                   image == null
//                       ? CircleAvatar(
//                           backgroundImage: NetworkImage(
//                             'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', // Default avatar
//                           ),
//                           radius: 64,
//                         )
//                       : CircleAvatar(
//                           backgroundImage: FileImage(image!),
//                           radius: 64,
//                         ),
//                   Positioned(
//                     bottom: -10,
//                     right: -10,
//                     child: IconButton(
//                       onPressed: selectImage,
//                       icon: const Icon(Icons.add_a_photo),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TextField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter your name',
//                     border: OutlineInputBorder(),
//                     contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: size.width * 0.9,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)
//                     )
//                   ),
//                   onPressed: saveUserData,
//                   child: const Text('Save'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                        ),
                        radius: 64,
                      )
                      : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 64,
                      ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: storeUserData,
                    icon: const Icon(Icons.done),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
