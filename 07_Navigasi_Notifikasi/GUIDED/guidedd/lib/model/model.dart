// Model for an album returned by JSON APIs
class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId, 
    required this.id, 
    required this.title});

  // Robust JSON factory: accepts either 'userId' or 'user_id' keys and
  // handles numeric values represented as ints or strings.
  factory Album.fromJson(Map<String, dynamic> json) {
  return Album(
      userId: json['user_id'],
      id: json['id'],
      title: json['title'],
    );
  }
}