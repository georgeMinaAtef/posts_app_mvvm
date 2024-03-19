

// ignore_for_file: type_literal_in_constant_pattern

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/strings/messages.dart';
import 'package:posts_app/feature_posts/domain/use_case/add_post.dart';
import 'package:posts_app/feature_posts/domain/use_case/delete_post.dart';
import 'package:posts_app/feature_posts/domain/use_case/update_post.dart';
import 'package:posts_app/feature_posts/presentation/add_delete_update_post_bloc/add_delete_update_event.dart';
import 'package:posts_app/feature_posts/presentation/add_delete_update_post_bloc/add_delete_update_post_state.dart';

import '../../../core/error/failures.dart';
import '../../../core/strings/failures.dart';



class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostState>
{

  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;


  AddDeleteUpdatePostBloc(
    {
      required this.addPost,
      required this.deletePost,
      required this.updatePost,
    }
):super(AddDeleteUpdateInitialPostState())
  {
    on<AddDeleteUpdatePostsEvent>((event, emit) async
    {
      if(event is AddPostsEvent)
      {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));

      }

      else if(event is DeletePostsEvent)
      {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePost(event.postID);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));

      }

      else if(event is UpdatePostsEvent)
      {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));

      }

    }) ;
  }




  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either,
      String message
      ) {
    return either.fold(
          (failure) => ErrorAddDeleteUpdatePostState(
        message: _mapFailureToMessage(failure),
      ),
          (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }


  


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}