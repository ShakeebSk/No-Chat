import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/colors.dart';
import 'package:test/features/auth/controller/auth_controller.dart';

// class OTPScreen extends ConsumerWidget {
//   static const String routeName = '/otp-screen';
//   final String verificationId;
//   const OTPScreen({super.key, required this.verificationId});
//   void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
//     ref
//         .read(authControllerProvider)
//         .verifyOTP(context, verificationId, userOTP);
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Verifying your Number'),
//         elevation: 0,
//         backgroundColor: backgroundColor,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const Text('We have sent an SMS with a code'),
//             SizedBox(
//               width: size.width * 0.5,
//               child: TextField(
//                 textAlign: TextAlign.center,
//                 decoration: const InputDecoration(
//                   hintText: '- - - - - -',
//                   hintStyle: TextStyle(fontSize: 30),
//                 ),
//                 keyboardType: TextInputType.number,
//                 onChanged: (val) {
//                   if (val.length==6) {
//                     verifyOTP(ref, context, val.trim());
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:test/common/utils/utils.dart';
// import 'package:test/common/widgets/custom_button.dart';
// import 'package:test/features/auth/controller/auth_controller.dart';
// import 'package:test/screens/mobile_screen_layout.dart';

// class OTPScreen extends ConsumerStatefulWidget {
//   static const String routeName = '/otp-screen';
//   final String verificationId;
//   const OTPScreen({super.key, required this.verificationId});

//   @override
//   ConsumerState<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends ConsumerState<OTPScreen> {
//   final TextEditingController otpController = TextEditingController();
//   bool isLoading = false;

//   void verifyOTP() async {
//     setState(() => isLoading = true);
//     final String otp = otpController.text.trim();
    
//     if (otp.length == 6) {
//       ref.read(authControllerProvider).verifyOTP(
//         context: context,
//         verificationId: widget.verificationId,
//         userOTP: otp,
//       );
      
//       // Navigate to home screen after verification
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => const MobileScreenLayout()),
//         (route) => false,
//       );
//     } else {
//       showSnackBar(context: context, content: 'Enter a valid 6-digit OTP');
//     }
//     setState(() => isLoading = false);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     otpController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Verify OTP'),
//         elevation: 0,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               const SizedBox(height: 50),
//               const Text(
//                 'We have sent an SMS with a verification code',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 30),
//               TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 maxLength: 6,
//                 decoration: const InputDecoration(
//                   hintText: '6-digit code',
//                   counterText: '',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: CustomButton(
//                   text: 'Verify',
//                   onPressed: verifyOTP,
//                   // isLoading: isLoading,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}