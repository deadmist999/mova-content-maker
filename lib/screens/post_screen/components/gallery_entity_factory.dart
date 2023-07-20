import 'dart:io';

import 'package:flutter/material.dart';

import 'package:photo_manager/photo_manager.dart';

class GalleryEntityFactory extends StatelessWidget {
  final AssetEntity asset;
  final File file;
  final Color color;

  const GalleryEntityFactory({
    Key? key,
    required this.asset,
    required this.color,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.darken),
      child: _buildImage(asset),
    );
  }

  Widget _buildImage(AssetEntity asset) {
    return Image(
      image: AssetEntityImageProvider(asset),
      fit: BoxFit.cover,
    );
  }

}
