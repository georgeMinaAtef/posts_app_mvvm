

import 'package:equatable/equatable.dart';
import 'package:posts_app/feature_posts/domain/entities/post.dart';

abstract class AddDeleteUpdatePostState extends Equatable
{
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props =>  [];
}


class AddDeleteUpdateInitialPostState extends AddDeleteUpdatePostState {}


class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState {}


class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState
{
  final String message;

  const ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props =>  [message];
}


class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState
{
  final String message;

  const MessageAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props =>  [message];
}



