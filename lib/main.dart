import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mova_content_maker/bloc/assets_type_cubit/asset_type_cubit.dart';
import 'package:mova_content_maker/bloc/post_message_cubit/post_message_cubit.dart';

import 'package:mova_content_maker/screens/home_screen/home_screen.dart';

import 'bloc/asset_selection_cubit/asset_selection_cubit.dart';
import 'bloc/assets_cubit/assets_cubit.dart';
import 'bloc/post_bloc/post_bloc.dart';
import 'bloc/post_image_caption_cubit/post_image_caption_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AssetsCubit()),
        BlocProvider(create: (_) => PostMessageCubit()),
        BlocProvider(create: (_) => PostImageCaptionCubit()),
        BlocProvider(create: (_) => AssetTypeCubit()),
        BlocProvider(create: (_) => AssetSelectionCubit()),
        BlocProvider(create: (_) => PostBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
