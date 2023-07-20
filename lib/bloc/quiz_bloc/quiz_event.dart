part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class UploadQuizEvent extends QuizEvent {
  final String question;
  final Map<String, bool> options;
  final String? explanation;

  const UploadQuizEvent(this.question, this.options, this.explanation);
}
