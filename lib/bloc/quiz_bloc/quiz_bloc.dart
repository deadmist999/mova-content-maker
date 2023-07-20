import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mova_content_maker/services/firestore_api.dart';
import 'package:mova_content_maker/services/telegram_api.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<UploadQuizEvent>((event, emit) async {
      emit(QuizUploadingState());
      try {
        if (_validateGeneratedQuiz(event.question, event.options, emit)) {
          await FirestoreApi().addQuizToFirestore(
              event.question, event.options, event.explanation);
          await TelegramApi()
              .sendQuiz(event.question, event.options, event.explanation);
          emit(const QuizUploadedState('Вікторина була успішно створена!'));
        }
      } catch (_) {
        emit(const QuizErrorState(
            'Відбулась несподівана помилка. Спробуйте ще раз!'));
      }
    });
  }

  bool _validateGeneratedQuiz(
      String question, Map<String, bool> options, Emitter<QuizState> emit) {
    bool res = true;
    if (question.isEmpty) {
      emit(const QuizErrorState('Уведіть питання вікторини!'));
      res = false;
    }
    if (options.length < 2) {
      emit(const QuizErrorState('Уведіть дві або більше відповідей!'));
      res = false;
    }
    if (!options.values.any((value) => value == true)) {
      emit(const QuizErrorState('Уведіть правильну відповідь!'));
      res = false;
    }
    return res;
  }
}
