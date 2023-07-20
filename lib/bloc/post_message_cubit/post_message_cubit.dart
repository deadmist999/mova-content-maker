import 'package:flutter_bloc/flutter_bloc.dart';

class PostMessageCubit extends Cubit<String> {
  PostMessageCubit() : super('');

  void changedPostTextField(String msg) {
    emit(msg);
  }

  void clearedPostTextField() {
    emit('');
  }
}
