class QuizQuestion {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String category;
  final String difficulty;
  final String type;

  QuizQuestion({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.category,
    required this.difficulty,
    required this.type,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    String questionText;
    if (json['question'] is String) {
      questionText = json['question'] as String;
    } else if (json['question'] is Map) {
      questionText = json['question']['text'] as String;
    } else {
      throw Exception('Invalid question format');
    }

    return QuizQuestion(
      question: questionText,
      correctAnswer: json['correctAnswer'] as String,
      incorrectAnswers: List<String>.from(json['incorrectAnswers']),
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      type: json['type'] as String? ?? 'multiple',
    );
  }

  List<String> getAllAnswers() {
    List<String> allAnswers = [correctAnswer, ...incorrectAnswers];
    allAnswers.shuffle();
    return allAnswers;
  }
}
