import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_state.dart';
import 'package:gen_ai_frontend/constants/colors.dart';
import 'package:gen_ai_frontend/screens/components/loading_indicator.dart';
import 'package:gen_ai_frontend/screens/components/query_modal.dart';

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  bool _isModalVisible = false;
  void toggleModal() {
    setState(() {
      _isModalVisible = !_isModalVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiBloc, ApiState>(
      builder: (apiContext, apiState) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: backgroundWhite,
              appBar: AppBar(
                backgroundColor: backgroundBlack,
                title: const Text('AI Analysis'),
              ),
              body: (!apiState.responseState.isLoading!)
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _questionCard(context),
                            const SizedBox(height: 16.0),
                            _responseCard(
                              _cardHeader("Answer", Icons.check),
                              apiState.responseState.isResultLoading!
                                  ? const LoadingIndicator(
                                      desc: "Generating answer...")
                                  : _cardContent(
                                      apiState.responseState.result ??
                                          "Error Occured"),
                            ),
                            const SizedBox(height: 16.0),
                            _responseCard(
                              _cardHeader("Calculation", Icons.calculate),
                              apiState.responseState.isCalculationLoading!
                                  ? const LoadingIndicator(
                                      desc: "Calculating...")
                                  : _cardContent(
                                      apiState.responseState.calculation ??
                                          "Error Occured"),
                            ),
                            const SizedBox(height: 16.0),
                            _responseCard(
                              _cardHeader("Reasoning", Icons.lightbulb_outline),
                              apiState.responseState.isReasoningLoading!
                                  ? const LoadingIndicator(
                                      desc: "Generating reasoning...")
                                  : _cardContent(
                                      apiState.responseState.reasoning ??
                                          "Error Occured"),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: LoadingIndicator(
                          desc: "Generating personalized answer..."),
                    ),
            ),
            if (_isModalVisible)
              QueryModal(
                title: "Continue asking",
                toggleModal: toggleModal,
                isGenQuestionsVisible: true,
              )
          ],
        );
      },
    );
  }

  Widget _responseCard(Widget header, Widget content) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header, const SizedBox(height: 16.0), content],
        ),
      ),
    );
  }

  Widget _questionCard(BuildContext context) {
    return Card(
      color: Colors.blueGrey.withOpacity(1),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: toggleModal,
        borderRadius: BorderRadius.circular(12.0),
        splashColor: splashColor,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 36,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  'Ask more question?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardHeader(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blueGrey,
        ),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _cardContent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.blueGrey[900],
      ),
    );
  }
}
