class PostModel {
  final int id;
  final String title;
  final String body;
  final bool isLoading;
  final bool isReducedOpacity;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    this.isLoading = false,
    this.isReducedOpacity = false,
  });

  PostModel copyWith({
    int? id,
    String? title,
    String? body,
    bool? isLoading,
    bool? isReducedOpacity,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isLoading: isLoading ?? this.isLoading,
      isReducedOpacity: isReducedOpacity ?? this.isReducedOpacity,
    );
  }
}
