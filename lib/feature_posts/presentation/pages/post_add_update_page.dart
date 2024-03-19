
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/feature_posts/presentation/add_delete_update_post_bloc/add_delete_update_post_state.dart';
import 'package:posts_app/feature_posts/presentation/add_delete_update_post_bloc/add_delete_update_posts_bloc.dart';
import 'package:posts_app/feature_posts/presentation/pages/posts_page.dart';
import 'package:posts_app/feature_posts/presentation/widget/post_add_update_page/form_widget.dart';

import '../../../core/util/snackbar_message.dart';
import '../../domain/entities/post.dart';

class PostAddUpdatePage extends StatelessWidget {
  const PostAddUpdatePage({super.key,  this.post, required this.isUpdatePost});

  final Post? post;
  final bool isUpdatePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppBar(),

      body: _buildBody(context),
    );
  }



  AppBar _buildAppBar()
  {
    return AppBar(title: isUpdatePost ? const Text('Update Post') : const Text('Add Post'),);
  }



  Widget _buildBody(BuildContext context)
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc,AddDeleteUpdatePostState>(
          listener: (context, state)
          {
            if (state is MessageAddDeleteUpdatePostState)
            {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                      (route) => false);
            }

            else if (state is ErrorAddDeleteUpdatePostState)
            {
              SnackBarMessage().showErrorSnackBar(
                  message: state.message, context: context);
            }
          },
          builder: (context, state)
          {
            if(state is LoadingAddDeleteUpdatePostState)
              {
                return const LoadingWidget();
              }

            return FormWidget(
                isUpdatePost: isUpdatePost,
                post: isUpdatePost? post : null
            );
          },
        ),
      ),
    );
  }
}
