import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_event.dart';
import 'package:gen_ai_frontend/bloc/api/api_state.dart';
import 'package:gen_ai_frontend/screens/answer_screen.dart';
import 'package:gen_ai_frontend/screens/components/generated_questions.dart';
import 'package:gen_ai_frontend/screens/components/new_query_form.dart';

class QueryModal extends StatefulWidget {
  final String title;
  final bool isGenQuestionsVisible;
  final void Function() toggleModal;
  const QueryModal(
      {super.key,
      required this.toggleModal,
      required this.title,
      required this.isGenQuestionsVisible});

  @override
  State<QueryModal> createState() => _QueryModalState();
}

class _QueryModalState extends State<QueryModal> {
  final TextEditingController controller = TextEditingController();
  String persona = "Warren Buffett";
  String language = "English";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiBloc, ApiState>(
      builder: (apiContext, apiState) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                  child: MediaQuery.of(context).orientation ==
                          Orientation.portrait
                      ? Column(
                          mainAxisAlignment:
                              apiState.responseState.questions == null ||
                                      !widget.isGenQuestionsVisible
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.end,
                          children: [
                            NewQueryForm(
                              formTitle: widget.title,
                              controller: controller,
                              toggleModal: widget.toggleModal,
                              onSubmit: onSubmit,
                              persona: persona,
                              language: language,
                              onChangePersona: updatePersona,
                              onChangeLanguage: updateLanguage,
                            ),
                            if (widget.isGenQuestionsVisible)
                              GeneratedQuestions(
                                  questions: apiState.responseState.questions,
                                  height:
                                      MediaQuery.of(context).size.height * 0.33,
                                  orientation: Orientation.portrait,
                                  isLoading: apiState
                                      .responseState.isGenQuestionsLoading!,
                                  onTap: onTapGeneratedQuestion),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.isGenQuestionsVisible)
                              GeneratedQuestions(
                                  questions: apiState.responseState.questions,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  orientation: Orientation.landscape,
                                  isLoading: apiState
                                      .responseState.isGenQuestionsLoading!,
                                  onTap: onTapGeneratedQuestion),
                            const SizedBox(
                              width: 50,
                            ),
                            NewQueryForm(
                              formTitle: widget.title,
                              controller: controller,
                              toggleModal: widget.toggleModal,
                              onSubmit: onSubmit,
                              persona: persona,
                              language: language,
                              onChangePersona: updatePersona,
                              onChangeLanguage: updateLanguage,
                            ),
                          ],
                        )),
            ),
          ),
        );
      },
    );
  }

  void updatePersona(String? value) {
    if (value != null) {
      setState(() {
        persona = value;
      });
    }
  }

  void updateLanguage(String? value) {
    if (value != null) {
      setState(() {
        language = value;
      });
    }
  }

  void onSubmit() {
    BlocProvider.of<ApiBloc>(context).add(SubmitQueryEvent(
        question: controller.text,
        persona: persona,
        language: language,
        isNewQuestion: true));
    widget.toggleModal();
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const AnswerScreen())));
  }

  void onTapGeneratedQuestion(String question) {
    BlocProvider.of<ApiBloc>(context).add(SubmitQueryEvent(
        question: question,
        persona: persona,
        language: language,
        isNewQuestion: false));
    widget.toggleModal();
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const AnswerScreen())));
  }
}
