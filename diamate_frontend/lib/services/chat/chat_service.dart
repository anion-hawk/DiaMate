import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user list
  Stream<List<Map<String, dynamic>>> getUserList() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // get chat list
  Stream<QuerySnapshot> getChatList() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection('chats')
        .where('users', arrayContains: userId)
        .snapshots();
  }

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    final senderId = FirebaseAuth.instance.currentUser!.uid;

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatId = ids.join('_');
    final timestamp = Timestamp.now();
    await _firestore
        .collection('chats')
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
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
