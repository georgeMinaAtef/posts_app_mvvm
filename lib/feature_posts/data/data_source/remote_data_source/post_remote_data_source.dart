

import 'package:dartz/dartz.dart';
import 'package:posts_app/feature_posts/data/model/model.dart';

abstract class PostRemoteDataSource
{
  Future<List<PostModel>> getAllPost();
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}


