import 'package:flutter/material.dart';
import 'package:gen_ai_frontend/screens/components/loading_indicator.dart';
import 'package:gen_ai_frontend/screens/components/question_item.dart';

class GeneratedQuestions extends StatelessWidget {
  final List? questions;
  final double height;
  final Orientation orientation;
  final bool isLoading;
  final void Function(String) onTap;
  const GeneratedQuestions(
      {super.key,
      required this.questions,
      required this.height,
      required this.orientation,
      required this.isLoading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        child: Container(
          child: (!isLoading && questions != null)
              ? Column(
                  mainAxisAlignment:
                      orientation == Orientation.portrait && !isLoading
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    QuestionItem(question: questions![0], onTap: onTap),
                    const SizedBox(
                      height: 20,
                    ),
                    QuestionItem(question: questions![1], onTap: onTap),
                    const SizedBox(
                      height: 20,
                    ),
                    QuestionItem(question: questions![2], onTap: onTap),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: height * 0.67,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: (!isLoading && questions == null)
                              ? const Text("No suggested questions...")
                              : const LoadingIndicator(
                                  desc: "Suggesting questions...")),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
