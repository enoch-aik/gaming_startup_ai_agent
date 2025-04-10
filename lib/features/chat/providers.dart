import 'package:gaming_startup_ai_agent/core/dependency_injection/di_providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/data_source/chat_datasource_impl.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/chat_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/data/models/message_res_model.dart';
import 'package:gaming_startup_ai_agent/features/chat/domain/repo/chat_repo_impl.dart';
import 'package:gaming_startup_ai_agent/features/chat/presentation/logic/states/chat_history.dart';
import 'package:gaming_startup_ai_agent/src/extensions/api_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatDataSourceProvider = Provider<ChatDataSourceImplementation>((ref) {
  return ChatDataSourceImplementation(
    ref: ref,
    firestore: ref.watch(firestoreProvider),
  );
});

final chatRepoProvider = Provider<ChatRepositoryImplementation>((ref) {
  return ChatRepositoryImplementation(ref: ref);
});

final getChatSessionFutureProvider =
    FutureProvider.family<List<ChatResModel>, String>((ref, username) async {
      final result = await ref
          .read(chatRepoProvider)
          .getAllChatSessions(username);
      return result.extract(error: []);
    });

final selectedChatProvider = StateProvider<ChatResModel?>((ref) {
  return null;
});

final chatHistoryProvider =
    AsyncNotifierProvider<MessageState, List<MessageResModel>>(
      MessageState.new,
    );
