import 'package:flutter/material.dart';
import 'package:test/colors.dart';
// import 'package:whatsapp_ui/colors.dart';
import 'package:test/features/chat/widgets/chat_list.dart';
import 'package:test/features/chat/widgets/contacts_list.dart';
import 'package:test/widgets/web_chat_appbar.dart';
import 'package:test/widgets/web_profile_bar.dart';
import 'package:test/widgets/web_search_bar.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                // children: [WebProfileBar(), WebSearchBar(), ContactsList()],
              ),
            ),
          ),
          // web screen
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgroundImage.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // chat app baar
                const WebChatAppbar(),
                // Expanded(child: ChatList(recieverUserId: '',)),
                // chat app list
                // text message input box
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: dividerColor)),
                    color: chatBarMessage,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file, color: Colors.grey),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: TextField(
                            style: const TextStyle(fontSize: 18),
                            // cursorHeight: 20,
                            cursorHeight: 25,
                            decoration: InputDecoration(
                              fillColor: searchBarColor,
                              filled: true,
                              hintText: 'Type a message',
                              hintStyle: const TextStyle(fontSize: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 20),
                            ),
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.mic))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
