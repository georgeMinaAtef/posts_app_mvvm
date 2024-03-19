

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:posts_app/feature_posts/domain/entities/post.dart';

abstract class AddDeleteUpdatePostsEvent extends Equatable
{
  const AddDeleteUpdatePostsEvent();

  @override
  List<Object> get props =>  [];
}



class AddPostsEvent extends AddDeleteUpdatePostsEvent
{
  final Post post;

  const AddPostsEvent({required this.post});

  @override
  List<Object> get props =>  [post];
}



class DeletePostsEvent extends AddDeleteUpdatePostsEvent
{

  final int postID;
  const DeletePostsEvent({required this.postID});

  @override
  List<Object> get props =>  [postID];
}



class UpdatePostsEvent extends AddDeleteUpdatePostsEvent
{
  final Post post;

  const UpdatePostsEvent({required this.post});

  @override
  List<Object> get props =>  [post];
}