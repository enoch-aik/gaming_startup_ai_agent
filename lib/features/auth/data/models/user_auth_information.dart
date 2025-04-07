import 'package:cloud_firestore/cloud_firestore.dart';

class UserAuthInformation {
  final String username;
  final String uid;
  final DateTime? createdAt;
  final DateTime? lastSignInAt;

  factory UserAuthInformation.fromJson(Map<String, dynamic> json) {
    return UserAuthInformation(
      username: json['username'] as String,
      uid: json['uid'] as String,
      createdAt: (json['metadata']['createdAt'] as Timestamp).toDate(),
      lastSignInAt: (json['metadata']['lastSignInAt'] as Timestamp).toDate(),
    );
  }

  factory UserAuthInformation.error() {
    return UserAuthInformation(
      username: 'anonymous',
      uid: '',
      createdAt: null,
      lastSignInAt: null,
    );
  }

  UserAuthInformation({
    required this.username,
    required this.uid,
    this.createdAt,
    this.lastSignInAt,
  });
}
