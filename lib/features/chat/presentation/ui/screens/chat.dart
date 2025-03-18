import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/row_spacing.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();
    Size screenSize = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: screenSize.width * 0.225,
            height: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withValues(colorSpace: ColorSpace.sRGB),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ColSpacing(16),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        RowSpacing(width: 8),
                        CircleAvatar(
                          child: Icon(Icons.add_comment_rounded),
                          radius: 18,
                        ),
                        RowSpacing(width: 16),
                        ColSpacing(16),
                        Text('New chat', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  ColSpacing(16),
                  TextFormField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  ColSpacing(16),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    leading: Icon(Icons.notes_rounded),
                    title: Text('Current development in AI'),
                    onTap: () {},
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    leading: Icon(Icons.notes_rounded),
                    title: Text('RPG game config'),
                    onTap: () {},
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    leading: Icon(Icons.notes_rounded),
                    title: Text(
                      'What are the advantages of experimenting?',
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16, right: 16),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 5,
                        color: Colors.black12.withOpacity(0.15),
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ask me anything related to game reviews',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        suffixIcon: Icon(Icons.send)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
