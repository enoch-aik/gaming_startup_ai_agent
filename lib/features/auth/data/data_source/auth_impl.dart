import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/data_source/auth_datasource.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDataSourceImplementation extends AuthDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final Ref ref;

  AuthDataSourceImplementation({
    required this.firestore,
    required this.firebaseAuth,
    required this.ref,
  });

  @override
  Future<bool> anonymousSignIn() async {
    try {
      await firebaseAuth.signInAnonymously();
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }
}
