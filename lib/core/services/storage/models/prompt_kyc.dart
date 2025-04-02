class PromptKyc {
  final DateTime lastPromptedAt;
  final bool hasPromptedUser;

  PromptKyc({required this.lastPromptedAt, required this.hasPromptedUser});

  factory PromptKyc.fromJson(Map<String, dynamic> json) => PromptKyc(
        lastPromptedAt: DateTime.parse(json['lastPromptedAt'] as String),
        hasPromptedUser: json['hasPromptedUser'] as bool,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'lastPromptedAt': lastPromptedAt.toIso8601String(),
        'hasPromptedUser': hasPromptedUser,
      };
}
