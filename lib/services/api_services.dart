import 'package:dio/dio.dart';
import 'package:monolithia/models/comment_model.dart';
import 'package:monolithia/models/post_model.dart';
import 'package:monolithia/models/user_model.dart';

class ApiService {
  Dio dioService = Dio();

  String baseUrl(String endPoint) {
    String baseUrl = 'https://jsonplaceholder.typicode.com/$endPoint';
    return baseUrl;
  }

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await dioService.get(baseUrl('users'));
      print(response.data);
      final rawData = response.data;
      List<UserModel> userData = [];
      if (response.statusCode == 200) {
        for (var element in rawData) {
          userData.add(UserModel.fromJson(element));
        }
        return userData;
      } else {
        print(response.statusCode.toString());
      }
    } on DioException catch (e) {
      throw e.message.toString();
    }
    throw Exception('FAILED');
  }

  Future<List<PostModel>> fetchPosts([int? id]) async {
    try {
      final response = await dioService.get(baseUrl('posts'));
      print(response.data);
      final rawData = response.data;
      List<PostModel> userData = [];
      if (response.statusCode == 200) {
        for (var element in rawData) {
          userData.add(PostModel.fromJson(element));
        }
        return userData;
      } else {
        print(response.statusCode.toString());
      }
    } on DioException catch (e) {
      throw e.message.toString();
    }
    throw Exception('FAILED');
  }

  Future<void> deletePost(int id) async {
    try {
      final response = await dioService.delete(baseUrl('posts/$id'));
      print(response.data);
      print(response.statusCode.toString());
    } on DioException catch (e) {
      print(e.message);
    }
  }

  Future<List<CommentModel>> fetchComment(int id) async {
    try {
      final response = await dioService.get(baseUrl('posts/$id/comments'));
      print(response.data);
      final rawData = response.data;
      List<CommentModel> userData = [];
      if (response.statusCode == 200) {
        for (var element in rawData) {
          userData.add(CommentModel.fromJson(element));
        }
        return userData;
      } else {
        print(response.statusCode.toString());
      }
    } on DioException catch (e) {
      throw e.message.toString();
    }
    throw Exception('FAILED');
  }

  createPost(int userId, int id, String title, String postBody) async {
    try {
      Map<String, dynamic> body = {
        "userId": userId,
        "id": id,
        "title": title,
        "body": postBody
      };
      final response = await dioService.post(baseUrl('posts'), data: body);
      print(response.data);
      print(response.statusCode);
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}
