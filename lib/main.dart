// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/colors.dart';
import 'package:test/common/widgets/error.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/features/auth/controller/auth_controller.dart';
import 'package:test/router.dart';
import 'package:test/features/landing/screens/landing_screen.dart';
import 'package:test/firebase_options.dart';
import 'package:test/screens/mobile_layout_screen.dart';
// import 'package:test/responsive/responsive_layout.dart';
// import 'package:test/screens/mobile_screen_layout.dart';
// import 'package:test/screens/web_screen_layout.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // await FirebaseAppCheck.instance.activate(
//   //   androidProvider: AndroidProvider.playIntegrity,
//   // );

//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'NoChat',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: backgroundColor,
//         appBarTheme: const AppBarTheme(color: appBarColor),
//       ),
//       onGenerateRoute: (settings) => generateRoute(settings),
//       home: ref
//           .watch(userDataAuthProvider)
//           .when(
//             data: (user) {
//               if (user == null) {
//                 return const LandingScreen();
//               }
//               return const MobileLayoutScreen();
//             },
//             error: (err, trace) {
//               return ErrorScreen(error: err.toString());
//             },
//             loading: () => const Loader(),
//           ),
//     );
//   }
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoChat',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              }
              return const MobileLayoutScreen();
            },
            error: (err, trace) {
              return ErrorScreen(
                error: err.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}