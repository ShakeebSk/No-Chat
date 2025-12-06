import 'package:flutter/material.dart';
import 'package:test/colors.dart';
import 'package:test/common/widgets/custom_button.dart';
import 'package:test/features/auth/screens/login_screen.dart';
import 'package:test/features/auth/screens/user_information_screen.dart';

// class LandingScreen extends StatelessWidget {
//   const LandingScreen({super.key});
//   void navigateToLoginScreen(BuildContext context) {
//     Navigator.pushNamed(context, LoginScreen.routeName);
//   }

//   void navigateToUserInformationScreen(BuildContext context) {
//     Navigator.pushNamed(context, UserInformationScreen.routeName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 50),
//             const Text(
//               'Welcome to NoChat',
//               style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(height: size.height / 11),
//             Image.asset(
//               'assets/bg.png',
//               height: 340,
//               width: 340,
//               color: tabColor,
//             ),
//             SizedBox(height: size.height / 9),
//             const Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Text(
//                 'Read our Privacy Policy. Tap "Agree and Continue" to Accept the Terms of Services',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: greycolor, fontSize: 15),
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: size.width * 0.75,
//               child: CustomButton(
//                 text: 'AGREE AND CONTINUE',
//                 onPressed: () => navigateToLoginScreen(context),
//                 // onPressed:  ()=> navigateToUserInformationScreen(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Welcome to NoChat',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height / 9),
            Image.asset(
              'assets/bg.png',
              height: 340,
              width: 340,
              color: tabColor,
            ),
            SizedBox(height: size.height / 9),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                style: TextStyle(color: greycolor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLoginScreen(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}