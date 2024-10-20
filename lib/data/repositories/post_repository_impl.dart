import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/error/failure.dart';
import '../../core/nerwork/dio_client.dart';
import '../models/post_model.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final DioClient _dioClient;

  PostRepositoryImpl(this._dioClient);

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    try {
      final response = await _dioClient.get('posts');
      final List data = response.data;
      final posts = data.map((json) => PostModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
      )).toList();
      return Right(posts);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(NetworkFailure('No internet connection'));
      } else {
        return Left(ServerFailure('Failed to fetch posts: ${e.message}'));
      }
    } catch (e) {
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }
}