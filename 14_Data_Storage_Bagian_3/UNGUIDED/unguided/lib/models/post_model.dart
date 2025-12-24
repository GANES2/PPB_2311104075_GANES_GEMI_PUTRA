class PostModel {
  final int? id;
  final String title;
  final String body;
  final int userId;

  PostModel({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}'),
        title: (json['title'] ?? '').toString(),
        body: (json['body'] ?? '').toString(),
        userId: json['userId'] is int
            ? json['userId']
            : int.tryParse('${json['userId']}') ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'userId': userId,
      };

  PostModel copyWith({int? id, String? title, String? body, int? userId}) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }
}
