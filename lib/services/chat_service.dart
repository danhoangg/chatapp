import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatService extends ChangeNotifier {
  // get instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage(String message, String receiverUserId) async {
    final user = _auth.currentUser!;
    final userData = await _firestore.collection('users').doc(user!.uid).get();
    final receiverData =
        await _firestore.collection('users').doc(receiverUserId).get();

    // create new message
    Message newMessage = Message(
      id: user.uid,
      senderEmail: user.email.toString(),
      receiverId: receiverData['uid'],
      message: message,
      timestamp: Timestamp.now(),
    );

    // construct chat room if not exists
    List<String> ids = [user.uid, receiverUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(
          newMessage.toMap(),
        );
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String receiverUserId) {
    final user = _auth.currentUser!;
    List<String> ids = [user.uid, receiverUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
