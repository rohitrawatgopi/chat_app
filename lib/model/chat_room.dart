import 'package:my_chat/model/chat.dart';
import 'package:my_chat/model/user.dart';

class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? receiver;
  List<ChatModel>? messages; // Using existing ChatModel
  int? unReadMessNo;
  String? lastMessage;
  String? lastMessageTimeStamp; // Changed to String
  String? timeStamp; // Changed to String

  ChatRoomModel({
    this.id,
    this.sender,
    this.receiver,
    this.messages,
    this.unReadMessNo,
    this.lastMessage,
    this.lastMessageTimeStamp,
    this.timeStamp,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'] as String?,
      sender:
          json['sender'] != null ? UserModel.fromJson(json["sender"]) : null,
      receiver: json['receiver'] != null
          ? UserModel.fromJson(json["receiver"])
          : null,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((msg) => ChatModel.fromJson(msg))
          .toList(),
      unReadMessNo: json['unReadMessNo'] as int?,
      lastMessage: json['lastMessage'] as String?,
      lastMessageTimeStamp:
          json['lastMessageTimeStamp'] as String?, // Direct String assignment
      timeStamp: json['timeStamp'] as String?, // Direct String assignment
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender?.toJson(),
      'receiver': receiver?.toJson(),
      'messages': messages?.map((msg) => msg.toJson()).toList(),
      'unReadMessNo': unReadMessNo,
      'lastMessage': lastMessage,
      'lastMessageTimeStamp': lastMessageTimeStamp, // No conversion needed
      'timeStamp': timeStamp, // No conversion needed
    };
  }
}
