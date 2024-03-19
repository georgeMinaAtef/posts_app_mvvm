
// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:posts_app/feature_posts/data/data_source/local_data_source/post_local_data_source.dart';
import 'package:posts_app/feature_posts/data/model/model.dart';

const CACHED_POSTS = 'CACHED_POSTS';


class PostLocalDataSourceImpl  implements PostLocalDataSource
{
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<Unit> cachePosts(List<PostModel> postModel) {
   List postModelToJson = postModel
       .map<Map<String,dynamic>>((postModel) =>
       postModel.toJson()).toList();

   sharedPreferences.setString(CACHED_POSTS, json.encode(postModelToJson));

   return Future.value(unit);
  }



  @override
  Future<List<PostModel>> getCachePosts() {
   final jsonString = sharedPreferences.getString(CACHED_POSTS);

   if(jsonString != null)
     {
       List decodeJsonData = json.decode(jsonString);
       List<PostModel>  jsonToPostModels = decodeJsonData
           .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
           .toList();

       return Future.value(jsonToPostModels);
     }

   else
     {
       throw EmptyCacheException();
     }
  }

}