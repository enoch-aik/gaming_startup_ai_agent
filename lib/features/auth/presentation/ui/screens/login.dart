import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/src/router/router.gr.dart';
import 'package:gaming_startup_ai_agent/src/widgets/loader/loader.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final auth = ref.read(authRepoProvider);
    final currentUser = ref.watch(currentUserProvider);

    // This is used to get the details of the current User, if there is no user, this would be null
    useEffect(() {
      if (currentUser != null) {
        auth.getUserInformationFromUid(currentUser.uid).then((result) {
          result.when(
            success: (data) {
              ref.read(currentUserDetails.notifier).state = data;
              context.replaceRoute(ChatRoute());
            },
            apiFailure: (e, _) {},
          );
          return null;
        });
      }
      return null;
    }, [currentUser]);
    return Form(
      key: formKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 178,
                height: 36,
                child: TextFormField(
                  controller: usernameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a username to continue';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter username',
                    hintStyle: TextStyle(fontSize: 14),
                    prefixStyle: TextStyle(fontSize: 14),
                    alignLabelWithHint: true,
                    prefixText: '@',
                    contentPadding: EdgeInsets.only(left: 8),
                  ),
                ),
              ),
              ColSpacing(16),
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Loader.show(context);
                    final result = await auth.anonymousSignIn(
                      usernameController.text,
                    );

                    if (context.mounted) {
                      Loader.hide(context);
                      context.replaceRoute(ChatRoute());
                    }

                    result.when(
                      success: (data) {
                        print(data);
                      },
                      apiFailure: (e, _) {},
                    );
                  }
                },
                child: Text('Sign in anonymously'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
