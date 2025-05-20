import 'package:equatable/equatable.dart';

class SupportedAgent extends Equatable {
  final String name;
  final AgentType type;
  final String hintText;

  const SupportedAgent({
    required this.name,
    required this.type,
    required this.hintText,
  });

  static List<SupportedAgent> get agents {
    return [
      SupportedAgent(
        name: AgentType.technicalPrototyping.fullName,
        type: AgentType.technicalPrototyping,
        hintText:
            'Ask me anything about digital and technical prototyping in your game',
      ),
      SupportedAgent(
        name: AgentType.socialMediaEngagement.fullName,
        type: AgentType.socialMediaEngagement,
        hintText:
            'Ask me anything about social media engagement to increase your audience and build a community around your game',
      ),

      SupportedAgent(
        name: AgentType.mockReview.fullName,
        type: AgentType.mockReview,
        hintText:
            'Ask me anything about mock review to get feedback on your game',
      ),
    ];
  }

  @override
  List<Object?> get props => [name, type, hintText];
}

enum AgentType {
  technicalPrototyping,
  socialMediaEngagement,
  controlledGameTesting,
  mockReview,
  conferencePitching,
  earlyVerticalSlice;

  String get fullName {
    switch (this) {
      case AgentType.technicalPrototyping:
        return 'Technical & Digital Prototyping';
      case AgentType.socialMediaEngagement:
        return 'Social Media Engagement';
      case AgentType.controlledGameTesting:
        return 'Controlled Game Testing';
      case AgentType.mockReview:
        return 'Mock Review';
      case AgentType.conferencePitching:
        return 'Conference Pitching';
      case AgentType.earlyVerticalSlice:
        return 'Early Vertical Slice';
    }
  }
}
