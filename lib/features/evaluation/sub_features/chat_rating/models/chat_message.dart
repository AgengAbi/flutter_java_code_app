// ignore_for_file: file_names

class ChatMessage {
  final String sender;
  final String? text;
  final String? imagePath;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    this.text,
    this.imagePath,
    required this.timestamp,
  });
}
