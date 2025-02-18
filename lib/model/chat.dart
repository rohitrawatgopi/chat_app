class ChatModel {
  final String? id;
  final String? message;
  final String? senderName;
  final String? receiverName;
  final String? senderId;
  final String? receiverId;
  final String? timestamp;
  final String? readStatus;
  final String? imageUrl;
  final String? videoUrl;
  final String? audioUrl;
  final String? documentUrl;
  final List<String>? reactions;
  final List<ChatModel>? replies;

  ChatModel({
    this.id,
    this.message,
    this.senderName,
    this.receiverName,
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.readStatus,
    this.imageUrl,
    this.videoUrl,
    this.audioUrl,
    this.documentUrl,
    this.reactions,
    this.replies,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      message: json['message'],
      senderName: json['senderName'],
      receiverName: json['receiverName'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      timestamp: json['timestamp'],
      readStatus: json['readStatus'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      audioUrl: json['audioUrl'],
      documentUrl: json['documentUrl'],
      reactions: json['reactions'] != null
          ? List<String>.from(json['reactions'])
          : null,
      replies: json['replies'] != null
          ? (json['replies'] as List).map((e) => ChatModel.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'senderName': senderName,
      'receiverName': receiverName,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'readStatus': readStatus,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'audioUrl': audioUrl,
      'documentUrl': documentUrl,
      'reactions': reactions,
      'replies': replies?.map((e) => e.toJson()).toList(),
    };
  }
}
