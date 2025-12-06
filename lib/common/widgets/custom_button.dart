import 'package:flutter/material.dart';
import 'package:test/colors.dart';
// import 'package:test/common/utils/colors.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: tabColor,
        foregroundColor: blackcolor,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: blackcolor
          ),),
    );
  }
}

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   const CustomButton({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: blackColor,
//         ),
//       ),
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         primary: tabColor,
//         minimumSize: const Size(double.infinity, 50),
//       ),
//     );
//   }
// }