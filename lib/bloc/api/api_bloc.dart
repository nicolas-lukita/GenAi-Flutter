import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_event.dart';

import 'package:gen_ai_frontend/bloc/api/api_state.dart';
import 'package:gen_ai_frontend/repositories/api_repository.dart';

class ApiBloc extends HydratedBloc<ApiEvent, ApiState> {
  final ApiRepository apiRepository;

  ApiBloc({required this.apiRepository})
      : super(
            const ApiState(user: UserState(), responseState: ResponseState())) {
    on<ApiGetUserDataEvent>(_getUserData);
    on<ClearUserDataEvent>(_clearUserDataEvent);
    on<SubmitQueryEvent>(_submitQueryEvent);
    on<ClearResponseStateEvent>(_clearResponseState);
    on<TempEvent>((TempEvent event, Emitter<ApiState> emit) {
      emit(state.copyWith(
          responseState: state.responseState.copyWith(
              isResultLoading: false,
              isCalculationLoading: false,
              isReasoningLoading: false,
              isGenQuestionsLoading: false,
              isLoading: false)));
    });
  }

  void _clearResponseState(
      ClearResponseStateEvent event, Emitter<ApiState> emit) {
    emit(state.copyWith(responseState: const ResponseState()));
  }

  void _submitQueryEvent(SubmitQueryEvent event, Emitter<ApiState> emit) async {
    try {
      emit(state.copyWith(
          responseState: state.responseState.copyWith(
              isLoading: true,
              isResultLoading: true,
              isCalculationLoading: true,
              isReasoningLoading: true,
              isGenQuestionsLoading: true)));
      final List<dynamic> convoHistory = event.isNewQuestion
          ? []
          : (state.responseState.conversationHistory ?? []);
      //========================================================================
      final answerResponse = await apiRepository.answerQuery(event.question,
          state.user.userId!, event.persona, event.language, convoHistory);
      final aiResponse = answerResponse.response?['result'] ?? "";
      if (answerResponse.error == null) {
        emit(state.copyWith(
            responseState: state.responseState.copyWith(
          isLoading: false,
          isResultLoading: false,
          result: aiResponse,
          conversationHistory: [
            ...convoHistory,
            ...answerResponse.response?['conversation-history'],
          ],
        )));
      } else {
        final errorResponseState = UserState(error: answerResponse.error);
        emit(state.copyWith(user: errorResponseState));
      }
      //========================================================================
      final calculationResponse = await apiRepository.calculationQuery(
        event.question,
        aiResponse,
        state.user.userId!,
        event.persona,
        event.language,
      );
      if (answerResponse.error == null) {
        emit(state.copyWith(
            responseState: state.responseState.copyWith(
                calculation: calculationResponse.response?['calculation'],
                isCalculationLoading: false)));
      } else {
        final errorResponseState = UserState(error: answerResponse.error);
        emit(state.copyWith(user: errorResponseState));
      }
      //========================================================================
      final reasoningResponse = await apiRepository.reasoningQuery(
          aiResponse, state.user.userId!, event.persona, event.language);
      if (answerResponse.error == null) {
        emit(state.copyWith(
            responseState: state.responseState.copyWith(
                reasoning: reasoningResponse.response?['reasoning'],
                isReasoningLoading: false)));
      } else {
        final errorResponseState = UserState(error: answerResponse.error);
        emit(state.copyWith(user: errorResponseState));
      }
      //========================================================================
      final generatedQuestionsResponse = await apiRepository
          .generatedQuestionsQuery(aiResponse, event.language);
      if (answerResponse.error == null) {
        emit(state.copyWith(
            responseState: state.responseState.copyWith(
                questions: generatedQuestionsResponse.response?['questions'],
                isGenQuestionsLoading: false)));
      } else {
        final errorResponseState = UserState(error: answerResponse.error);
        emit(state.copyWith(user: errorResponseState));
      }
      //========================================================================
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _clearUserDataEvent(
      ClearUserDataEvent event, Emitter<ApiState> emit) async {
    emit(state.copyWith(user: const UserState()));
  }

  void _getUserData(ApiGetUserDataEvent event, Emitter<ApiState> emit) async {
    final response = await apiRepository.getUser(event.userId);
    if (response.error == null) {
      final data = jsonDecode(response.response?.data);
      final user = UserState(
        userId: event.userId,
        income: double.parse(data['收入']),
        asset: double.parse(data['資產']),
        debt: double.parse(data['債務']),
        investmentObjective: _parseInvestmentObjective(data['投資目標']),
        age: int.parse(data['年齡']),
        maritalStatus: _parseMaritalStatus(data['婚姻狀況']),
        occupationType: _parseOccupationType(data['職業種類']),
        accountBalance: double.parse(data['帳戶餘額']),
        riskTolerance: _parseRiskTolerance(data['風險承受能力']),
        portfolioStocks: double.parse(data['投資組合_股票']),
        portfolioBonds: double.parse(data['投資組合_債券']),
        portfolioCommodities: double.parse(data['投資組合_商品']),
        portfolioRealEstate: double.parse(data['投資組合_不動產']),
        portfolioCash: double.parse(data['投資組合_現金等價物']),
        portfolioOther: double.parse(data['投資組合_其他']),
      );
      emit(state.copyWith(user: user));
    } else {
      final errorUserState = UserState(error: response.error);
      emit(state.copyWith(user: errorUserState));
    }
  }

  @override
  ApiState? fromJson(Map<String, dynamic> json) {
    return ApiState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ApiState state) {
    return state.toJson();
  }
}

InvestmentObjective _parseInvestmentObjective(String value) {
  switch (value) {
    case "保值":
      return InvestmentObjective.guarantee;
    case "收益":
      return InvestmentObjective.gain;
    case "增值":
      return InvestmentObjective.increment;
    default:
      return InvestmentObjective.unassigned;
  }
}

OccupationType _parseOccupationType(String value) {
  switch (value) {
    case "固定收入":
      return OccupationType.fixedIncome;
    case "非固定收入":
      return OccupationType.nonFixedIncome;
    default:
      return OccupationType.unassigned;
  }
}

RiskTolerance _parseRiskTolerance(String value) {
  switch (value) {
    case "高":
      return RiskTolerance.high;
    case "中":
      return RiskTolerance.mid;
    case "低":
      return RiskTolerance.low;
    default:
      return RiskTolerance.unassigned;
  }
}

MaritalStatus _parseMaritalStatus(String value) {
  switch (value) {
    case "已婚有子":
      return MaritalStatus.marriedWithChildren;
    case "已婚無子":
      return MaritalStatus.marriedWithoutChildren;
    case "未婚":
      return MaritalStatus.single;
    default:
      return MaritalStatus.unassigned;
  }
}
