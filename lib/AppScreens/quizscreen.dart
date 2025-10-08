import 'package:flutter/material.dart';
import 'package:quiz_app/AppScreens/leaderboard.dart';
import 'package:quiz_app/api_service/questionmodel.dart';
import 'package:quiz_app/api_service/quiz_api_service.dart';
import 'package:quiz_app/database_service/database_service.dart';
import 'package:quiz_app/database_service/user_score.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizApiService _quizApiService = QuizApiService();

  String? userName;
  bool isLoading = false;
  List<QuizQuestion> questions = [];
  int score = 0;
  String errorMessage = '';

  int currentQuestionIndex = 0;

  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      questions = [];
      currentQuestionIndex = 0;
      score = 0;
      selectedAnswer = null;
    });

    try {
      final qusList = await _quizApiService.fetchQuestion();
      setState(() {
        questions = qusList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error getting questions: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _getUserName() async {
    final TextEditingController namec = TextEditingController();

    final name = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Welcome to Quiz Royale!'),
          content: TextField(
            controller: namec,
            decoration: const InputDecoration(
              labelText: 'Enter your name',
              hintText: 'P.E.K.K.A',
            ),
            autofocus: true,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                Navigator.pop(context, value.trim());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (namec.text.trim().isNotEmpty) {
                  Navigator.pop(context, namec.text.trim());
                }
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );

    setState(() {
      userName = name?.isNotEmpty == true ? name : 'Guest';
    });
    await _loadQuestions();
  }

  void _checkAnswer(String answer) {
    if (questions.isEmpty) return;

    final correctAnswer = questions[currentQuestionIndex].correctAnswer;

    setState(() {
      selectedAnswer = answer;
      if (answer == correctAnswer) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
        });
      } else {
        _showResults();
      }
    });
  }

  Future<void> _showResults() async {
    if (userName != null) {
      final Database database = Database();
      final userScore = UserScore(
        userName: userName!,
        score: score,
        totalQuestions: questions.length,
        timestamp: DateTime.now(),
      );

      try {
        await database.createScore(score: userScore);
      } catch (e) {
        print('Error saving score: $e');
      }
    }

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Text('Your score: $score / ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loadQuestions();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeaderboardScreen(),
                ),
              );
            },
            child: const Text('View Leaderboard'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Royale'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(child: Text('Score: $score')),
          ),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (errorMessage.isNotEmpty) {
      return _buildErrorState();
    } else if (questions.isEmpty) {
      return const Center(child: Text('No questions available'));
    } else {
      return _buildQuizContent();
    }
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMessage, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _loadQuestions, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildQuizContent() {
    final question = questions[currentQuestionIndex];
    final allAnswers = question.getAllAnswers();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question ${currentQuestionIndex + 1} of ${questions.length}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / questions.length,
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Chip(label: Text(question.category)),
              const SizedBox(width: 8),
              Chip(label: Text(question.difficulty)),
            ],
          ),
          const SizedBox(height: 16),

          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                question.question,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          ...allAnswers.map((answer) {
            final bool isSelected = selectedAnswer == answer;
            final bool isCorrect = answer == question.correctAnswer;
            final bool showResult = selectedAnswer != null;

            Color? backgroundColor;
            if (showResult) {
              if (isCorrect) {
                backgroundColor = Colors.green;
              } else if (isSelected && !isCorrect) {
                backgroundColor = Colors.red;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ElevatedButton(
                onPressed: selectedAnswer == null
                    ? () => _checkAnswer(answer)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
                child: Text(answer, style: const TextStyle(fontSize: 16)),
              ),
            );
          }),
        ],
      ),
    );
  }
}
