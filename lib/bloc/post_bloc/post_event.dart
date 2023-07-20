part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class UploadPostMessageEvent extends PostEvent {
  final String message;

  const UploadPostMessageEvent(this.message);
}

class UploadAssetsEvent extends PostEvent {
  final List<AssetEntity> assets;
  final String caption;

  const UploadAssetsEvent({required this.assets, required this.caption});
}

