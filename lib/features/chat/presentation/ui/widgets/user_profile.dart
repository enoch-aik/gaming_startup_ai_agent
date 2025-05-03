import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/core/dependency_injection/di_providers.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/features/chat/providers.dart';
import 'package:gaming_startup_ai_agent/main.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/extensions/string.dart';
import 'package:gaming_startup_ai_agent/src/router/router.gr.dart';
import 'package:gaming_startup_ai_agent/src/widgets/init_icon.dart';
import 'package:gaming_startup_ai_agent/src/widgets/loader/loader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfile extends ConsumerWidget {
  final double borderRadius;

  const UserProfile({super.key, this.borderRadius = 16});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAuthInformation user = ref.watch(currentUserDetails)!;
    GlobalKey buttonKey = GlobalKey();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Container(
          height: 58,
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: context.primaryContainer,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            titleAlignment: ListTileTitleAlignment.center,

            leading: InitIcon(
              text: user.username,
              size: 40,
              backgroundColor: context.primary,
            ),
            trailing: IconButton(
              key: buttonKey,
              onPressed: () {
                final RenderBox renderBox =
                    buttonKey.currentContext?.findRenderObject() as RenderBox;
                final Size size = renderBox.size;
                final Offset offset = renderBox.localToGlobal(Offset.zero);
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy + size.height,
                    offset.dx + size.width,
                    offset.dy + size.height,
                  ),
                  items: [
                    PopupMenuItem(
                      child: Text('Logout'),
                      onTap: () async {
                        Loader.show(context);

                        await auth.signOut().then((_) {
                          ref.read(currentUserProvider.notifier).state = null;
                          ref.read(storeProvider).removeAll();
                        });

                        if (context.mounted) Loader.hide(context);
                        if (context.mounted) {
                          context.router
                              .replaceAll([OnboardingRoute()])
                              .whenComplete(() {
                                //invalidate all providers
                                ref.invalidate(chatHistoryProvider);
                                ref.invalidate(selectedChatProvider);
                                ref.invalidate(getChatSessionFutureProvider);
                                ref.invalidate(currentUserProvider);
                                ref.invalidate(currentUserDetails);
                              });
                        }
                      },
                    ),
                    /*PopupMenuItem(
                      child: Text('Settings'),
                      onTap: () {
                        // Navigate to settings
                      },
                    ),*/
                  ],
                );
              },
              icon: Icon(Icons.more_vert),
            ),
            title: Text(user.username.capitalizeFirst),
          ),
        ),
      ),
    );
  }
}
