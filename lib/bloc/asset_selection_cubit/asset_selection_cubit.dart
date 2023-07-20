import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

part 'asset_selection_state.dart';

class AssetSelectionCubit extends Cubit<List<AssetEntity>> {
  AssetSelectionCubit() : super([]);

  void selectImage(AssetEntity asset) {
    state.add(asset);
    emit(List.from(state));
  }

  void unselectImage(AssetEntity asset) {
    state.remove(asset);
    emit(List.from(state));
  }

  void clearSelection() {
    emit([]);
  }
}
