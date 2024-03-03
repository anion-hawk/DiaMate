import 'package:diamate_frontend/services/chat/chat_service.dart';
import 'package:diamate_frontend/views/chat/chat_screen.dart';
import 'package:diamate_frontend/views/chat/chat_user_search.dart';
import 'package:diamate_frontend/widgets/custom_floating_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  ConversationList({Key? key}) : super(key: key);

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
        ),
        body: SafeArea(child: _buildRecentList()),
        floatingActionButton: CustomFloatingButton(
          height: 35,
          width: 35,
          backgroundColor: Colors.indigo[900]!, // Replace with your color
          child: const Icon(
            Icons.message_outlined,
            color: Colors.white,
            size: 25.0,
          ),
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatUserSearch()))
                .then((result) => {setState(() {})});
          },
        ));
  }

  Widget _buildRecentList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getConversationList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final conversations = snapshot.data!;
          return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ListTile(
                    leading: CircleAvatar(
                        child: Text(conversation['recipientName'][0])),
                    title: Text(conversation['recipientName']),
                    subtitle: Text(conversation['lastMessageSender'] +
                        ": " +
                        conversation['lastMessage']),
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      receiverId:
                                          conversation['recipientId'].trim(),
                                      receiverName:
                                          conversation['recipientName']
                                              .trim())))
                          .then((result) => {setState(() {})});
                    });
              });
        });
  }
}
