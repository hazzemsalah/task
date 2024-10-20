import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/post_model.dart';
import '../providers/post_provider.dart';

class PostListItem extends ConsumerWidget {
  final PostModel post;

  const PostListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Opacity(
      opacity: post.isReducedOpacity ? 0.5 : 1.0,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    post.body,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref.read(postProvider.notifier).deletePost(post.id);
                        },
                      ),
                      Switch(
                        value: post.isReducedOpacity,
                        onChanged: (value) {
                          ref.read(postProvider.notifier).toggleOpacity(post.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              if (post.isLoading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
