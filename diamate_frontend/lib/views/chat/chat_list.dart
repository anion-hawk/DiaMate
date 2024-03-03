import 'package:diamate_frontend/services/chat/chat_service.dart';
import 'package:diamate_frontend/views/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key? key}) : super(key: key);

  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: SafeArea(child: _buildUserList()),
    );
  }

  // Widget _buildRecentList() {
  //   return ListView.builder(
  //     itemCount: 10, // Assume 10 conversations for example
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         leading: CircleAvatar(
  //           child: Text('U$index'), // Simple avatar with user initials
  //         ),
  //         title: Text('User $index'),
  //         subtitle: Text('Last message here...'),
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => const ChatScreen()),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;

          print(users);

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
                    subtitle: Text(user['email'] + " kichu akta"),
                    onTap: () {
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
