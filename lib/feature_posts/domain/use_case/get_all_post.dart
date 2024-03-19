
import 'package:dartz/dartz.dart';
import 'package:posts_app/feature_posts/domain/repo/post_repository.dart';

import '../../../core/error/failures.dart';
import '../entities/post.dart';



class GetAllPostUseCase
{
  final PostRepository repository;

  GetAllPostUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async
  {
    return await repository.getAllPost();
  }
}