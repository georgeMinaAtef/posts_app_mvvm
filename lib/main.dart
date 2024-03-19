import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/app_theme.dart';
import 'package:posts_app/feature_posts/presentation/bloc_posts/posts_bloc.dart';
import 'package:posts_app/feature_posts/presentation/bloc_posts/posts_event.dart';
import 'package:posts_app/feature_posts/presentation/pages/posts_page.dart';
import 'package:posts_app/injection_container.dart' as di;

import 'feature_posts/presentation/add_delete_update_post_bloc/add_delete_update_posts_bloc.dart';

void main()  async{
  WidgetsFlutterBinding .ensureInitialized();
  await di.init();
  
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key,});



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const PostsPage()
      ),
    );
  }
}
