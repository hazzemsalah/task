import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../data/models/post_model.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>>> getPosts();
}
