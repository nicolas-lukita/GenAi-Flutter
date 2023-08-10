import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object> get props => [];
}

class ApiGetUserDataEvent extends ApiEvent {
  final String userId;
  const ApiGetUserDataEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SubmitQueryEvent extends ApiEvent {
  final String question;
  final String persona;
  final String language;
  final bool isNewQuestion;
  const SubmitQueryEvent(
      {required this.question,
      required this.persona,
      required this.language,
      required this.isNewQuestion});

  @override
  List<Object> get props => [question, persona, language];
}

class ClearUserDataEvent extends ApiEvent {
  const ClearUserDataEvent();

  @override
  List<Object> get props => [];
}

class ClearResponseStateEvent extends ApiEvent {
  const ClearResponseStateEvent();

  @override
  List<Object> get props => [];
}

class TempEvent extends ApiEvent {
  const TempEvent();

  @override
  List<Object> get props => [];
}
