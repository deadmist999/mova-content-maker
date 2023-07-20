import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

part 'assets_state.dart';

class AssetsCubit extends Cubit<AssetsState> {
  AssetsCubit() : super(AssetsInitial());

  static const int batchSize = 20;

  List<AssetEntity> selectedAssets = [];

  Future<void> fetchAssets() async {
    final result = await PhotoManager.requestPermissionExtend();
    if (!result.hasAccess) {
      emit(const AssetsErrorState('Відсутній доступ до зображень.'));
      return;
    }
    List<AssetPathEntity> albums =
        await PhotoManager.getAssetPathList(type: RequestType.common);
    if (albums.isEmpty) {
      emit(const FetchedAssetsState([], []));
      return;
    }

    int totalAssetCount = await albums[0].assetCountAsync;

    List<File> files = [];

    for (int start = 0; start < totalAssetCount; start += batchSize) {
      int end = start + batchSize;
      if (end > totalAssetCount) {
        end = totalAssetCount;
      }

      List<AssetEntity> assets = await albums[0].getAssetListRange(
        start: 0,
        end: await albums[0].assetCountAsync,
      );

      for (var asset in assets) {
        final file = await asset.file;
        files.add(file!);
      }
      emit(FetchedAssetsState(assets, files));
    }
    emit(AssetsInitial());
  }
}
