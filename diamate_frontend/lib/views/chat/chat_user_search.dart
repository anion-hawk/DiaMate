import 'package:diamate_frontend/services/chat/chat_service.dart';
import 'package:diamate_frontend/views/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatUserSearch extends StatefulWidget {
  const ChatUserSearch({super.key});

  @override
  State<ChatUserSearch> createState() => _ChatUserSearch();
}

class _ChatUserSearch extends State<ChatUserSearch> {
  String searchText = "@";
  final ChatService _chatService = ChatService();

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: _buildSearchBar()), body: _buildSearchResults());
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search for users",
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          padding: const EdgeInsets.only(right: 2),
          onPressed: () {
            setState(() {
              if (searchController.text.isEmpty) {
                searchText = "@";
              } else {
                searchText = searchController.text;
              }
            });
          },
          icon: const Icon(Icons.search),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchText == "@") {
      return Container();
    }
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUserList(searchText),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!;
          if (users.isEmpty) {
            return const Center(child: Text("No user found"));
          }
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                if (user['id'].trim() ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return Container();
                }
                return ListTile(
                    leading: CircleAvatar(child: Text(user['name'][0])),
                    title: Text(user['name']),
                    onTap: () async {
                      bool conversation = await _chatService
                          .checkConversationExists(user['id'].trim());
                      if (!conversation) {
                        await _chatService
                            .createConversation(user['id'].trim());
                      }
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  receiverId: user['id'].trim(),
                                  receiverName: user['name'].trim())));
                    });
              });
        });
  }
}
