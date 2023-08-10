import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_event.dart';
import 'package:gen_ai_frontend/bloc/api/api_state.dart';
import 'package:gen_ai_frontend/components/assets_chart.dart';
import 'package:gen_ai_frontend/components/comparison_chart.dart';
import 'package:gen_ai_frontend/components/monthly_line_chart.dart';
import 'package:gen_ai_frontend/constants/colors.dart';
import 'package:gen_ai_frontend/screens/answer_screen.dart';
import 'package:gen_ai_frontend/screens/components/query_modal.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isLoading = true;
  bool _isModalVisible = false;
  bool _isResponseStateVisible = false;
  late String pieChartData;
  late String comparisonData;
  late String monthlyData;

  void toggleModal() {
    setState(() {
      _isModalVisible = !_isModalVisible;
    });
  }

  Future<String> _loadPieChartData() async {
    return await DefaultAssetBundle.of(context)
        .loadString('lib/dummy_data/pie_chart_data.json');
  }

  Future<String> _loadComparisonData() async {
    return await DefaultAssetBundle.of(context)
        .loadString('lib/dummy_data/comparison_data.json');
  }

  Future<String> _loadMonthlyData() async {
    return await DefaultAssetBundle.of(context)
        .loadString('lib/dummy_data/monthly_data.json');
  }

  Future<void> _loadData() async {
    String pieChartJson = await _loadPieChartData();
    String comparisonJson = await _loadComparisonData();
    String monthlyJson = await _loadMonthlyData();

    setState(() {
      pieChartData = pieChartJson;
      comparisonData = comparisonJson;
      monthlyData = monthlyJson;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : BlocBuilder<ApiBloc, ApiState>(
            builder: (apiContext, apiState) {
              return Stack(
                children: [
                  Scaffold(
                    backgroundColor: backgroundWhite,
                    appBar: AppBar(
                      leading: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: IconButton(
                          icon: Image.asset('assets/icons/S8_logo.ico'),
                          onPressed: () => BlocProvider.of<ApiBloc>(context)
                              .add(const ClearUserDataEvent()),
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.white,
                      ),
                      backgroundColor: backgroundBlack,
                      elevation: 0,
                      actions: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Elon Mush",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                apiState.user.userId!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Center(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/avatar.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ComparisonChart(
                                data: jsonEncode({
                              "Asset": apiState.user.asset,
                              "Debt": apiState.user.debt
                            })),
                            MonthlyLineChart(title: "淨資產", data: monthlyData),
                            AssetsChart(
                                data: jsonEncode({
                              "Stocks": apiState.user.portfolioStocks,
                              "Bonds": apiState.user.portfolioBonds,
                              "Commodities": apiState.user.portfolioCommodities,
                              "Real-estate": apiState.user.portfolioRealEstate,
                              "Cash-equivalents": apiState.user.portfolioCash,
                              "Others": apiState.user.portfolioOther
                            })),
                            AssetsChart(data: pieChartData),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // TextButton(
                            //     onPressed: () {
                            //       BlocProvider.of<ApiBloc>(context)
                            //           .add(const ClearResponseStateEvent());
                            //     },
                            //     child: const Text("Clear Response State")),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isResponseStateVisible =
                                        !_isResponseStateVisible;
                                  });
                                },
                                child: const Text("Show Response State")),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // TextButton(
                            //     onPressed: () {
                            //       BlocProvider.of<ApiBloc>(context)
                            //           .add(const TempEvent());
                            //     },
                            //     child: const Text("Temp button")),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const AnswerScreen())));
                                },
                                child: const Text(
                                  "GOTO Answers page ->",
                                  style: TextStyle(color: splashColor),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            if (_isResponseStateVisible)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      "=================RESULT================="),
                                  Text(apiState.responseState.result ??
                                      "NO DATA"),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                      "===============CALCULATION=============="),
                                  Text(apiState.responseState.calculation ??
                                      "NO DATA"),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                      "===============REASONING==============="),
                                  Text(apiState.responseState.reasoning ??
                                      "NO DATA"),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                      "================QUESTIONS=============="),
                                  Text(apiState.responseState.questions
                                      .toString()),
                                  if (apiState.responseState.questions != null)
                                    Text(apiState.responseState.questions?[0]),
                                  if (apiState.responseState.questions != null)
                                    Text(apiState.responseState.questions?[1]),
                                  if (apiState.responseState.questions != null)
                                    Text(apiState.responseState.questions?[2]),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                      "==============CONVO-HISTORY============"),
                                  if (apiState
                                          .responseState.conversationHistory !=
                                      null)
                                    Text(apiState
                                        .responseState.conversationHistory
                                        .toString()),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                      "================isLOADING==============="),
                                  Text(
                                      "isLoading: ${apiState.responseState.isLoading.toString()}"),
                                  Text(
                                      "isResultLoading: ${apiState.responseState.isResultLoading.toString()}"),
                                  Text(
                                      "isCalculationLoading: ${apiState.responseState.isCalculationLoading.toString()}"),
                                  Text(
                                      "isReasoningLoading: ${apiState.responseState.isReasoningLoading.toString()}"),
                                  Text(
                                      "isGenQuestionsLoading: ${apiState.responseState.isGenQuestionsLoading.toString()}"),
                                  const Text(
                                      "========================================"),
                                ],
                              ),
                            const SizedBox(
                              height: 80,
                            )
                          ],
                        ),
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      elevation: 3,
                      onPressed: () {
                        setState(() {
                          _isModalVisible = true;
                        });
                      },
                      tooltip: 'New Query',
                      backgroundColor: splashColor,
                      child:
                          const Icon(Icons.chat_outlined, color: Colors.white),
                    ),
                  ),
                  if (_isModalVisible)
                    QueryModal(
                      title: "Ask a question",
                      toggleModal: toggleModal,
                      isGenQuestionsVisible: false,
                    )
                ],
              );
            },
          );
  }
}
