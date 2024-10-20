import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../core/nerwork/dio_client.dart';
import '../../data/models/post_model.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/repositories/post_repository.dart';

final postProvider = StateNotifierProvider<PostNotifier, AsyncValue<List<PostModel>>>((ref) {
  return PostNotifier();
});

class PostNotifier extends StateNotifier<AsyncValue<List<PostModel>>> {
  late final DioClient _dioClient;
  late final PostRepository _postRepository;

  PostNotifier() : super(const AsyncValue.loading()) {
    _initializeDependencies();
    loadPosts();
  }

  void _initializeDependencies() {
    final dio = Dio();
    _dioClient = DioClient(dio);
    _postRepository = PostRepositoryImpl(_dioClient);
  }

  Future<void> loadPosts() async {
    state = const AsyncValue.loading();
    final result = await _postRepository.getPosts();
    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (posts) => AsyncValue.data(posts),
    );
  }

  void deletePost(int id) {
    state.whenData((posts) {
      state = AsyncValue.data(posts.where((post) => post.id != id).toList());
    });
  }

  Future<void> toggleOpacity(int id) async {
    state.whenData((posts) {
      state = AsyncValue.data(posts.map((post) {
        if (post.id == id) {
          return post.copyWith(isLoading: true);
        }
        return post;
      }).toList());
    });
    await Future.delayed(const Duration(milliseconds: 400));
    state.whenData((posts) {
      state = AsyncValue.data(posts.map((post) {
        if (post.id == id) {
          return post.copyWith(
            isLoading: false,
            isReducedOpacity: !post.isReducedOpacity,
          );
        }
        return post;
      }).toList());
    });
  }
}
