import 'package:my_chat/model/user.dart';

class GroupModel {
  String? id;
  String? name;
  String? description;
  String? profileUrl;
  List<UserModel>? members;
  String? createdAt;
  String? createdBy;
  String? status;
  String? lastMessage;
  String? lastMessageTime;
  String? lastMessageBy;
  String? timeStamp;
  int unReadCount;

  GroupModel({
    this.id,
    this.name,
    this.description,
    this.profileUrl,
    this.members,
    this.createdAt,
    this.createdBy,
    this.status,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageBy,
    this.timeStamp,
    this.unReadCount = 0,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      profileUrl: json['profileUrl'],
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      status: json['status'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
      lastMessageBy: json['lastMessageBy'],
      timeStamp: json['timeStamp'],
      unReadCount: json['unReadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'profileUrl': profileUrl,
      'members': members?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'createdBy': createdBy,
      'status': status,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessageBy': lastMessageBy,
      'timeStamp': timeStamp,
      'unReadCount': unReadCount,
    };
  }
}
