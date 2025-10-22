import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;
  List<Player> players = [];
  QuizConsole({required this.quiz});

  void startQuiz() {
    while (true){
      stdout.write("Enter your name (or press Enter to quit): ");
      String? name = stdin.readLineSync();
      if (name == null || name.isEmpty) {
        print("Exiting the quiz. Goodbye!");
        return;
      }

      // Check if player already exists
      Player? player = players.firstWhere(
        (p) => p.name == name,
        orElse: () => Player(name: name),
      );
      // If the player is new, add to list
      if (!players.contains(player)) {
        players.add(player);
      }

      quiz.answers.clear();
      print('--- Welcome to the Quiz, $name ---\n');

      for (var question in quiz.questions) {
        print('Question: ${question.title}' + '- ( ${question.point} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      int score = quiz.getScoreInPercentage();
      int point = quiz.getScoreInPoints();
      player.updateScore(score);
      print('--- Quiz Finished ---');
      print('${player.name}, Your score: $score % correct');
      print('Your point: $point ');

      print('--- ScoreBoard ---');
      for (var p in players){
        print('${p.name}: ${p.lastScorePoints} points');
      }
      print('------------------\n');
    }
  }
}
 