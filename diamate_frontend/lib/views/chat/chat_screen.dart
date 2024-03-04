import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamate_frontend/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.receiverId, required this.receiverName})
      : super(key: key);

  final String receiverId, receiverName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  final ScrollController _scrollController = ScrollController();

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      Future.delayed(const Duration(milliseconds: 100), () => scrollDown());
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverName),
        ),
        body: Column(children: <Widget>[
          Expanded(child: _buildMessageList()),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Send a message...',
                    ),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      sendMessage();
                    })
              ]))
        ]));
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
              controller: _scrollController,
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ListTile(
      title: Align(
        alignment: data['senderId'] == widget.receiverId
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: data['senderId'] == widget.receiverId
              ? Colors.blue[100]
              : Colors.grey[300],
          child: Text(data['message']),
        ),
      ),
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 1), curve: Curves.fastOutSlowIn);
  }
}
