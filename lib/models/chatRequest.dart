class ChatRequest {
  final String senderId;
  final String receiverId;
  final String message;

  ChatRequest({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
    };
  }
}
