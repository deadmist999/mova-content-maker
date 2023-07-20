part of 'asset_type_cubit.dart';

abstract class AssetTypeState {
  const AssetTypeState();
}

class AssetTypeInitial extends AssetTypeState {}

class AssetTypeIdentifyingState extends AssetTypeState {}

class AssetTypeIdentifiedState extends AssetTypeState {
  final AssetType type;
  final File file;

  const AssetTypeIdentifiedState(this.type, this.file);
}
