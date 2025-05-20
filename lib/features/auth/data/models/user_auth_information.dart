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

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'uid': uid,
      'metadata': {
        'createdAt': createdAt?.toIso8601String(),
        'lastSignInAt':
            lastSignInAt?.toIso8601String(),
      },
    };
  }

  factory UserAuthInformation.fromMap(Map<String, dynamic> map) {
    return UserAuthInformation(
      username: map['username'] as String,
      uid: map['uid'] as String,
      createdAt:DateTime.parse(map['metadata']['createdAt']) ,
      lastSignInAt: DateTime.parse(map['metadata']['lastSignInAt']),
    );
  }
}

extension TimeExtension on DateTime {
  String get toIso8601String {

    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}
