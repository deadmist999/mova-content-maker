import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mova_content_maker/bloc/post_bloc/post_bloc.dart';
import 'package:mova_content_maker/bloc/post_message_cubit/post_message_cubit.dart';
import 'package:mova_content_maker/utils/app_dimensions.dart';

class PostField extends StatelessWidget {
  final TextEditingController controller;

  const PostField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: AppDimensions.horizontalPadding48,
      child: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostUploadedState) {
            controller.clear();
          }
        },
        child: TextFormField(
          minLines: 1,
          maxLines: 5,
          onChanged: (msg) {
            if (msg.isEmpty) {
              return context.read<PostMessageCubit>().clearedPostTextField();
            }
            context.read<PostMessageCubit>().changedPostTextField(msg);
          },
          decoration: InputDecoration(
            hintText: 'Повідомлення',
            border: OutlineInputBorder(
              borderRadius: AppDimensions.borderRadius8,
              borderSide: const BorderSide(),
            ),
          ),
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Уведіть повідомлення, яке хочете надіслати';
            }
            return null;
          },
        ),
      ),
    );
  }
}
