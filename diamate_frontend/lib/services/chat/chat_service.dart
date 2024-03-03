import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user list
  Stream<List<Map<String, dynamic>>> getUserList(String username) {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data())
          .where((user) => user['name']
              .toString()
              .toLowerCase()
              .contains(username.toLowerCase()))
          .toList();
    });
  }

  Future<void> createConversation(String receiverId) async {
    final senderId = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [senderId.trim(), receiverId.trim()];
    ids.sort();
    String chatId = ids.join('_');
    final timestamp = Timestamp.now();
    await _firestore.collection('conversations').doc(chatId).set({
      'users': [senderId, receiverId],
      'timestamp': timestamp,
    });
  }

  // get chat list
  Stream<List<Map<String, dynamic>>> getConversationList() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection('conversations')
        .where('users', arrayContains: userId)
        .snapshots()
        .asyncMap((snapshot) async {
      List<Map<String, dynamic>> conversations = [];
      for (final doc in snapshot.docs) {
        final conversationData = doc.data();
        final users = conversationData['users'] as List<dynamic>;
        final messagesSnapshot = await _firestore
            .collection('conversations')
            .doc(doc.id)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();
        if (messagesSnapshot.docs.isNotEmpty) {
          final lastMessage = messagesSnapshot.docs.first.data();
          final lastMessageSender = lastMessage['senderId'];
          final lastMessageSenderSnapshot =
              await _firestore.collection('users').doc(lastMessageSender).get();
          final otherUserId = users.firstWhere((user) => user != userId);
          final otherUserSnapshot =
              await _firestore.collection('users').doc(otherUserId).get();
          if (otherUserSnapshot.exists && lastMessageSenderSnapshot.exists) {
            final otherUserName = otherUserSnapshot.data()!['name'];
            conversations.add({
              'recipientId': otherUserId,
              'recipientName': otherUserName,
              'lastMessage': lastMessage['message'],
              'lastMessageSender': lastMessageSenderSnapshot.data()!['name'],
              'lastMessageTime': lastMessage['timestamp']
            });
          }
        }
      }
      conversations
          .sort((a, b) => b['lastMessageTime'].compareTo(a['lastMessageTime']));
      return conversations;
    });
  }

  // check if conversations already exists
  Future<bool> checkConversationExists(String receiverId) async {
    final senderId = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [senderId.trim(), receiverId.trim()];
    ids.sort();
    String chatId = ids.join('_');
    final snapshot =
        await _firestore.collection('conversations').doc(chatId).get();
    return snapshot.exists;
  }

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    final senderId = FirebaseAuth.instance.currentUser!.uid;

    List<String> ids = [senderId.trim(), receiverId.trim()];
    ids.sort();
    String chatId = ids.join('_');
    final timestamp = Timestamp.now();
    await _firestore
        .collection('conversations')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    });
  }

  // get message
  Stream<QuerySnapshot> getMessages(String receiverId) {
    final senderId = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatId = ids.join('_');
    return _firestore
        .collection('conversations')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
