import 'dart:io';
import 'package:path/path.dart' as path;
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_file_provider.dart';

void main() {
  // Get the absolute path to the project root directory
  final scriptDir = File(Platform.script.toFilePath()).parent.parent;
  final filePath = path.join(scriptDir.path, 'quiz.json');
  
  print("Attempting to access quiz file at: $filePath");
  
  final repo = QuizRepository();
  
  try {
    // Create file if it doesn't exist
    final file = File(filePath);
    if (!file.existsSync()) {
      file.createSync();
      print("Created new quiz.json file");
    }

    repo.readQuiz(filePath);
    repo.writeQuiz(filePath);

    Quiz quiz = Quiz(questions: repo.questions);
    QuizConsole console = QuizConsole(quiz: quiz);
    console.startQuiz();
  } catch (e) {
    print("Error: Unable to access quiz file at $filePath");
    print("Error details: $e");
    print("Current working directory: ${Directory.current.path}");
  }
}
