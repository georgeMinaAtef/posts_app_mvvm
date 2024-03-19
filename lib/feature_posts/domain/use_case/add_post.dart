
import 'package:dartz/dartz.dart';
import 'package:posts_app/feature_posts/domain/repo/post_repository.dart';

import '../../../core/error/failures.dart';
import '../entities/post.dart';



class AddPostUseCase
{
  final PostRepository repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async
  {
    return await repository.addPost(post);
  }
}