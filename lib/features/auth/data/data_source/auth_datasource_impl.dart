import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaming_startup_ai_agent/core/dependency_injection/di_providers.dart';
import 'package:gaming_startup_ai_agent/core/service_exceptions/service_exception.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/data_source/auth_datasource.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
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
  Future<UserCredential> anonymousSignIn(String username) async {
    try {
      //sign in anonymously
      UserCredential user = await firebaseAuth.signInAnonymously();

      //get the list of users with the same username
      List<dynamic> users = await firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((value) => value.docs);

      //check if the username is already taken, then just sign in, else, add the user details
      // if (users.isEmpty) {
      await firestore.collection('users').doc(username).set({
        'username': username,
        'uid': user.user?.uid,
        'metadata': {
          'createdAt': user.user?.metadata.creationTime,
          'lastSignInAt': user.user?.metadata.lastSignInTime,
        },
      });
      //  }

      final UserAuthInformation userInfo = UserAuthInformation(
        username: username,
        uid: user.user?.uid ?? '',
        createdAt: user.user?.metadata.creationTime,
        lastSignInAt: user.user?.metadata.lastSignInTime,
      );

      //save user information to the local storage
      ref.read(storeProvider).saveUserInfo(userInfo);

      return user;
    } on FirebaseAuthException catch (e) {
      print('An Error Occurred: ${e.message}');
      throw ApiExceptions.fireBaseAuthException(e.message!);
    }
  }

  @override
  Future<UserAuthInformation> getUserInformation(String username) {
    try {
      //get the user details
      return firestore
          .collection('users')
          .doc(username)
          .get()
          .then((value) => UserAuthInformation.fromJson(value.data()!));
    } on FirebaseAuthException catch (e) {
      print('An Error Occurred: ${e.message}');
      throw ApiExceptions.fireBaseAuthException(e.message!);
    }
  }

  @override
  Future<UserAuthInformation> getUserInformationFromUid(String uid) {
    try {
      //get the user details
      return firestore
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get()
          .then((value) {
            try {
              print(value.docs.length);
              return UserAuthInformation.fromJson(value.docs.first.data());
            } catch (e) {
              log('An Error Occurred: ${e.toString()}');
              //auth.signOut();
              throw ApiExceptions.unexpectedError();
            }
          });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      throw ApiExceptions.unexpectedError();
    }
  }
}
