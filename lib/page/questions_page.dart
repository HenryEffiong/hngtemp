import 'package:flutter/material.dart';
import '../brainy.dart';
import '../theme/theme.dart';
import 'result.dart';
import 'package:brainy/utils/timer.dart';



class QuestionsPage extends StatefulWidget {
  final String username;
  QuestionsPage({this.username});
  
  @override
  
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {

  Brainy brainy;
  String userResponse = "";
  int currentQ;
  @override
  void initState() {
    
    brainy = Brainy(username: widget.username);  
    currentQ = brainy.currentQuestion();
    super.initState();
  }

  void checkAnswer(String option) {
    
    String correctAnswer = brainy.getCorrectAnswer();

    setState(() {
      userResponse = option;

      if (userResponse == correctAnswer) {
        brainy.incrementScore();
        if (brainy.isFinished() == true) {
//        Navigator.sth to the results page
//      Throw an alert to the user that evaluation has finished

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => ResultPage(
                    correctScore: brainy.correctResponse,
                    wrongScore: brainy.wrongResponse,
                    totalScore: brainy.numberOfQuestions().floorToDouble(),
                    username: brainy.player,
                  )));
                  brainy.reset();
        }
        brainy.nextQuestion();
      } else {
        brainy.decrementScore();
        
        
        if (brainy.isFinished() == true) {
//        Navigator.sth to the results page
//      Throw an alert to the user that evaluation has finished
      
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => ResultPage(
                    correctScore: brainy.correctResponse,
                    wrongScore: brainy.wrongResponse,
                    totalScore: brainy.totalScore,
                    username: brainy.player,
                  )));
        }
        
        brainy.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarylightColor,
      appBar: customAppbar(
          context, "${brainy.currentQuestion() + 1}", brainy.totalQuestions),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Timer(),
              Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width * .8,
                alignment: Alignment.center,
                child: question(brainy.getQuestionText(), context),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .55,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Option(
                        option: brainy.getOptions()[0],
                        
                        onTap: () {
                          setState(() {
                        
                            checkAnswer(brainy.getOptions()[0]);
                          });
                        }),
                    Option(
                        option: brainy.getOptions()[1],
                        
                        onTap: () {
                          setState(() {
                            
                            checkAnswer(brainy.getOptions()[1]);
                          });
                        }),
                    Option(
                        option: brainy.getOptions()[2],
                        
                        onTap: () {
                          setState(() {
                            
                            checkAnswer(brainy.getOptions()[2]);
                          });
                        }),
                    Option(
                        option: brainy.getOptions()[3],
                        
                        onTap: () {
                          setState(() {
                        
                            checkAnswer(brainy.getOptions()[3]);
                          });
                        }),

                    
                  ],
                )),
              ),
            ]),
      ),
    );
  }
}

AppBar customAppbar(BuildContext context, currentQuestion, int totalQuestions) {
  return AppBar(
    backgroundColor: primarylightColor,
    title: Row(
      children: <Widget>[
        Text(
          'Question ',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          currentQuestion,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    ),
    actions: <Widget>[
      Center(
          child: Text(
        'Total Questions ',
        style: Theme.of(context).textTheme.bodyText2,
      )),
      Center(
          child: Text(
        "${totalQuestions.toString()}   ",
        style: Theme.of(context).textTheme.bodyText2,
      )),
    ],
  );
}

SingleChildScrollView question(String question, BuildContext ctx) {
  return SingleChildScrollView(
      child: Text(
      question,
      style: Theme.of(ctx).textTheme.bodyText1,
    ),
  );
}

class Option extends StatelessWidget {
  final String option;
  final Function onTap;
  Option({this.option, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        
        width: MediaQuery.of(context).size.width * .9,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015),
      //padding: EdgeInsets.all(3),
        child: InkWell(
      borderRadius: BorderRadius.circular(35),
      onTap: onTap,
      
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        
        padding: EdgeInsets.symmetric(
        vertical: 20,
        ),
        decoration: BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(30)),
        child: Center(
        child: Text(
    option,
    style: Theme.of(context).textTheme.bodyText1,
        ),
        ),
      ),
    ),
      );
  }
}
