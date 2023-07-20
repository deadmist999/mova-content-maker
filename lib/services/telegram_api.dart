import 'dart:io' as io;
import 'package:mime/mime.dart';
import 'package:mova_content_maker/utils/constants.dart';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

class TelegramApi {
  final _bot = Bot(Constants.telegramToken);

  final _chatId = ID.create(Constants.chatId);

  Future<void> sendQuiz(
      String question, Map<String, bool> options, String? explanation) {
    int correctOptionId =
        options.values.toList().indexWhere((value) => value == true);

    return _bot.api.sendPoll(
      _chatId,
      question,
      options.keys.toList(),
      correctOptionId: correctOptionId,
      type: PollType.quiz,
      explanation: explanation,
      allowsMultipleAnswers: false,
    );
  }

  Future<void> sendMessage(String msg) {
    return _bot.api.sendMessage(_chatId, msg);
  }

  Future<void> _sendMediaGroup(List<io.File> files, String caption) {
    final List<InputMedia> media = [];
    bool addedCaption = false;

    for (final file in files) {
      final String mimeType = _getFileMimeType(file);
      InputMedia inputMedia;

      switch (mimeType) {
        case 'image':
          inputMedia = addedCaption
              ? InputMediaPhoto(media: InputFile(file: file))
              : InputMediaPhoto(media: InputFile(file: file), caption: caption);
          break;
        case 'video':
          inputMedia = addedCaption
              ? InputMediaVideo(media: InputFile(file: file))
              : InputMediaVideo(media: InputFile(file: file), caption: caption);
          break;
        default:
          continue;
      }

      media.add(inputMedia);
      addedCaption = true;
    }

    return _bot.api.sendMediaGroup(_chatId, media);
  }

  Future<void> sendMediaData(List<io.File> files, String caption) async {
    if (files.length > 1) {
      return _sendMediaGroup(files, caption);
    }
    for (final file in files) {
      final type = _getFileMimeType(file);
      switch (type) {
        case 'image':
          return _sendPhoto(file, caption);
        case 'video':
          return _sendVideo(file, caption);
      }
    }
  }

  Future<void> _sendPhoto(io.File photoFile, String caption) {
    final photo = InputFile(file: photoFile);
    return _bot.api.sendPhoto(_chatId, photo, caption: caption);
  }

  Future<void> _sendVideo(io.File videoFile, String caption) {
    final video = InputFile(file: videoFile);
    return _bot.api.sendVideo(_chatId, video, caption: caption);
  }

  String _getFileMimeType(io.File file) {
    final type = lookupMimeType(file.path);
    return type != null ? type.split('/')[0] : '';
  }
}
