


// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/feature_posts/data/data_source/remote_data_source/post_remote_data_source.dart';

import '../../model/model.dart';
import 'package:http/http.dart' as http;


const BASE_URL = "https://jsonplaceholder.typicode.com";


class PostRemoteDataSourceImpl implements  PostRemoteDataSource
{

  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});


  @override
  Future<List<PostModel>> getAllPost()async {
   final response = await client.get(
     Uri.parse('$BASE_URL/posts/'),
     headers:
     {
       "Content-Type":"application/json"
     }
   );


   if(response.statusCode == 200)
     {
       final List decodeJson = json.decode(response.body) as List;
       final List<PostModel> postModels = decodeJson
           .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
           .toList();

       return postModels;
     }
   else
     {
       throw ServerException();
     }
  }




  @override
  Future<Unit> addPost(PostModel postModel)async {
    final body =
        {
          'title':postModel.title,
          'body':postModel.body,
        };

    final response = await client.post(Uri.parse('$BASE_URL/posts/'), body:body);

    if(response.statusCode == 201)
      {
        return Future.value(unit);
      }

    else
      {
        throw ServerException();
      }
  }



  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse('$BASE_URL/posts/${postId.toString()}'),
        headers:
        {
          "Content-Type":"application/json"
        }
    );

    if(response.statusCode == 200)
      {
        return Future.value(unit);
      }
    else
      {
        throw ServerException();
      }
  }




  @override
  Future<Unit> updatePost(PostModel postModel)async {
  final postId = postModel.id;

  final body =
  {
    'title':postModel.title,
    'body':postModel.body,
  };
  
  final response = await client.patch(Uri.parse(Uri.parse('$BASE_URL/posts/$postId') as String), body:body);

  if(response.statusCode == 200)
    {
      return Future.value(unit);
    }
  else
    {
      throw ServerException();
    }

  }


}