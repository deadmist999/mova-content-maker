part of 'assets_cubit.dart';

abstract class AssetsState extends Equatable {
  const AssetsState();

  @override
  List<Object> get props => [];
}

class AssetsInitial extends AssetsState {}

class FetchedAssetsState extends AssetsState {
  final List<AssetEntity> assets;
  final List<File> files;

  const FetchedAssetsState(this.assets, this.files);
}

class AssetsErrorState extends AssetsState {
  final String message;

  const AssetsErrorState(this.message);
}