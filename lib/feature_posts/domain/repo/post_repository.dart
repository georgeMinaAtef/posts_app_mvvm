
import 'package:dartz/dartz.dart';
import 'package:posts_app/feature_posts/domain/entities/post.dart';
import '../../../core/error/failures.dart';



abstract class PostRepository
{
  Future<Either<Failure, List<Post>>> getAllPost();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}