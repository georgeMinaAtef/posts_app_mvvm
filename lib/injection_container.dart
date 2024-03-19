import 'package:posts_app/feature_posts/data/data_source/local_data_source/post_local_data_source.dart';
import 'package:posts_app/feature_posts/data/data_source/local_data_source/post_local_data_source_impl.dart';
import 'package:posts_app/feature_posts/data/data_source/remote_data_source/post_remote_data_source.dart';
import 'package:posts_app/feature_posts/data/data_source/remote_data_source/post_remote_data_source_impl.dart';
import 'package:posts_app/feature_posts/data/repo/post_repoitory_impl.dart';
import 'package:posts_app/feature_posts/domain/repo/post_repository.dart';
import 'package:posts_app/feature_posts/domain/use_case/add_post.dart';
import 'package:posts_app/feature_posts/domain/use_case/delete_post.dart';
import 'package:posts_app/feature_posts/domain/use_case/get_all_post.dart';
import 'package:posts_app/feature_posts/presentation/add_delete_update_post_bloc/add_delete_update_posts_bloc.dart';
import 'package:posts_app/feature_posts/presentation/bloc_posts/posts_bloc.dart';

import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature_posts/domain/use_case/update_post.dart';


final sl = GetIt.instance;


Future<void> init() async
{

  // feature posts




  // bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl()
  ));




  // uses cases
  sl.registerLazySingleton(() => GetAllPostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));



  // repository
  sl.registerLazySingleton< PostRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl()
  ));



  // data sources
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));




  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));



  // external
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}