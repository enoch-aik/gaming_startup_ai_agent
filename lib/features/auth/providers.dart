import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaming_startup_ai_agent/core/dependency_injection/di_providers.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/data_source/auth_datasource_impl.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/domain/repo/auth_repo_impl.dart';
import 'package:gaming_startup_ai_agent/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//provider for authentication data source
final Provider<AuthDataSourceImplementation> authDataSourceProvider =
    Provider<AuthDataSourceImplementation>((ref) {
      return AuthDataSourceImplementation(
        firestore: ref.watch(firestoreProvider),
        firebaseAuth: auth,
        ref: ref,
      );
    });

//provider for authentication repository
final Provider<AuthRepositoryImplementation> authRepoProvider =
    Provider<AuthRepositoryImplementation>((ref) {
      return AuthRepositoryImplementation(ref);
    });

//This is used to get the details of the current User, if there is no user, this would be null
final currentUserProvider = StateProvider<User?>((ref) {
  return auth.currentUser;
});

final currentUserDetails = StateProvider<UserAuthInformation?>((ref) {
  return UserAuthInformation.error();
});
