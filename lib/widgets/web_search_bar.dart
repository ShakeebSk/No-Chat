import 'package:flutter/material.dart';
import 'package:test/colors.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.25,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: dividerColor)),
      ),
      child: TextField(
        style: const TextStyle(height: 1.2),
        decoration: InputDecoration(
          filled: true,
          fillColor: searchBarColor,
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.search, size: 20),
          ),
          hintStyle: const TextStyle(fontSize: 14),
          hintText: 'Search or Start a new chat',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          contentPadding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
