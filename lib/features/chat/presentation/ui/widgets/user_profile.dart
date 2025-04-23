import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:gaming_startup_ai_agent/features/auth/providers.dart';
import 'package:gaming_startup_ai_agent/main.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/extensions/string.dart';
import 'package:gaming_startup_ai_agent/src/widgets/init_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAuthInformation user = ref.watch(currentUserDetails)!;
    GlobalKey buttonKey = GlobalKey();
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 4.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
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
                    onTap: () async => await auth.signOut(),
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
    );
  }
}
