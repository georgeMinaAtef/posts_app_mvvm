
import 'package:dartz/dartz.dart';
import 'package:posts_app/feature_posts/data/model/model.dart';

abstract class PostLocalDataSource
{
  Future<List<PostModel>> getCachePosts();
  Future<Unit> cachePosts(List<PostModel> postModel);
}