import 'package:equatable/equatable.dart';
import 'package:gen_ai_frontend/repositories/models/backend_error.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_state.g.dart';

enum InvestmentObjective { guarantee, gain, increment, unassigned }

enum OccupationType { fixedIncome, nonFixedIncome, unassigned }

enum RiskTolerance { high, mid, low, unassigned }

enum MaritalStatus {
  marriedWithChildren,
  marriedWithoutChildren,
  single,
  unassigned
}

@JsonSerializable()
class ApiState extends Equatable {
  final UserState user;
  final ResponseState responseState;
  const ApiState({required this.user, required this.responseState});

  ApiState copyWith({UserState? user, ResponseState? responseState}) {
    return ApiState(
        user: user ?? this.user,
        responseState: responseState ?? this.responseState);
  }

  @override
  List<Object> get props => [user, responseState];

  factory ApiState.fromJson(Map<String, dynamic> json) =>
      _$ApiStateFromJson(json);

  Map<String, dynamic> toJson() => _$ApiStateToJson(this);
}

@JsonSerializable()
class ResponseState extends Equatable {
  final Map<String, dynamic>? data;
  final String? result;
  final String? calculation;
  final String? reasoning;
  final List? questions;
  final List<dynamic>? conversationHistory;
  final bool? isLoading;
  final bool? isResultLoading;
  final bool? isCalculationLoading;
  final bool? isReasoningLoading;
  final bool? isGenQuestionsLoading;
  final BackendError? error;
  const ResponseState(
      {this.data,
      this.result,
      this.calculation,
      this.reasoning,
      this.questions,
      this.conversationHistory,
      this.isLoading,
      this.isResultLoading,
      this.isCalculationLoading,
      this.isReasoningLoading,
      this.isGenQuestionsLoading,
      this.error});

  ResponseState copyWith(
      {Map<String, dynamic>? data,
      String? result,
      String? calculation,
      String? reasoning,
      List? questions,
      List<dynamic>? conversationHistory,
      bool? isLoading,
      bool? isResultLoading,
      bool? isCalculationLoading,
      bool? isReasoningLoading,
      bool? isGenQuestionsLoading,
      BackendError? error}) {
    return ResponseState(
        data: data ?? this.data,
        result: result ?? this.result,
        calculation: calculation ?? this.calculation,
        reasoning: reasoning ?? this.reasoning,
        questions: questions ?? this.questions,
        conversationHistory: conversationHistory ?? this.conversationHistory,
        isLoading: isLoading ?? this.isLoading,
        isResultLoading: isResultLoading ?? this.isResultLoading,
        isCalculationLoading: isCalculationLoading ?? this.isCalculationLoading,
        isReasoningLoading: isReasoningLoading ?? this.isReasoningLoading,
        isGenQuestionsLoading:
            isGenQuestionsLoading ?? this.isGenQuestionsLoading,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [
        data,
        result,
        calculation,
        reasoning,
        questions,
        isLoading,
        conversationHistory,
        isResultLoading,
        isCalculationLoading,
        isReasoningLoading,
        isGenQuestionsLoading,
        error
      ];

  factory ResponseState.fromJson(Map<String, dynamic> json) =>
      _$ResponseStateFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseStateToJson(this);
}

@JsonSerializable()
class UserState extends Equatable {
  final String? userId;
  final double? income;
  final double? asset;
  final double? debt;
  final InvestmentObjective? investmentObjective;
  final int? age;
  final MaritalStatus? maritalStatus;
  final OccupationType? occupationType;
  final double? accountBalance;
  final RiskTolerance? riskTolerance;
  final double? portfolioStocks;
  final double? portfolioBonds;
  final double? portfolioCommodities;
  final double? portfolioRealEstate;
  final double? portfolioCash;
  final double? portfolioOther;
  final BackendError? error;

  const UserState(
      {this.userId,
      this.income,
      this.asset,
      this.debt,
      this.investmentObjective,
      this.age,
      this.maritalStatus,
      this.occupationType,
      this.accountBalance,
      this.riskTolerance,
      this.portfolioStocks,
      this.portfolioBonds,
      this.portfolioCommodities,
      this.portfolioRealEstate,
      this.portfolioCash,
      this.portfolioOther,
      this.error});

  UserState copyWith(
      {String? userId,
      double? income,
      double? asset,
      double? debt,
      InvestmentObjective? investmentObjective,
      int? age,
      MaritalStatus? maritalStatus,
      OccupationType? occupationType,
      double? accountBalance,
      RiskTolerance? riskTolerance,
      double? portfolioStocks,
      double? portfolioBonds,
      double? portfolioCommodities,
      double? portfolioRealEstate,
      double? portfolioCash,
      double? portfolioOther,
      BackendError? error}) {
    return UserState(
        userId: userId ?? this.userId,
        income: income ?? this.income,
        asset: asset ?? this.asset,
        debt: debt ?? this.debt,
        investmentObjective: investmentObjective ?? this.investmentObjective,
        age: age ?? this.age,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        occupationType: occupationType ?? this.occupationType,
        accountBalance: accountBalance ?? this.accountBalance,
        riskTolerance: riskTolerance ?? this.riskTolerance,
        portfolioStocks: portfolioStocks ?? this.portfolioStocks,
        portfolioBonds: portfolioBonds ?? this.portfolioBonds,
        portfolioCommodities: portfolioCommodities ?? this.portfolioCommodities,
        portfolioRealEstate: portfolioRealEstate ?? this.portfolioRealEstate,
        portfolioCash: portfolioCash ?? this.portfolioCash,
        portfolioOther: portfolioOther ?? this.portfolioOther,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [
        userId,
        income,
        asset,
        debt,
        investmentObjective,
        age,
        maritalStatus,
        occupationType,
        accountBalance,
        riskTolerance,
        portfolioStocks,
        portfolioBonds,
        portfolioCommodities,
        portfolioRealEstate,
        portfolioCash,
        portfolioOther,
        error
      ];

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserStateToJson(this);
}
