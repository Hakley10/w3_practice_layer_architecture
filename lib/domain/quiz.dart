import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Question{
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question({String? id, required this.title, required this.choices, required this.goodChoice, required this.point}) : id = id ?? uuid.v4();

   Map<String, dynamic> toJson() => {
         'id': id,
        'title': title,
        'choices': choices,
        'goodChoice': goodChoice,
        'point': point,
   };
  
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id : json['id'],
      title: json['title'],
      choices: List<String>.from(json['choices']),
      goodChoice: json['goodChoice'],
      point: json['point'],
    );
  }
}

class Answer{
  final String id;
  final Question question;
  final String answerChoice;
  
  Answer({String? id, required this.question, required this.answerChoice}) : id = id ?? uuid.v4();

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz{
  final String id;
  List<Question> questions;
  List <Answer> answers =[];

  Quiz({String? id, required this.questions}) : id = id ?? uuid.v4();

  void addAnswer(Answer asnwer) {
     this.answers.add(asnwer);
  }

  int getScoreInPercentage(){
    int totalSCore =0;
    for(Answer answer in answers){
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore/ questions.length)*100).toInt();

  }

  int getScoreInPoints(){
    int totalPoints = 0;
    for(Answer answer in answers){
      if (answer.isGood()){
        totalPoints += answer.question.point;
      }
    }
    return (totalPoints);
  }
}

class Player {
  final String id;
  final String name;
  int lastScorePoints = 0;

  Player({String? id, required this.name}) : id = id ?? uuid.v4();

  void updateScore(int points) {
    lastScorePoints = points;
  }
}
