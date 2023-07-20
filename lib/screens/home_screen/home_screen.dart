import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mova_content_maker/bloc/assets_cubit/assets_cubit.dart';
import 'package:mova_content_maker/bloc/post_bloc/post_bloc.dart';
import 'package:mova_content_maker/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:mova_content_maker/screens/post_screen/post_screen.dart';
import 'package:mova_content_maker/screens/quiz_screen/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Головна сторінка'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            actionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (_) => QuizBloc(),
                              child: const QuizScreen(),
                            ))),
                text: 'Створити вікторину'),
            actionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PostScreen(),
                    )),
                text: 'Створити пост'),
          ],
        ),
      ),
    );
  }

  Widget actionButton(
      {required void Function() onPressed, required String text}) {
    return FilledButton(onPressed: onPressed, child: Text(text));
  }
}
