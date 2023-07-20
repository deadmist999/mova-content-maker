import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mova_content_maker/services/telegram_api.dart';
import 'package:photo_manager/photo_manager.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    final telegramApi = TelegramApi();

    on<UploadPostMessageEvent>((event, emit) async {
      try {
        emit(PostUploadingState());
        await telegramApi.sendMessage(event.message);
        emit(PostUploadedState());
      } catch (_) {
        emit(const PostErrorState(
            'Відбулась несподівана помилка. Спробуйте ще раз!'));
      }
    });

    on<UploadAssetsEvent>((event, emit) async {
      try {
        emit(PostUploadingState());
        final files = await convertAssetsToFiles(event.assets);
        await telegramApi.sendMediaData(files, event.caption);
        emit(PostUploadedState());
      } catch (_) {
        emit(const PostErrorState(
            'Відбулась несподівана помилка. Спробуйте ще раз!'));
      }
    });
  }

  Future<List<File>> convertAssetsToFiles(List<AssetEntity> assets) async {
    List<File> result = [];
    for (AssetEntity asset in assets) {
      final path = await asset.file;
      result.add(path!);
    }
    return result;
  }
}
