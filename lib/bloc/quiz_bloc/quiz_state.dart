part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizUploadingState extends QuizState {}

class QuizUploadedState extends QuizState {
  final String message;

  const QuizUploadedState(this.message);
}

class QuizErrorState extends QuizState {
  final String message;

  const QuizErrorState(this.message);
}
