import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class MediaViewer extends StatelessWidget {
  final File mediaFile;
  final AssetType type;

  const MediaViewer({Key? key, required this.mediaFile, required this.type})
      : super(key: key);

  String get title {
    switch (type) {
      case AssetType.image:
        return 'зображення';
      case AssetType.video:
        return 'відео';
      default:
        return 'медіа';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(type.name);
    return Scaffold(
      appBar: AppBar(
        title: Text('Перегляд $title'),
      ),
      body: Builder(builder: (_) {
        switch (type) {
          case AssetType.image:
            return PhotoView(
              imageProvider: FileImage(mediaFile),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2.0,
            );
          case AssetType.video:
            return _buildVideo(mediaFile);
          default:
            return PhotoView(
              imageProvider: FileImage(mediaFile),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2.0,
            );
        }
      }),
    );
  }

  Widget _buildVideo(File file) {
    final videoController = VideoPlayerController.file(file);
    final videoPlayer = VideoPlayer(videoController);
    videoController.initialize().then((_) {
      videoController.play();
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final videoAspectRatio = videoController.value.aspectRatio;
        final maxWidth = constraints.maxWidth;
        final maxHeight = maxWidth / videoAspectRatio;
        return SizedBox(
          height: maxHeight,
          width: maxWidth,
          child: AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: videoPlayer,
          ),
        );
      },
    );
  }
}
