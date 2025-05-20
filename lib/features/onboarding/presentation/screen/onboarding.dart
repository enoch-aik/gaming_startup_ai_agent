import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/onboarding/presentation/widgets/agent_capability.dart';
import 'package:gaming_startup_ai_agent/src/extensions/context.dart';
import 'package:gaming_startup_ai_agent/src/res/styles/styles.dart';
import 'package:gaming_startup_ai_agent/src/router/router.gr.dart';
import 'package:gaming_startup_ai_agent/src/widgets/alert_dialog.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/col_spacing.dart';
import 'package:gaming_startup_ai_agent/src/widgets/spacing/row_spacing.dart';
import 'package:gaming_startup_ai_agent/src/widgets/text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage(/*name: 'onboarding'*/)
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return isMobile
            ? Scaffold(
              body: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                padding: EdgeInsets.all(isMobile ? 16 : 40),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bth_bg.jpeg.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      height: double.maxFinite,

                      color: Colors.white.withOpacity(0.9),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/bth_logo.png',
                                  width: 70,
                                ),
                                RowSpacing(width: 16),
                                Expanded(
                                  child: KText(
                                    'Leveraging GenAI-based agent to assist in testing ideas in Software Startups/Studios and Indie Game Developers',
                                    textAlign: TextAlign.center,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            ColSpacing(isMobile ? 8 : 16),
                            KText(
                              'Thank you for participating in this study. 🙏',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: context.secondary,
                            ),
                            ColSpacing(8),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: KText(
                                      'Please read the following carefully:',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  ColSpacing(4),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: '\u2022 '),
                                        TextSpan(text: 'This '),
                                        TextSpan(
                                          text: 'AI Agent-Chatbot',
                                          style: AppStyles.textStyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' is designed to support Video Game Startups and Indie Game Developers in testing their ideas at the ',
                                        ),
                                        TextSpan(
                                          text:
                                              'Technical or Digital Prototyping',
                                          style: AppStyles.textStyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' stage of development.',
                                        ),
                                      ],
                                      style: AppStyles.textStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  ColSpacing(8),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: '\u2022 '),

                                        TextSpan(
                                          text:
                                              'Technical or Digital Prototyping is the '
                                              'stage where you test your game idea '
                                              'and concept to assess how feasibility'
                                              ' of your game. This can span from knowing ',
                                        ),
                                        TextSpan(
                                          text:
                                              'the current market or potential userbase of your game, ',
                                          style: AppStyles.textStyle.copyWith(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' how complex it would be to develop the game, ',
                                          style: AppStyles.textStyle.copyWith(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'what skill-set are needed to develop the game, ',
                                          style: AppStyles.textStyle.copyWith(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        TextSpan(text: 'and '),
                                        TextSpan(
                                          text:
                                              'how much it would cost to develop the game.',
                                          style: AppStyles.textStyle.copyWith(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                      style: AppStyles.textStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  ColSpacing(8),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: '\u2022 '),
                                        TextSpan(
                                          text:
                                              'Feel free to test the AI Agent-Chatbot with any game idea you have in mind (perhaps a game you are currently developing§)'
                                              'The AI Agent-Chatbot will help you to assess the feasibility of your game idea by providing you with the information you need.',
                                        ),
                                      ],
                                      style: AppStyles.textStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  ColSpacing(8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: '\u2022 '),
                                          TextSpan(
                                            text:
                                                'The agent also has the following capabilities.',
                                          ),
                                        ],
                                        style: AppStyles.textStyle.copyWith(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ColSpacing(8),
                                  AgentCapability(
                                    svgPath: 'assets/svg/global-search.svg',
                                    title: 'Real-time Search',
                                    isMobile: true,
                                    body:
                                        'Fetches up-to-date information on Games reviews directly from the web',
                                  ),
                                  ColSpacing(8),
                                  AgentCapability(
                                    svgPath: 'assets/svg/lamp-on.svg',
                                    title: 'Game Idea Guidance',
                                    isMobile: true,
                                    body:
                                        'Provides insights based on data from game reviews and blogs',
                                  ),
                                  ColSpacing(8),
                                  AgentCapability(
                                    svgPath: 'assets/svg/gallery-add.svg',
                                    title: 'Image Generation',
                                    isMobile: true,
                                    body:
                                        'Creates images for game backgrounds, characters, or other assets',
                                  ),
                                  ColSpacing(8),

                                  AgentCapability(
                                    svgPath: 'assets/svg/music-filter.svg',
                                    title: 'Sound-Effect Generation',
                                    isMobile: true,
                                    body:
                                        'Produces sound effects for games to enhance gameplay',
                                  ),
                                  if (!isMobile)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [],
                                    ),
                                  ColSpacing(isMobile ? 16 : 40),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: FilledButton.icon(
                                      iconAlignment: IconAlignment.end,
                                      onPressed: () {
                                        context.router.push(LoginRoute());
                                      },
                                      label: Text('Try it out'),
                                      icon: Icon(Icons.arrow_forward_rounded),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            : Scaffold(
              body: Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bth_bg.jpeg.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      height: double.maxFinite,
                      //width: size.width * 0.8,
                      padding: EdgeInsets.all(16),
                      color: Colors.white.withOpacity(0.9),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/bth_logo.png',
                                  width: 120,
                                ),
                                RowSpacing(width: 40),
                                SizedBox(
                                  width: size.width * .7,
                                  child: KText(
                                    'Leveraging GenAI-based agent to assist in testing ideas in Software Startups/Studios and Indie Game Developers',
                                    textAlign: TextAlign.center,
                                    fontSize: 33,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            KText(
                              'Thank you for participating in this study. 🙏',
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: context.secondary,
                            ),

                            ColSpacing(16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: KText(
                                      'Please read the following carefully:',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: '\u2022 '),
                                          TextSpan(text: 'This '),
                                          TextSpan(
                                            text: 'AI Agent-Chatbot',

                                            style: AppStyles.textStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' is designed to support Video Game Startups and Indie Game Developers in testing their ideas at the ',
                                          ),
                                          TextSpan(
                                            text:
                                                'Technical or Digital Prototyping',

                                            style: AppStyles.textStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' stage of development.',
                                          ),
                                        ],
                                        style: AppStyles.textStyle.copyWith(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ColSpacing(8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: '\u2022 '),

                                          TextSpan(
                                            text:
                                                'Technical or Digital Prototyping is the '
                                                'stage where you test your game idea '
                                                'and concept to assess how feasibility'
                                                ' of your game. This can span from knowing ',
                                          ),
                                          TextSpan(
                                            text:
                                                'the current market or potential userbase of your game, ',
                                            style: AppStyles.textStyle.copyWith(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                ' how complex it would be to develop the game, ',
                                            style: AppStyles.textStyle.copyWith(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'what skill-set are needed to develop the game, ',
                                            style: AppStyles.textStyle.copyWith(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          TextSpan(text: 'and '),
                                          TextSpan(
                                            text:
                                                'how much it would cost to develop the game.',
                                            style: AppStyles.textStyle.copyWith(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                        style: AppStyles.textStyle.copyWith(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ColSpacing(8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: '\u2022 '),
                                          TextSpan(
                                            text:
                                                'Feel free to test the AI Agent-Chatbot with any game idea you have in mind (perhaps a game you are currently developing)'
                                                'The AI Agent-Chatbot will help you to assess the feasibility of your game idea by providing you with the information you need.',
                                          ),
                                        ],
                                        style: AppStyles.textStyle.copyWith(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ColSpacing(8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: '\u2022 '),
                                          TextSpan(
                                            text:
                                                'The agent also has the following capabilities.',
                                          ),
                                        ],
                                        style: AppStyles.textStyle.copyWith(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ColSpacing(16),
                                  Row(
                                    spacing: 16,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AgentCapability(
                                        svgPath: 'assets/svg/global-search.svg',
                                        title: 'Real-time Search',
                                        body:
                                            'Fetches up-to-date information on Games reviews directly from the web',
                                      ),
                                      AgentCapability(
                                        svgPath: 'assets/svg/lamp-on.svg',
                                        title: 'Game Idea Guidance',
                                        body:
                                            'Provides insights based on data from game reviews and blogs',
                                      ),
                                      AgentCapability(
                                        svgPath: 'assets/svg/gallery-add.svg',
                                        title: 'Image Generation',
                                        body:
                                            'Creates images for game backgrounds, characters, or other assets',
                                      ),
                                      AgentCapability(
                                        svgPath: 'assets/svg/music-filter.svg',
                                        title: 'Sound-Effect Generation',
                                        body:
                                            'Produces sound effects for games to enhance gameplay',
                                      ),
                                    ],
                                  ),
                                  ColSpacing(40),

                                  SizedBox(
                                    width: 450,
                                    child: FilledButton.icon(
                                      iconAlignment: IconAlignment.end,
                                      onPressed: () {
                                        context.router.push(LoginRoute());
                                        //tell users that the evaluation of the AI agent is now over

                                       /* showMessageAlertDialog(
                                          context,
                                          text:
                                              'Thank you so much for participating in this study 🫡\n\nThe evaluation for this AI agent is now over.',
                                          actionText: 'Got it',
                                          width: 400,
                                          onTap: (){
                                            Navigator.of(
                                              context,
                                            ).pop();
                                          }
                                        );*/
                                        /* showAnimatedDialog(
                                          context,
                                          SizedBox(
                                            height: 200,
                                            width: 400,
                                            child: Material(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  KText(
                                                    'Thank you for participating in this study.',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  ColSpacing(8),

                                                  KText(
                                                    'The evaluation of the AI agent is now over.',
                                                    fontWeight: FontWeight.w500,
                                                  ),

                                                  ColSpacing(16),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: Text('Got it'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );*/
                                      },
                                      label: Text('Try it out'),
                                      icon: Icon(Icons.arrow_forward_rounded),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
      },
    );
  }
}
