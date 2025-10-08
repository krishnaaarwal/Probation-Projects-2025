import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/api_service/questionmodel.dart';

class QuizApiService {
  static const String baseUrl = "https://the-trivia-api.com/v2/questions";

  Future<List<QuizQuestion>> fetchQuestion({
    int numOfQuestion = 10,
    String? category,
    String? difficulty,
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'limit': numOfQuestion.toString(),
          if (category != null) 'categories': category,
          if (difficulty != null) 'difficulties': difficulty,
        },
      );
      print("Fetching from: $uri");

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        List<QuizQuestion> ques = [];

        for (int i = 0; i < jsonList.length; i++) {
          var json = jsonList[i];
          QuizQuestion q = QuizQuestion.fromJson(json);
          ques.add(q);

          // final questions = jsonList
          //   .map((json) => QuizQuestion.fromJson(json))
          //   .toList();
        }

        return ques;
      } else {
        throw Exception(
          'Failed to load questions. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching questions: $e');
      rethrow;
    }
  }

  Future<List<QuizQuestion>> fetchQusByCategory(String category) async {
    return fetchQuestion(category: category);
  }

  Future<List<QuizQuestion>> fetchQusByDifficulty(String difficulty) async {
    return fetchQuestion(difficulty: difficulty);
  }
}
