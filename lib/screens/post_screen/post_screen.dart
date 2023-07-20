import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mova_content_maker/bloc/asset_selection_cubit/asset_selection_cubit.dart';
import 'package:mova_content_maker/bloc/assets_cubit/assets_cubit.dart';
import 'package:mova_content_maker/bloc/post_bloc/post_bloc.dart';
import 'package:mova_content_maker/bloc/post_message_cubit/post_message_cubit.dart';
import 'package:mova_content_maker/widgets/post_field.dart';
import 'package:photo_manager/photo_manager.dart';

import 'components/confirmation_dialog.dart';
import 'components/media_gallery.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Створення поста'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              PostField(controller: postTextController),
              BlocListener<AssetsCubit, AssetsState>(
                listener: (context, state) {
                  if (state is AssetsErrorState) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                  if (state is FetchedAssetsState) {
                    showModalBottomSheetGalleryWithConfirmation(
                      context: context,
                      assets: state.assets,
                      files: state.files,
                    );
                  }
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<PostMessageCubit, String>(
                    builder: (context, message) {
                      if (message.isNotEmpty) {
                        return IconButton(
                            onPressed: () {
                              context
                                  .read<PostBloc>()
                                  .add(UploadPostMessageEvent(message));
                              context
                                  .read<PostMessageCubit>()
                                  .clearedPostTextField();
                            },
                            icon: const Icon(Icons.send));
                      }
                      return IconButton(
                        onPressed: () async {
                          await context.read<AssetsCubit>().fetchAssets();
                        },
                        icon: const Icon(Icons.photo),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showModalBottomSheetGalleryWithConfirmation({
    required BuildContext context,
    required List<AssetEntity> assets,
    required List<File> files,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocBuilder<AssetSelectionCubit, List<AssetEntity>>(
            builder: (context, state) {
              if (state.isEmpty) {
                return ImageGallery(assets: assets, files: files);
              }
              return WillPopScope(
                onWillPop: () async {
                  bool shouldClose = false;
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        onClosePressed: () {
                          context.read<AssetSelectionCubit>().clearSelection();
                          shouldClose = true;
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                  return shouldClose;
                },
                child: ImageGallery(assets: assets, files: files),
              );
            },
          );
        });
  }
}
