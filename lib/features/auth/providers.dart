import 'package:gaming_startup_ai_agent/core/dependency_injection/di_providers.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/data_source/auth_impl.dart';
import 'package:gaming_startup_ai_agent/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//provider for authentication
final Provider<AuthDataSourceImplementation> authDataSourceProvider =
    Provider<AuthDataSourceImplementation>((ref) {
      return AuthDataSourceImplementation(
        firestore: ref.watch(firestoreProvider),
        firebaseAuth: auth,
        ref: ref,
      );
    });
