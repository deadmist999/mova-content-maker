import 'package:flutter_bloc/flutter_bloc.dart';

class PostImageCaptionCubit extends Cubit<String> {
  PostImageCaptionCubit() : super('');

  void changedCaptionField(String msg) {
    emit(msg);
  }

  void clearedCaptionField() {
    emit('');
  }
}
