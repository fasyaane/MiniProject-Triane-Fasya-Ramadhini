
class Note {
  final String id;
  final String title;
  final String content;
  final String timestamp;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
