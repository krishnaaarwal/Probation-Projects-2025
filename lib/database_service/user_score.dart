class UserScore {
  final String? id;
  final String userName;
  final int score;
  final int totalQuestions;
  final DateTime timestamp;

  UserScore({
    this.id,
    required this.userName,
    required this.score,
    required this.totalQuestions,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'score': score,
      'totalQuestions': totalQuestions,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory UserScore.fromJson(String id, Map<dynamic, dynamic> json) {
    return UserScore(
      id: id,
      userName: json['userName'] as String,
      score: json['score'] as int,
      totalQuestions: json['totalQuestions'] as int,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    );
  }

  String get displayScore => '$userName: $score/$totalQuestions';
}
