
import 'package:dartz/dartz.dart';
import 'package:posts_app/feature_posts/domain/repo/post_repository.dart';

import '../../../core/error/failures.dart';
import '../entities/post.dart';



class DeletePostUseCase
{
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async
  {
    return await repository.deletePost(postId);
  }
}