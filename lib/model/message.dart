import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String message;
  final String senderEmail;
  final String receiverId;
  final Timestamp timestamp;

  Message(
      {required this.id,
      required this.message,
      required this.senderEmail,
      required this.receiverId,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'sender': senderEmail,
      'receiver': receiverId,
      'timestamp': timestamp,
    };
  }
}
