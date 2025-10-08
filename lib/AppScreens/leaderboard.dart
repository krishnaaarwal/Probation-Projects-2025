import 'package:flutter/material.dart';
import 'package:quiz_app/database_service/database_service.dart';
import 'package:quiz_app/database_service/user_score.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final Database _database = Database();
  List<UserScore> leaderboard = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    setState(() => isLoading = true);

    try {
      final scores = await _database.getAllScores();
      setState(() {
        leaderboard = scores.take(10).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : leaderboard.isEmpty
          ? const Center(
              child: Text(
                'No scores yet. Be the first!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                final score = leaderboard[index];
                final isTopThree = index < 3;

                return Card(
                  elevation: isTopThree ? 4 : 1,
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isTopThree ? Colors.amber.shade50 : null,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getMedalColor(index),
                      child: Text(
                        '#${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      score.userName,
                      style: TextStyle(
                        fontWeight: isTopThree
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: isTopThree ? 18 : 16,
                      ),
                    ),
                    trailing: Text(
                      '${score.score}/${score.totalQuestions}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _getScoreColor(
                          score.score,
                          score.totalQuestions,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Color _getMedalColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.brown;
      default:
        return Colors.deepPurple;
    }
  }

  Color _getScoreColor(int score, int total) {
    final percentage = (score / total) * 100;
    if (percentage >= 80) return Colors.green;
    if (percentage >= 50) return Colors.orange;
    return Colors.red;
  }
}
