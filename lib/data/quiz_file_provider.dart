import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizRepository {
  List<Question> questions = [];

  /// Function that generates the default questions list
  List<Question> generateQuestions() {
    return [
      Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
        point: 10,
      ),
      Question(
        title: "2 + 2 = ?",
        choices: ["2", "4", "5"],
        goodChoice: "4",
        point: 50,
      ),
    ];
  }

  /// Write questions to JSON file
  void writeQuiz(String filePath) {
    questions = generateQuestions();
    
    final file = File(filePath); // Use the parameter instead of hardcoded path

    final encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(
      questions.map((q) => q.toJson()).toList(),
    );
    file.writeAsStringSync(jsonString);
  }

  /// Read questions from JSON file
  void readQuiz(String filePath) {
    final file = File(filePath); // Use the parameter instead of hardcoded path
    if (!file.existsSync()) return;

    final contents = file.readAsStringSync().trim();
    if (contents.isEmpty) return;

    final List<dynamic> data = jsonDecode(contents);
    questions = data.map((q) => Question.fromJson(q)).toList();
  }
}