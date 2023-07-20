import 'package:flutter/material.dart';
import 'package:mova_content_maker/utils/app_dimensions.dart';
import 'package:mova_content_maker/utils/constants.dart';

class ExplanationField extends StatelessWidget {
  final TextEditingController controller;
  const ExplanationField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      AppDimensions.horizontalPadding16 + AppDimensions.verticalPadding16,
      child: TextField(
        controller: controller,
        maxLength: Constants.maxOptionLength,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          counterText: 'Необовʼязково',
          hintText: 'Уведіть пояснення до питання',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: AppDimensions.borderRadius8,
          ),
        ),
      ),
    );
  }
}
