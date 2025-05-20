import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';

abstract class AuthDataSource {

  Future<UserCredential> anonymousSignIn(String username);
  Future<UserAuthInformation> getUserInformation(String username);
  Future<UserAuthInformation> getUserInformationFromUid(String uid);


}