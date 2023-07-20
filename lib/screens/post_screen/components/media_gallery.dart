import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mova_content_maker/bloc/asset_selection_cubit/asset_selection_cubit.dart';
import 'package:mova_content_maker/bloc/assets_type_cubit/asset_type_cubit.dart';
import 'package:mova_content_maker/bloc/post_bloc/post_bloc.dart';
import 'package:mova_content_maker/screens/post_screen/components/gallery_entity_factory.dart';
import 'package:mova_content_maker/utils/app_dimensions.dart';
import 'package:mova_content_maker/widgets/image_caption_field.dart';
import 'package:photo_manager/photo_manager.dart';

import 'media_viewer.dart';

class ImageGallery extends StatefulWidget {
  final List<AssetEntity> assets;
  final List<File> files;

  const ImageGallery({Key? key, required this.assets, required this.files})
      : super(key: key);

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late AssetSelectionCubit _selectionCubit;
  final _assetTypeCubitMap = AssetTypeCubitMap();

  final _captionTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectionCubit = context.read<AssetSelectionCubit>();
    for (final asset in widget.assets) {
      _assetTypeCubitMap.getCubitForAsset(asset).identifyAssetType(asset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: AppDimensions.height32,
            child: Icon(Icons.keyboard_arrow_up),
          ),
          const Divider(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: widget.assets.length,
              itemBuilder: (context, index) {
                final file = widget.files[index];
                final asset = widget.assets[index];
                return BlocBuilder<AssetTypeCubit, AssetTypeState>(
                  bloc: _assetTypeCubitMap.getCubitForAsset(asset),
                  builder: (context, state) {
                    AssetType type = AssetType.other;
                    if (state is AssetTypeIdentifiedState) {
                      type = state.type;
                    }

                    return GestureDetector(
                      onTap: () {
                        _navigateToMediaViewer(file, type);
                      },
                      child: GridTile(
                        header: Align(
                          alignment: Alignment.centerRight,
                          child: BlocBuilder<AssetSelectionCubit,
                              List<AssetEntity>>(
                            bloc: _selectionCubit,
                            builder: (context, list) {
                              if (list.contains(asset)) {
                                return IconButton(
                                    onPressed: () {
                                      _selectionCubit.unselectImage(asset);
                                    },
                                    icon: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(Icons.circle),
                                        Text(
                                          (list.indexOf(asset) + 1).toString(),
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ],
                                    ));
                              }
                              return IconButton(
                                  onPressed: () {
                                    _selectionCubit.selectImage(asset);
                                  },
                                  icon: const Icon(Icons.circle_outlined));
                            },
                          ),
                        ),
                        child:
                            BlocBuilder<AssetSelectionCubit, List<AssetEntity>>(
                          bloc: _selectionCubit,
                          builder: (context, state) {
                            Color color;
                            if (state.contains(asset)) {
                              color = Colors.black.withOpacity(0.5);
                            } else {
                              color = Colors.transparent;
                            }
                            return GalleryEntityFactory(
                              asset: asset,
                              color: color,
                              file: file,
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<AssetSelectionCubit, List<AssetEntity>>(
        bloc: _selectionCubit,
        builder: (context, assets) {
          if (assets.isEmpty) {
            return const SizedBox();
          }
          return FloatingActionButton(
            onPressed: () {
              context.read<PostBloc>().add(UploadAssetsEvent(
                    assets: assets,
                    caption: _captionTextController.text,
                  ));

              _selectionCubit.clearSelection();
              Navigator.pop(context);
            },
            child: const Icon(Icons.send),
          );
        },
      ),
      bottomSheet: BlocBuilder<AssetSelectionCubit, List<AssetEntity>>(
        bloc: _selectionCubit,
        builder: (context, state) {
          if (state.isEmpty) {
            return const SizedBox();
          }
          return ImageCaptionField(controller: _captionTextController);
        },
      ),
    );
  }

  Future<void> _navigateToMediaViewer(File file, AssetType type) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MediaViewer(
            mediaFile: file,
            type: type,
          ),
        ),
      );
}
