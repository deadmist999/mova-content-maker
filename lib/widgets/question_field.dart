import 'package:flutter/material.dart';

import 'package:mova_content_maker/utils/app_dimensions.dart';
import 'package:mova_content_maker/utils/constants.dart';

class QuestionField extends StatelessWidget {
  final TextEditingController questionController;

  const QuestionField({super.key, required this.questionController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          AppDimensions.horizontalPadding16 + AppDimensions.verticalPadding16,
      child: TextFormField(
        maxLength: Constants.maxQuestionLength,
        decoration: InputDecoration(
          labelText: 'Питання вікторини',
          hintText: 'Уведіть питання вікторини',
          border: OutlineInputBorder(
            borderRadius: AppDimensions.borderRadius8,
            borderSide: const BorderSide(),
          ),
        ),
        controller: questionController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Уведіть питання вікторини';
          }
          return null;
        },
      ),
    );
  }
}
