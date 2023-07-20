import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mova_content_maker/bloc/post_bloc/post_bloc.dart';
import 'package:mova_content_maker/bloc/post_image_caption_cubit/post_image_caption_cubit.dart';
import 'package:mova_content_maker/utils/app_dimensions.dart';

class ImageCaptionField extends StatelessWidget {
  final TextEditingController controller;

  const ImageCaptionField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppDimensions.horizontalPadding48,
      child: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostUploadedState) {
            controller.clear();
          }
        },
        child: TextField(
          minLines: 1,
          maxLines: 4,
          onChanged: (msg) {
            if (msg.isEmpty) {
              return context
                  .read<PostImageCaptionCubit>()
                  .clearedCaptionField();
            }
            context.read<PostImageCaptionCubit>().changedCaptionField(msg);
          },
          decoration: const InputDecoration(
            hintText: 'Додати опис...',
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
