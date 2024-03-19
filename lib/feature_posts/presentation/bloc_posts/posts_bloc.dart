

// ignore_for_file: type_literal_in_constant_pattern

import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/feature_posts/domain/entities/post.dart';
import 'package:posts_app/feature_posts/domain/use_case/get_all_post.dart';
import 'package:posts_app/feature_posts/presentation/bloc_posts/posts_event.dart';
import 'package:posts_app/feature_posts/presentation/bloc_posts/posts_state.dart';
import '../../../core/error/failures.dart';
import '../../../core/strings/failures.dart';


class PostsBloc extends Bloc<PostsEvent, PostsState>
{

  final GetAllPostUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}): super(PostsInitial())
  {
    on<PostsEvent>((event, emit) async
    {

      if(event is GetAllPostsEvent)
        {
          emit(LoadingPostsState());
          // final posts = await getAllPosts;  OR
          final failureOrPosts = await getAllPosts.call();
          emit(_mapFailureOrPostsToState(failureOrPosts));
        }

      else if (event is RefreshAllPostsEvent)
        {
          emit(LoadingPostsState());
          // final posts = await getAllPosts;  OR
          final failureOrPosts = await getAllPosts.call();
          emit(_mapFailureOrPostsToState(failureOrPosts));
        }
    }) ;
  }




  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either)
  {
    return either.fold(
            (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)) ,
            (posts) => LoadedPostsState(posts: posts)
    );
  }





  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}