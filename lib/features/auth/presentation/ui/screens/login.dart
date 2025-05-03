import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaming_startup_ai_agent/core/dependency_injection/di_providers.dart';
import 'package:gaming_startup_ai_agent/core/service_exceptions/service_exception.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/router/router.gr.dart';
import 'package:gaming_startup_ai_agent/src/widgets/loader/loader.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:gaming_startup_ai_agent/src/widgets/toast/toast.dart';
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
    final UserAuthInformation? userDetails =
        ref.read(storeProvider).fetchUserInfo();
    final ValueNotifier<bool> buttonPressed = useState(false);

    // This is used to get the details of the current User, if there is no user, this would be null
    useEffect(() {
      if (userDetails != null && !buttonPressed.value) {
        auth.getUserInformationFromUid(currentUser!.uid).then((result) {
          if (context.mounted) {
            result.when(
              success: (data) {
                ref.read(currentUserDetails.notifier).state = data;
                context.router.replaceAll([ChatRoute()]);
              },
              apiFailure: (e, _) {},
            );
          }

          return null;
        });
      }
      return null;
    }, [currentUser]);
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(backgroundColor: context.surface),
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
                  buttonPressed.value = true;
                  if (formKey.currentState!.validate()) {
                    Loader.show(context);
                    final result = await auth.anonymousSignIn(
                      usernameController.text,
                    );

                    if (context.mounted) {
                      Loader.hide(context);
                      //context.replaceRoute(ChatRoute());
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        result.when(
                          success: (data) async {
                            final userData = await auth
                                .getUserInformationFromUid(data.user!.uid);

                            userData.when(
                              success: (data) {
                                ref.read(currentUserDetails.notifier).state =
                                    data;
                                context.router.replaceAll([ChatRoute()]);
                              },
                              apiFailure: (e, _) {},
                            );
                            // ref.read(currentUserDetails.notifier).state = data;
                          },
                          apiFailure: (e, _) {
                            Toast.error(e.message, context);
                          },
                        );
                      });
                    }
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
