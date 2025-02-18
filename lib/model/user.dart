class UserModel {
  String? id;
  String? name;
  String? email;
  String? userProfileUrl;
  String? phoneNumber;
  String? about;
  String? createdAt;
  String? role;
  String? status;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.userProfileUrl,
    this.phoneNumber,
    this.about,
    this.role,
    this.createdAt,
    this.status,
  });

  // Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userProfileUrl: json['userProfileUrl'],
      phoneNumber: json['phoneNumber'],
      about: json['about'],
      createdAt: json['createdAt'],
      role: json['role'],
      status: json['status'], // Added status
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userProfileUrl': userProfileUrl,
      'phoneNumber': phoneNumber,
      'about': about,
      'createdAt': createdAt,
      'role': role,
      'status': status, // Added status
    };
  }
}
