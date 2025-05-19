import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc_flutter/model/post_model_list.dart';

class PostRepository {
  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await http
          .get(
            Uri.parse('https://jsonplaceholder.typicode.com/comments'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body.map((e) {
          return PostModel(
            postId: e['postId'] as int,
            id: e['id'] as int,
            name: e['name'] as String,
            email: e['email'] as String,
            body: e['body'] as String,
          );
        }).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection.');
    } on TimeoutException {
      throw Exception('The connection has timed out. Please try again.');
    } catch (e) {
      throw Exception('Error while fetching data: $e');
    }
  }
}
