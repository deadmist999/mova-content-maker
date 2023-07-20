import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mova_content_maker/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:mova_content_maker/utils/app_dimensions.dart';
import 'package:mova_content_maker/widgets/explanation_field.dart';
import 'package:mova_content_maker/widgets/option_field.dart';
import 'package:mova_content_maker/widgets/question_field.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _formKey = GlobalKey<FormState>();

  final _questionController = TextEditingController();

  final _explanationController = TextEditingController();

  List<TextEditingController> controllers = [];

  int correctAnswerId = -1;
  Icon correctAnswerIcon = const Icon(Icons.circle);
  Icon incorrectAnswerIcon = const Icon(Icons.circle_outlined);

  @override
  void initState() {
    super.initState();
    addOptionField();
  }

  @override
  void dispose() {
    super.dispose();
    for (final controller in controllers) {
      controller.dispose();
    }
    _questionController.dispose();

    _explanationController.dispose();
  }

  void addOptionField() {
    if (controllers.length != 10) {
      final controller = TextEditingController();
      setState(() {
        controllers.add(controller);
      });
    }
  }

  void removeOptionField() {
    setState(() {
      if (controllers.length > 1) {
        controllers.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Створення вікторини'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              QuestionField(questionController: _questionController),
              for (int i = 0; i < controllers.length; i++)
                OptionField(
                  controller: controllers[i],
                  onChangedTextField: (value) {
                    if (value.isNotEmpty && i == controllers.length - 1) {
                      addOptionField();
                    } else if (value.isEmpty && i == controllers.length - 2) {
                      removeOptionField();
                    }
                  },
                  icon: correctAnswerId == i
                      ? correctAnswerIcon
                      : incorrectAnswerIcon,
                  onPressedIcon: () {
                    setState(() {
                      correctAnswerId = i;
                    });
                  },
                ),
              ExplanationField(controller: _explanationController),
              BlocConsumer<QuizBloc, QuizState>(
                listener: (context, state) {
                  if (state is QuizErrorState) {
                    Fluttertoast.showToast(
                        msg: state.message,
                        backgroundColor: Colors.red,
                        textColor: Colors.black);
                  }
                  if (state is QuizUploadedState) {
                    Fluttertoast.showToast(
                        msg: state.message,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                  }
                },
                builder: (context, state) {
                  if (state is QuizUploadingState) {
                    return const CircularProgressIndicator();
                  }
                  return Container(
                    height: kTextTabBarHeight,
                    width: double.infinity,
                    padding: AppDimensions.horizontalPadding16,
                    margin: AppDimensions.verticalPadding16,
                    child: ElevatedButton(
                        child: const Icon(Icons.send),
                        onPressed: () {
                          if (correctAnswerId != -1) {
                            if (_formKey.currentState!.validate()) {
                              Map<String, bool> options = {};

                              for (int i = 0; i < controllers.length; i++) {
                                options[controllers[i].text] =
                                    (i == correctAnswerId);
                              }
                              options.removeWhere((key, value) => key.isEmpty);

                              context.read<QuizBloc>().add(UploadQuizEvent(
                                  _questionController.text,
                                  options,
                                  _explanationController.text));
                              Navigator.pop(context);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Оберіть правильну відповідь');
                          }
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
