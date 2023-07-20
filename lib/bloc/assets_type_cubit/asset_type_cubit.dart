
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:photo_manager/photo_manager.dart';

part 'asset_type_state.dart';

class AssetTypeCubit extends Cubit<AssetTypeState> {
  AssetTypeCubit() : super(AssetTypeInitial());

  Future<void> identifyAssetType(AssetEntity asset) async {
    emit(AssetTypeIdentifyingState());
    final file = await asset.file;
    final type = lookupMimeType(file!.path);
    switch (type?.split('/')[0] ?? '') {
      case 'image':
        emit( AssetTypeIdentifiedState(AssetType.image, file));
        break;
      case 'video':
        emit( AssetTypeIdentifiedState(AssetType.video, file));
        break;
      default:
        emit( AssetTypeIdentifiedState(AssetType.other, file));
    }
  }
}

class AssetTypeCubitMap {
  final Map<AssetEntity, AssetTypeCubit> _cubitMap = {};

  AssetTypeCubit getCubitForAsset(AssetEntity asset) {
    return _cubitMap[asset] ??= AssetTypeCubit();
  }

  void removeCubitForAsset(AssetEntity asset) {
    _cubitMap.remove(asset);
  }
}