import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

main() {
  test('My first test', () {
   
    Question q1 =
        Question(title: "4-2", choices: ["1", "2", "3"], goodChoice: "2",point: 10);
    Question q2 =
        Question(title: "4+2", choices: ["1", "2", "3"], goodChoice: "6",point: 50);

    Quiz quiz = Quiz(questions: [q1, q2]);

     // Answer are all good
    quiz.addAnswer(Answer(question: q1, answerChoice: "2"));
    quiz.addAnswer(Answer(question: q2, answerChoice: "6"));

    // SCore eis 100
    expect(quiz.getScoreInPercentage(), equals(100));
  });

  //point test
  test('Quiz points test', () {
  Quiz quiz = Quiz(questions: [
    Question(title: "4-2", choices: ["1","2","3"], goodChoice: "2", point: 10),
    Question(title: "4+2", choices: ["1","2","3","6"], goodChoice: "6", point: 50),
  ]);

  quiz.addAnswer(Answer(question: quiz.questions[0], answerChoice: "2")); // correct
  quiz.addAnswer(Answer(question: quiz.questions[1], answerChoice: "6")); // correct

  expect(quiz.getScoreInPoints(), equals(60)); // check total points
});

  //Player test
  group('Player Tests', () {
    test('Player initial score should be 0', () {
      Player player = Player(name: "Alice");
      expect(player.lastScorePoints, equals(0));
    });
    test('Player score updates correctly', () {
      Player player = Player(name: "Bob");
      player.updateScore(50);
      expect(player.lastScorePoints, equals(50));
      player.updateScore(80);
      expect(player.lastScorePoints, equals(80));
    });
    test('Multiple players keep separate scores', () {
      Player player1 = Player(name: "Alice");
      Player player2 = Player(name: "Bob");
      player1.updateScore(60);
      player2.updateScore(40);
      expect(player1.lastScorePoints, equals(60));
      expect(player2.lastScorePoints, equals(40));
    });
  });
}