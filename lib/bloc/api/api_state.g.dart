// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiState _$ApiStateFromJson(Map<String, dynamic> json) => ApiState(
      user: UserState.fromJson(json['user'] as Map<String, dynamic>),
      responseState:
          ResponseState.fromJson(json['responseState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiStateToJson(ApiState instance) => <String, dynamic>{
      'user': instance.user,
      'responseState': instance.responseState,
    };

ResponseState _$ResponseStateFromJson(Map<String, dynamic> json) =>
    ResponseState(
      data: json['data'] as Map<String, dynamic>?,
      result: json['result'] as String?,
      calculation: json['calculation'] as String?,
      reasoning: json['reasoning'] as String?,
      questions: json['questions'] as List<dynamic>?,
      conversationHistory: json['conversationHistory'] as List<dynamic>?,
      isLoading: json['isLoading'] as bool?,
      isResultLoading: json['isResultLoading'] as bool?,
      isCalculationLoading: json['isCalculationLoading'] as bool?,
      isReasoningLoading: json['isReasoningLoading'] as bool?,
      isGenQuestionsLoading: json['isGenQuestionsLoading'] as bool?,
      error: json['error'] == null
          ? null
          : BackendError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseStateToJson(ResponseState instance) =>
    <String, dynamic>{
      'data': instance.data,
      'result': instance.result,
      'calculation': instance.calculation,
      'reasoning': instance.reasoning,
      'questions': instance.questions,
      'conversationHistory': instance.conversationHistory,
      'isLoading': instance.isLoading,
      'isResultLoading': instance.isResultLoading,
      'isCalculationLoading': instance.isCalculationLoading,
      'isReasoningLoading': instance.isReasoningLoading,
      'isGenQuestionsLoading': instance.isGenQuestionsLoading,
      'error': instance.error,
    };

UserState _$UserStateFromJson(Map<String, dynamic> json) => UserState(
      userId: json['userId'] as String?,
      income: (json['income'] as num?)?.toDouble(),
      asset: (json['asset'] as num?)?.toDouble(),
      debt: (json['debt'] as num?)?.toDouble(),
      investmentObjective: $enumDecodeNullable(
          _$InvestmentObjectiveEnumMap, json['investmentObjective']),
      age: json['age'] as int?,
      maritalStatus:
          $enumDecodeNullable(_$MaritalStatusEnumMap, json['maritalStatus']),
      occupationType:
          $enumDecodeNullable(_$OccupationTypeEnumMap, json['occupationType']),
      accountBalance: (json['accountBalance'] as num?)?.toDouble(),
      riskTolerance:
          $enumDecodeNullable(_$RiskToleranceEnumMap, json['riskTolerance']),
      portfolioStocks: (json['portfolioStocks'] as num?)?.toDouble(),
      portfolioBonds: (json['portfolioBonds'] as num?)?.toDouble(),
      portfolioCommodities: (json['portfolioCommodities'] as num?)?.toDouble(),
      portfolioRealEstate: (json['portfolioRealEstate'] as num?)?.toDouble(),
      portfolioCash: (json['portfolioCash'] as num?)?.toDouble(),
      portfolioOther: (json['portfolioOther'] as num?)?.toDouble(),
      error: json['error'] == null
          ? null
          : BackendError.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'userId': instance.userId,
      'income': instance.income,
      'asset': instance.asset,
      'debt': instance.debt,
      'investmentObjective':
          _$InvestmentObjectiveEnumMap[instance.investmentObjective],
      'age': instance.age,
      'maritalStatus': _$MaritalStatusEnumMap[instance.maritalStatus],
      'occupationType': _$OccupationTypeEnumMap[instance.occupationType],
      'accountBalance': instance.accountBalance,
      'riskTolerance': _$RiskToleranceEnumMap[instance.riskTolerance],
      'portfolioStocks': instance.portfolioStocks,
      'portfolioBonds': instance.portfolioBonds,
      'portfolioCommodities': instance.portfolioCommodities,
      'portfolioRealEstate': instance.portfolioRealEstate,
      'portfolioCash': instance.portfolioCash,
      'portfolioOther': instance.portfolioOther,
      'error': instance.error,
    };

const _$InvestmentObjectiveEnumMap = {
  InvestmentObjective.guarantee: 'guarantee',
  InvestmentObjective.gain: 'gain',
  InvestmentObjective.increment: 'increment',
  InvestmentObjective.unassigned: 'unassigned',
};

const _$MaritalStatusEnumMap = {
  MaritalStatus.marriedWithChildren: 'marriedWithChildren',
  MaritalStatus.marriedWithoutChildren: 'marriedWithoutChildren',
  MaritalStatus.single: 'single',
  MaritalStatus.unassigned: 'unassigned',
};

const _$OccupationTypeEnumMap = {
  OccupationType.fixedIncome: 'fixedIncome',
  OccupationType.nonFixedIncome: 'nonFixedIncome',
  OccupationType.unassigned: 'unassigned',
};

const _$RiskToleranceEnumMap = {
  RiskTolerance.high: 'high',
  RiskTolerance.mid: 'mid',
  RiskTolerance.low: 'low',
  RiskTolerance.unassigned: 'unassigned',
};
