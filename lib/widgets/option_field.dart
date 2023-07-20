import 'package:flutter/material.dart';

import 'package:mova_content_maker/utils/app_dimensions.dart';
import 'package:mova_content_maker/utils/constants.dart';

class OptionField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChangedTextField;
  final Icon icon;
  final void Function() onPressedIcon;

  const OptionField({
    Key? key,
    required this.controller,
    required this.onChangedTextField,
    required this.icon,
    required this.onPressedIcon,
  }) : super(key: key);

  static const correctAnswerIcon = Icon(Icons.circle);
  static const incorrectAnswerIcon = Icon(Icons.circle_outlined);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          AppDimensions.horizontalPadding16 + AppDimensions.verticalPadding16,
      child: TextField(
        controller: controller,
        maxLength: Constants.maxOptionLength,
        onChanged: (value) {
          onChangedTextField(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          hintText: 'Уведіть варіант відповіді',
          prefixIcon: IconButton(
            onPressed: onPressedIcon,
            icon: icon,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: AppDimensions.borderRadius8,
          ),
        ),
      ),
    );
  }
}
