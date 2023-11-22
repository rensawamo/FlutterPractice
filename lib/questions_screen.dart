import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:udemyappfirst/answer_button.dart';
import 'package:udemyappfirst/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
  });

// 外からの刺激を受け取る
  final void Function(String answer) onSelectAnswer;
  // 監視する関数の名前を決める
  // swwiftUIの@ Stateと同じかんじ

// これまとめて変数だよ
  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

// それをどうやって定義するのかを決める
class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++; // increments the value by 1
    });
  }

  @override
  Widget build(context) {
    // dataはそのまま
    final currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // これは、スプレット演算(展開)
            ...currentQuestion.getShuffledAnswers().map((answer) {
              // 関数まで渡して
              //あくまで　answer buttonはコンポーネントとして使って。
              // ontapはできるようにcompornetの中に仕込んでおく　おか

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnswerButton(
                  answerText: answer,
                  onTap: () {
                    answerQuestion(answer);
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
