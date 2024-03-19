
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/feature_posts/data/data_source/local_data_source/post_local_data_source.dart';
import 'package:posts_app/feature_posts/data/data_source/remote_data_source/post_remote_data_source.dart';
import 'package:posts_app/feature_posts/data/model/model.dart';
import 'package:posts_app/feature_posts/domain/entities/post.dart';
import 'package:posts_app/feature_posts/domain/repo/post_repository.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();


class PostRepositoryImpl implements PostRepository
{

   final PostRemoteDataSource remoteDataSource;
   final PostLocalDataSource localDataSource;
   final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});


  @override
  Future<Either<Failure, List<Post>>> getAllPost() async{
    if(await networkInfo.isConnected)
      {
        try
        {
          final remotePosts = await remoteDataSource.getAllPost();
          localDataSource.cachePosts(remotePosts);
          return Right(remotePosts);
        }
        on ServerException
        {
          return Left(ServerFailure());
        }
      }
    else
      {
        try
            {
              final localPost = await localDataSource.getCachePosts();
              return Right(localPost);
            }
        on EmptyCacheException
        {
          return Left(EmptyCacheFailure());
        }
      }
  }


  @override
  Future<Either<Failure, Unit>> addPost(Post post) async
  {
   final PostModel postModel = PostModel( title: post.title, body: post.body);
   return _getMessage(() async{
     return await remoteDataSource.addPost(postModel);
   });

  }



  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {

    return _getMessage(() async{
      return await remoteDataSource.deletePost(postId);
    });

  }



  @override
  Future<Either<Failure, Unit>> updatePost(Post post)async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return _getMessage(() async{
      return await remoteDataSource.updatePost(postModel);
    });

  }



  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost)async
  {
    if(await networkInfo.isConnected)
    {
      try
      {
        deleteOrUpdateOrAddPost;
        return const Right(unit);
      }
      on ServerException
      {
        return Left(ServerFailure());
      }
    }
    else
    {
      return Left(OfflineFailure());
    }
  }
}